module API
  module Entities
    class Account < Grape::Entity
      expose :game_id
      expose :status
      expose :account
      expose :password
      expose :start_at
      expose :expire_at
    end
  end
end
