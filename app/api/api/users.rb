module API
  class Users < Grape::API
    formatter :json, API::Formatter.normal
    error_formatter :json, API::Formatter.error
    helpers SharedParams

    params do
      requires :mobile, type: String, desc: 'mobile number.'
    end
    post "send_sms_code" do
      begin
        response = RestClient.get 'http://localhost:8080/external/sms/sendCode?mobile='+params[:mobile]
        json = JSON.parse(response)
        if json['status'] == 'error'
          error!({error: json['content'], detail: json['content']}, 203)
        else
          user = User.new(username: params[:mobile]).persisted?
          if user
            user.status = 'confirming'
          else
            User.create(username: params[:mobile], status: 'confirming')
          end
          body json['content']
        end
      rescue Exception => e
        logger.error e
        error!({error: 'unexpected error', detail: 'external sms service error'}, 500)
      end
    end

    params do
      requires :mobile, type: String, desc: 'mobile number.'
      requires :code, type: String, desc: 'code.'
    end
    post "check_sms_code" do
      begin
        user = User.new(username: params[:mobile]).persisted?
        if user
          response = RestClient.get 'http://localhost:8080/external/sms/checkCode?code='+params[:code]+'&mobile='+params[:mobile]
          json = JSON.parse(response)
          if json['status'] == 'error'
            error!({error: json['content'], detail: json['content']}, 203)
          else
            user.status = 'confirmed'
          end
        else
          error!({error: 'user was not created, please call send_sms_code and check_sms_code first', detail: 'check sms code error'}, 500)
        end
      rescue Exception => e
        logger.error e
        error!({error: 'unexpected error', detail: 'external sms service error'}, 500)
      end
    end

    params do
      requires :mobile, type: String, desc: 'username can only be mobile number now.'
      requires :password, type: String, desc: 'password.'
    end
    post "sign_up" do
      begin
        user = User.new(username: params[:mobile]).persisted?
        if user
          case user.status
            when 'confirmed'
              user.password = params[:password]
              user.status = 'active'
              user.save
              access_token = Doorkeeper::AccessToken.create!(resource_owner_id: user.id, scopes: :public, expires_in: 3.days, use_refresh_token: true)
              json = {token_info: access_token, access_token: access_token.token, refresh_token: access_token.refresh_token}.as_json
              body json
            when 'confirming'
              error!({error: 'wait for confirming', detail: 'sign up error'}, 203)
            when 'active'
              error!({error: 'username already taken', detail: 'sign up error'}, 203)
            else
              error!({error: 'unexpected user status error', detail: 'sign up error'}, 203)
          end
        else
          error!({error: 'user was not created, please call send_sms_code and check_sms_code first', detail: 'sign up error'}, 500)
        end
      rescue Exception => e
        logger.error e
        error!({error: 'unexpected error', detail: 'sign up error'}, 500)
      end
    end

    desc 'update my User password' do
      headers Authorization: {
                  description: 'Check Resource Owner Authorization: \'Bearer token\'',
                  required: true
              }
    end
    params do
      requires :old_password, type: String, desc: 'old password.'
      requires :new_password, type: String, desc: 'new password.'
    end
    post "change_password" do
      doorkeeper_authorize!
      begin
        if current_resource_owner.password == params[:old_password]
          current_resource_owner.password = params[:new_password]
          current_resource_owner.save
        else
          error!({error: 'wrong old password', detail: 'old password doesnt match'}, 203)
        end
      rescue Exception => e
        logger.error e
        error!({error: 'unexpected error', detail: 'change password error'}, 500)
      end
    end

    params do
      requires :mobile, type: String, desc: 'mobile number.'
    end
    post "forget_password" do
      error!({error: 'forget password is not supported yet', detail: 'forget password is not supported'}, 500)
    end

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
