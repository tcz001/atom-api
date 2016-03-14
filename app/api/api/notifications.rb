module API
  class Notifications < Grape::API
    formatter :json, API::Formatter.normal
    error_formatter :json, API::Formatter.error
    helpers SharedParams

    helpers do
      def get_notifications_by_username(username)
        begin
          response = RestClient.get 'http://localhost:8091/external/notificationStore/getByMobile?mobile='+username
          notifications = JSON.parse(response)
        rescue Exception => e
          logger.error e
        end
      end
    end
    desc 'return my Notifications' do
      headers Authorization: {
          description: 'Check Resource Owner Authorization: \'Bearer token\'',
          required: true
      }
    end
    get "my" do
      doorkeeper_authorize!
      body get_notifications_by_username(current_resource_owner.username)
    end
  end
end
