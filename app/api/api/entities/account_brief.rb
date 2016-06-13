module API
  module Entities
    class AccountBrief < Grape::Entity
      expose :display_game, as: :game, using: API::Entities::GameBrief
      expose :game_sku, using: API::Entities::GameSku
      expose :status
      expose :start_at
      expose :expire_at
      expose :duration
    end
  end
end
