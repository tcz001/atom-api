module API
  module Entities
    class PrepaidOrder < Grape::Entity
      expose :serial_number
      expose :status
      expose :total_amount
      expose :created_at
      expose :updated_at
    end
  end
end
