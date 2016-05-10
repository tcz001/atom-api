module API
  module Entities
    class LeaseOrderCalc < Grape::Entity
      expose :user, using: API::Entities::User
      expose :game_skus, using: API::Entities::GameSku
      expose :lack
    end
  end
end

