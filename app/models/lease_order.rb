class LeaseOrder < ActiveRecord::Base
  belongs_to :games
  belongs_to :game_versions
  belongs_to :third_partys
end
