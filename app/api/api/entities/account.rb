module API
  module Entities
    class Account < Grape::Entity
      expose :game_id
      expose :account
      expose :password
    end
  end
end
