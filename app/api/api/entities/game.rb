module API
  module Entities
    class Game < Grape::Entity
      expose :name
      expose :isHot
      expose :gameType
      expose :nickName
      expose :developer
      expose :minplayer
      expose :maxplayer
      expose :game_versions, as: :versions, using: API::Entities::GameVersion
    end
  end
end
