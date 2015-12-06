module API
  module Entities
    class User < Grape::Entity
      expose :username
      expose :email
      expose :avatar
    end
  end
end
