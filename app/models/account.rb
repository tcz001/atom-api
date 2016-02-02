class Account < ActiveRecord::Base
  belongs_to :game_sku
  belongs_to :lease_order
  def display_game
    self.game_sku.game if game_sku.present?
  end
end
