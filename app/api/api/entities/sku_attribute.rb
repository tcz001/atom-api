module API
  module Entities
    class SkuAttribute < Grape::Entity
      expose :name
      expose :option_value
    end
  end
end
