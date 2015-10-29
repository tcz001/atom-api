module API
  module Entities
    class GameVersion < Grape::Entity
      expose :display_language, as: :language
      expose :version
    end
  end
end
