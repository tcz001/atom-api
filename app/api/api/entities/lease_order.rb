module API
  module Entities
    class LeaseOrder < Grape::Entity
      expose :serial_number
      expose :status
      expose :total_amount
      expose :frozen_amount
      expose :accounts, using: API::Entities::Account
      expose :created_at
      expose :updated_at
    end
  end
end
