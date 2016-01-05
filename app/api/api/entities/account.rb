module API
  module Entities
    class Account < Grape::Entity
      expose :game, using: API::Entities::Game
      expose :status
      expose :account
      expose :password
      expose :start_at
      expose :expire_at
    end
  end
end
