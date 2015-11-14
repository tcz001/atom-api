class Charge < ActiveRecord::Base
  belongs_to :lease_order
end
