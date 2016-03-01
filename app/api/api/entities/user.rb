module API
  module Entities
    class User < Grape::Entity
      expose :username
      expose :email
      expose :status
      expose :grade
      expose :zm_credit
      expose :free_balance
      expose :note
      expose :avatar
    end
  end
end
