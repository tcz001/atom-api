module API
  module Entities
    class GameBrief < Grape::Entity
      expose :id, as: :game_id
      expose :name
      expose :is_hot
      expose :display_game_type, as: :game_type
      expose :nick_name
      expose :developer
      expose :min_player_num
      expose :max_player_num
      expose :original_price
      expose :display_reference_price, as: :reference_price
      expose :price_range
      expose :deposit
      expose :cover
      expose :cover_small
      expose :display_language, as: :language
      expose :release_at
    end
  end
end
