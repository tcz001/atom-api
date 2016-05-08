module API
  module Entities
    class LeaseOrderCalc < Grape::Entity
      expose :total_amount
      expose :frozen_amount
      expose :accounts, using: API::Entities::Account
      expose :created_at
      expose :updated_at
    end
  end
end
