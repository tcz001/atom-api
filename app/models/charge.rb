class Charge < ActiveRecord::Base
  belongs_to :lease_order
  belongs_to :prepaid_order
end
