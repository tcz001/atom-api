module API
  class Users < Grape::API
    formatter :json, API::Formatter.normal
    error_formatter :json, API::Formatter.error
    helpers SharedParams

    desc 'gets the Users list'
    params do
      use :pagination
    end
    get "list" do
      present User.page(params[:page]).per(params[:per_page]), with: API::Entities::User
    end

    desc 'return my User info' do
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
