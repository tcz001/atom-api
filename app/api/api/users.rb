module API
  class Users < Grape::API
    use Rack::JSONP

    desc 'gets the Users'
    get "all" do
      present User.all, with: API::Entities::User
    end

  end
end
