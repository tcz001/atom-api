module API
  module Entities
    class User < Grape::Entity
      expose :name
      expose :email
      expose :mobile
    end
  end
end
