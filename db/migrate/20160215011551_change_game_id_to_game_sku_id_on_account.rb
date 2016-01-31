class ChangeGameIdToGameSkuIdOnAccount < ActiveRecord::Migration
  def change
    add_reference :accounts, :game_sku, index: true, foreign_key: true
    remove_reference :accounts, :game, index: true, foreign_key: true
    remove_reference :games, :game_version, index: true, foreign_key: true
  end
end
