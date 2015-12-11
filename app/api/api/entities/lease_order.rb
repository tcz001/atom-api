module API
  module Entities
    class LeaseOrder < Grape::Entity
      expose :serial_number
      expose :status
      expose :total_amount
      expose :accounts, using: API::Entities::Account
    end
  end
end
