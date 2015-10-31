require 'doorkeeper/grape/helpers'

module API
  class Users < Grape::API
    use Rack::JSONP
    helpers Doorkeeper::Grape::Helpers
    helpers do
      # Find the user that owns the access token
      def current_resource_owner
        # doorkeeper_token = Doorkeeper::Grape::Helpers::doorkeeper_token
        p doorkeeper_token
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end
    end

    desc 'gets the Users'
    get "all" do
      present User.all, with: API::Entities::User
    end

    desc 'return my user info' do
      headers Authorization: {
                  description: 'Check Resource Owner Authorization: \'Bearer token\'',
                  required: true
              }
    end
    get "me" do
      doorkeeper_authorize!
      present current_resource_owner, with: API::Entities::User
    end

  end
end
