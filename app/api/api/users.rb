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
      present User.page(params[:page]).per(params[:per_page]), with: API::Entities::UserBrief
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

    desc 'update my User avatar' do
      headers Authorization: {
                  description: 'Check Resource Owner Authorization: \'Bearer token\'',
                  required: true
              }
    end
    params do
      requires :image_file, type: File, desc: 'avatar file.'
    end
    post "avatar" do
      begin
        doorkeeper_authorize!
        avatar = Image.create(file: params[:image_file].tempfile)
        current_resource_owner.images << avatar
        current_resource_owner.save
        present current_resource_owner, with: API::Entities::User
      rescue Exception => e
        logger.error e
        error!({error: 'unexpected error', detail: 'external image service error'}, 500)
      end
    end

  end
end
