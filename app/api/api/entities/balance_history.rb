module API
  module Entities
    class BalanceHistory < Grape::Entity
      expose :serial_number
      expose :related_order
      expose :amount
      expose :event
      expose :created_at
      expose :updated_at
    end
  end
end
