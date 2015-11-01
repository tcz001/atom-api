class Account < ActiveRecord::Base
  belongs_to :game_version
  belongs_to :user
end
