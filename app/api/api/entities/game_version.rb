module API
  module Entities
    class GameVersion < Grape::Entity
      expose :id, as: :game_version_id
      expose :display_language, as: :language
      expose :version
    end
  end
end
