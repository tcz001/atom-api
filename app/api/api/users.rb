module API
  class Users < Grape::API
    use Rack::JSONP

    desc 'gets the Users'
    get "all" do
      present User.all, with: API::Entities::User
    end

    desc 'return a user'
    params do
      optional :id, type: Integer, desc: 'User id.'
      optional :name, type: String, desc: 'User name.'
      optional :email, type: String, desc: 'User email.'
    end
    get "info" do
      if (conditions = declared(params, include_missing: false)).present?
        present User.find_by(conditions), with: API::Entities::User
      end
    end

  end
end
