module API
  module Entities
    class User < Grape::Entity
      expose :username
      expose :email
    end
  end
end
