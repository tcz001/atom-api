module API
  module Entities
    class UserBrief < Grape::Entity
      expose :username
      expose :avatar
    end
  end
end
