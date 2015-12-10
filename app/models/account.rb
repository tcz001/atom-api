class Account < ActiveRecord::Base
  belongs_to :game
  belongs_to :lease_order
end
