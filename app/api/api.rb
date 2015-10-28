require 'grape'

module API
  class Base < Grape::API
    default_format :json

    mount API::Users => '/users'
    mount API::Games => '/games'

    add_swagger_documentation(
      base_path: "/api",
      hide_documentation_path: true
    )
  end
end
