module API
  module Entities
    class LeaseOrderBrief < Grape::Entity
      expose :serial_number
      expose :status
      expose :total_amount
      expose :frozen_amount
      expose :accounts, using: API::Entities::AccountBrief
      expose :created_at
      expose :updated_at
    end
  end
end
