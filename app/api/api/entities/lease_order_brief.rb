module API
  module Entities
    class LeaseOrderBrief < Grape::Entity
      expose :user, using: API::Entities::User
      expose :game_skus, using: API::Entities::GameSku
      expose :lack
    end
  end
end
