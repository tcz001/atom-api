module API
  module Entities
    class AccountBrief < Grape::Entity
      expose :game, using: API::Entities::Game
    end
  end
end
