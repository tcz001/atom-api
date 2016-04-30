module API
  class Users < Grape::API
    formatter :json, API::Formatter.normal
    error_formatter :json, API::Formatter.error
    helpers SharedParams

    helpers do
      def verify_code(code, mobile)
        response = RestClient.get 'http://localhost:8091/external/sms/checkCode?code='+code+'&mobile='+mobile
        json = JSON.parse(response)
        return json
      end
    end

    params do
      requires :mobile, type: String, desc: 'mobile number.'
    end
    post "send_sms_code" do
      begin
        response = RestClient.get 'http://localhost:8091/external/sms/sendCode?mobile='+params[:mobile]
        json = JSON.parse(response)
        if json['status'] == 'error'
          error!({error: json['content'], detail: json['content']}, 203)
        else
          body json['content']
        end
      rescue Exception => e
        logger.error e
        error!({error: '注册短信服务故障,请联系客服', detail: '注册短信服务故障,请联系客服'}, 500)
      end
    end

    params do
      requires :mobile, type: String, desc: 'username can only be mobile number now.'
      requires :password, type: String, desc: 'password.'
      requires :code, type: String, desc: 'code.'
    end
    post "sign_up" do
      begin
        user = User.new(username: params[:mobile]).persisted?
        if user
          if user.status == 'active'
            error!({error: '用户已存在', detail: '用户已存在'}, 203)
          else
            error!({error: '错误的用户状态: '+user.status, detail: '错误的用户状态'}, 203)
          end
        else
          json = verify_code(params[:code], params[:mobile])
          if json['status'] == 'error'
            error!({error: json['content'], detail: json['content']}, 203)
          else
            user = User.create(username: params[:mobile], password: params[:password], status: 'active', grade: 0)
            access_token = Doorkeeper::AccessToken.create!(resource_owner_id: user.id, scopes: :public, expires_in: 3.days, use_refresh_token: true)
            json = {token_info: access_token, access_token: access_token.token, refresh_token: access_token.refresh_token}.as_json
            body json
          end
        end
      rescue Exception => e
        logger.error e
        error!({error: '注册短信服务故障,请联系客服', detail: '注册短信服务故障,请联系客服'}, 500)
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
        if current_resource_owner.valid_password?(params[:old_password])
          current_resource_owner.update({password:params[:new_password]})
        else
          error!({error: '旧密码不正确', detail: '旧密码不正确'}, 203)
        end
      rescue Exception => e
        logger.error e
        error!({error: '修改密码出错', detail: '修改密码出错'}, 500)
      end
    end

    params do
      requires :mobile, type: String, desc: 'username can only be mobile number now.'
      requires :password, type: String, desc: 'password.'
      requires :code, type: String, desc: 'code.'
    end
    post "forget_password" do
      json = verify_code(params[:code], params[:mobile])
      if json['status'] == 'error'
        error!({error: json['content'], detail: json['content']}, 203)
      else
        user = User.find_by_username(params[:mobile])
        if user.present?
          user.password = params[:password]
          user.save
        else
          error!({error: '用户不存在', detail: '用户不存在'}, 500)
        end
      end
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
