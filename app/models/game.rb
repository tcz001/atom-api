class Game < ActiveRecord::Base
  has_many :game_versions
  belongs_to :game_type
  def display_game_type
    self.game_type.name
  end
end
