require 'grape'
require 'doorkeeper/grape/helpers'

module API
  module SharedHelpers
    extend Grape::API::Helpers
    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
    def logger
      Grape::API.logger
    end
  end
  module SharedParams
    extend Grape::API::Helpers
    params :period do
      requires :start_date
      requires :end_date
    end
    params :pagination do
      requires :page, type: Integer
      requires :per_page, type: Integer
    end
  end

  class Base < Grape::API
    default_format :json
    use Rack::JSONP
    helpers Doorkeeper::Grape::Helpers
    helpers API::SharedHelpers

    mount API::Users => '/users'
    mount API::Games => '/games'
    mount API::LeaseOrders => '/lease_orders'
    mount API::PrepaidOrders => '/prepaid_orders'
    mount API::Galleries => '/galleries'
    mount API::Notifications => '/notifications'

    add_swagger_documentation(
        base_path: '/api',
        hide_documentation_path: true
    )
  end
end
