module API
  module Entities
    class User < Grape::Entity
      expose :username
      expose :email
      expose :status
      expose :note
      expose :avatar
    end
  end
end
