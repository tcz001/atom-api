module API
  class PrepaidOrders < Grape::API
    formatter :json, API::Formatter.normal
    error_formatter :json, API::Formatter.error
    helpers do
      def create_prepaid_charge(prepaid_order)
        Pingpp.api_key = Rails.application.secrets.pingxx_api_key
        charge = Pingpp::Charge.create(
            :order_no => prepaid_order.serial_number,
            :amount => (prepaid_order.total_amount*100).to_i,
            :subject => "#{prepaid_order.user.username} is prepaying #{prepaid_order.total_amount}",
            :body => "#{prepaid_order.user.username} is prepaying #{prepaid_order.total_amount}",
            :channel => 'alipay',
            :currency => 'cny',
            :client_ip => headers['X-Real-IP'].present? ? headers['X-Real-IP'] : '127.0.0.1',
            :app => {:id => 'app_LWXzX9OO0i58mPqf'}
        )
        throw Exception unless charge.present?
        charge
      end

      def verify_signature(raw_data, signature, pub_key_path)
        rsa_public_key = OpenSSL::PKey.read(File.read(pub_key_path))
        return rsa_public_key.verify(OpenSSL::Digest::SHA256.new, Base64.decode64(signature), raw_data)
      end

      def check_signature!
        raw_data = request.body.read
        signature = headers['X-Pingplusplus-Signature']
        pub_key_path = "#{Rails.root}/config/rsa_public_key.pem"
        unless verify_signature(raw_data, signature, pub_key_path)
          logger.error 'receive and discard a invalid charge confirm, verify signature error'
          error!({error: 'bad signature', detail: 'signature of this charge confirm is invalid'}, 204)
        end
      end
    end

    desc 'gets all the PrepaidOrders of a user' do
      headers Authorization: {
          description: 'Check Resource Owner Authorization: \'Bearer token\'',
          required: true
      }
    end
    get "my" do
      doorkeeper_authorize!
      present current_resource_owner.prepaid_orders.order(updated_at: :desc), with: API::Entities::PrepaidOrder
    end

    desc 'return a PrepaidOrders info' do
      headers Authorization: {
          description: 'Check Resource Owner Authorization: \'Bearer token\'',
          required: true
      }
    end
    params do
      requires :serial_number, type: String, desc: 'PrepaidOrders serial_number.'
    end
    get "info" do
      doorkeeper_authorize!
      if (declared(params, include_missing: false)).present? && current_resource_owner.present?
        present current_resource_owner.prepaid_orders.find_by_serial_number(params[:serial_number]), with: API::Entities::PrepaidOrder
      end
    end

    desc 'start a payment' do
      headers Authorization: {
          description: 'Check Resource Owner Authorization: \'Bearer token\'',
          required: true
      }
    end
    params do
      requires :total_amount, type: BigDecimal, desc: 'PrepaidOrder amount.'
      requires :pay_type, type: Integer, desc: 'LeaseOrder pay_type.'
    end
    post "charge" do
      doorkeeper_authorize!
      if (declared(params, include_missing: false)).present? && current_resource_owner.present?
        error!({error: 'wrong amount', detail: 'the total_amount must be greater than one'}, 203) unless params[:total_amount] > 0
        prepaid_order = current_resource_owner.prepaid_orders.create(total_amount: params[:total_amount], status: 0, pay_type: params[:pay_type])
        begin
          charge = create_prepaid_charge(prepaid_order)
          prepaid_order.charges.create(pingxx_ch_id: charge.id, raw_data: charge.to_json)
          prepaid_order.save
          body charge.to_json
        rescue Exception => e
          logger.error e
          error!({error: 'unexpected error', detail: 'external payment service error'}, 500)
        end
      else
        error!({error: 'wrong params', detail: 'the params of prepaid order is invalid'}, 205)
      end
    end

    desc 'confirm a payment NOTICE: this api is not for app, but for Pingxx!' do
      headers 'x-pingplusplus-signature' => {
          description: 'Check Pingxx Signature: \'base64 RSA-SHA256 x-pingplusplus-signature\'',
          required: true
      }
    end
    params do
      optional :event, type: JSON
    end
    post "charge_confirm" do
      check_signature!
      if params.type == 'charge.succeeded'
        charge = params.data.object
        charge_find_by_pingxx_ch_id = Charge.find_by_pingxx_ch_id(charge[:id])
        if charge.object == 'charge' && charge.paid == true && charge_find_by_pingxx_ch_id.present?
          prepaid_order = charge_find_by_pingxx_ch_id.prepaid_order
          if prepaid_order.present? && prepaid_order.status == 0
            prepaid_order.user.free_balance = 0 if prepaid_order.user.free_balance.nil?
            prepaid_order.user.free_balance += prepaid_order.total_amount
            prepaid_order.user.save
            prepaid_order.status = 1
            prepaid_order.save
          else
            logger.error 'receive and discard a invalid charge confirm'
            error!({error: 'prepaid_order error', detail: "charge confirming a invalid status=#{prepaid_order.status} prepaid_order"}, 203)
          end
        else
          logger.error 'receive and discard a invalid charge confirm'
          error!({error: 'unexpected error', detail: 'external payment service error'}, 500)
        end
      end
    end
  end
end
