module API
  module Entities
    class LeaseOrderBrief < Grape::Entity
      expose :serial_number
      expose :status
      expose :total_amount
      expose :accounts, using: API::Entities::AccountBrief
    end
  end
end
