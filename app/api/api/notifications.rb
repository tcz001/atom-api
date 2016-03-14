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
          return notifications
        rescue Exception => e
          logger.error e
          error!({error: '暂时获取不到信息', detail: '请联系管理员'}, 500)
        end
      end
      def get_notifications_by_username_and_latest_nid(username, nid)
        begin
          response = RestClient.get 'http://localhost:8091/external/notificationStore/getRecentByMobileAndNid?mobile='+username+'&nid='+nid
          notifications = JSON.parse(response)
          return notifications
        rescue Exception => e
          logger.error e
          error!({error: '暂时获取不到信息', detail: '请联系管理员'}, 500)
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

    desc 'return new Notifications' do
      headers Authorization: {
          description: 'Check Resource Owner Authorization: \'Bearer token\'',
          required: true
      }
    end
    params do
      requires :nid, type: String, desc: 'latest nid.'
    end
    get "recent" do
      doorkeeper_authorize!
      body get_notifications_by_username_and_latest_nid(current_resource_owner.username, params[:nid])
    end

    desc 'return new Notifications count' do
      headers Authorization: {
          description: 'Check Resource Owner Authorization: \'Bearer token\'',
          required: true
      }
    end
    params do
      requires :nid, type: String, desc: 'latest nid.'
    end
    get "count_recent" do
      doorkeeper_authorize!
      body get_notifications_by_username_and_latest_nid(current_resource_owner.username, params[:nid]).length
    end
  end
end
