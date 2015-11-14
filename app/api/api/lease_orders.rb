require 'doorkeeper/grape/helpers'

module API
  class LeaseOrders < Grape::API
    use Rack::JSONP
    helpers Doorkeeper::Grape::Helpers
    helpers do
      def current_resource_owner
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end

      def create_charge
        Pingpp.api_key = Rails.application.secrets.pingxx_api_key
        charge = Pingpp::Charge.create(
            :order_no => @lease_order.serial_number,
            :amount => (@lease_order.total_amount*100).to_i,
            :subject => "#{@lease_order.user.username} is paying #{@lease_order.total_amount}",
            :body => "#{@lease_order.user.username} is paying #{@lease_order.total_amount}",
            :channel => 'alipay',
            :currency => 'cny',
            # :client_ip=> "#{env['REMOTE_ADDR']}",
            :client_ip => "127.0.0.1",
            :app => {:id => 'app_LWXzX9OO0i58mPqf'}
        )
        throw Exception unless charge.present?
        charge
      end

      def logger
        Grape::API.logger
      end

      def check_signature!
        digest = OpenSSL::Digest::SHA256.new
        pub_key_string = '''
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3oDH975nfRJcDoPf+933
InFRsyCX95NxvWFbQPBkwSc+0dtsbcee+1MQd3HpHkLsJ9VqmFZGbUPeXXtO/0cm
khU+h3qrO+it2iGr0gLJIJAoCy9UmCNGCLqeVQ7z8LLfhVhIKtBb6ObMq2XxrN7Q
HGQJR+CH/Rg8Bq/IUQa3kliQyGJJmDfnhiCzUZdz+KJCOQjk06cib9+W4gzptG5v
2ocU/XpTazykU+3+rUZLvOlOi5hGrVWY2ogsOe8b+LA+Out7D27J5tSJyCE2Nr/A
8SxMo2nXMz8Fci08yk3EEKFlMnCcY7wE9B0EcGdXlDBivh9wxqSy5002fGehao+g
CwIDAQAB
-----END PUBLIC KEY-----
        '''
        pub_key = OpenSSL::PKey::RSA.new(pub_key_string)
        unless pub_key.verify(digest, Base64.decode(headers['x-pingplusplus-signature']), params)
          logger.error 'receive and discard a invalid charge confirm, verify signature error'
          error!({error: 'bad signature', detail: 'signature of this charge confirm is invalid'}, 204)
        end
      end

    end

    desc 'gets the LeaseOrders'
    get "all" do
      present LeaseOrder.all, with: API::Entities::LeaseOrder
    end

    desc 'return a LeaseOrders info' do
      headers Authorization: {
                  description: 'Check Resource Owner Authorization: \'Bearer token\'',
                  required: true
              }
    end
    params do
      requires :serial_number, type: String, desc: 'LeaseOrder serial_number.'
    end
    get "info" do
      doorkeeper_authorize!
      if (declared(params, include_missing: false)).present? && current_resource_owner.present?
        @lease_order = current_resource_owner.lease_orders.find_by_serial_number(params[:serial_number])
        present @lease_order, with: API::Entities::LeaseOrder
      end
    end

    desc 'create a LeaseOrder' do
      headers Authorization: {
                  description: 'Check Resource Owner Authorization: \'Bearer token\'',
                  required: true
              }
    end
    params do
      requires :game_version_ids, type: Array[Integer], desc: 'GameVersions in a LeaseOrder.', documentation: {example: '{"game_version_ids":[1,2,3]}'}
    end
    post "create" do
      doorkeeper_authorize!
      if (declared(params, include_missing: false)).present? && current_resource_owner.present?
        game_versions = GameVersion.where(id: params[:game_version_ids])
        if game_versions.present?
          @lease_order = current_resource_owner.lease_orders.build
          @lease_order.status = 1
          @lease_order.total_amount = game_versions.pluck(:reference_price).reduce(:+)
          @lease_order.save
          game_versions.each { |gv|
            @account = @lease_order.accounts.build({game_version: gv})
            @account.save
          }
          present @lease_order, with: API::Entities::LeaseOrder
        end
      end
    end

    desc 'start a payment' do
      headers Authorization: {
                  description: 'Check Resource Owner Authorization: \'Bearer token\'',
                  required: true
              }
    end
    params do
      requires :serial_number, type: String, desc: 'LeaseOrder serial_number.'
      requires :pay_type, type: Integer, desc: 'LeaseOrder pay_type.'
    end
    post "charge" do
      doorkeeper_authorize!
      if (declared(params, include_missing: false)).present? && current_resource_owner.present?
        @lease_order = current_resource_owner.lease_orders.find_by_serial_number(params[:serial_number])
        if @lease_order.status <= 2
          @lease_order.pay_type = params[:pay_type]
          @lease_order.status = 2
          begin
            @charge = create_charge
            charge = @lease_order.charges.build(pingxx_ch_id: @charge.id, raw_data: @charge.to_json)
            charge.save
            @lease_order.save
            body @charge
          rescue Exception => e
            log.error e
            error!({error: 'unexpected error', detail: 'external payment service error'}, 500)
          end
        end
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
      if params[:type] == 'charge.succeeded'
        charge = params[:data][:object]
        charge_find_by_pingxx_ch_id = Charge.find_by_pingxx_ch_id(charge[:id])
        if charge.object == 'charge' && charge.paid == true && charge_find_by_pingxx_ch_id.present?
          lease_order = charge_find_by_pingxx_ch_id.lease_order
          if lease_order.status == 2
            lease_order.status = 3
            lease_order.save
          else
            logger.error 'receive and discard a invalid charge confirm'
            error!({error: 'lease_order error', detail: "charge confirming a invalid status=#{lease_order.status} lease_order"}, 203)
          end
        else
          logger.error 'receive and discard a invalid charge confirm'
          error!({error: 'unexpected error', detail: 'external payment service error'}, 204)
        end
      end

    end

  end
end
