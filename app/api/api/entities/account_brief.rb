module API
  module Entities
    class AccountBrief < Grape::Entity
      expose :game, using: API::Entities::Game
      expose :start_at
      expose :expire_at
    end
  end
end
