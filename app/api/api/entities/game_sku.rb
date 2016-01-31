module API
  module Entities
    class GameSku < Grape::Entity
      expose :id, as: :game_sku_id
      expose :price
      expose :sku_attributes, using: API::Entities::SkuAttribute
    end
  end
end