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
        Pingpp::Charge.create(
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
            @lease_order.save
            body @charge
          rescue Exception => e
            logger.error e
            error!({ error: 'unexpected error', detail: 'external payment service error' }, 500)
          end
        end
      end
    end

  end
end
