class AddIsValidToGameSku < ActiveRecord::Migration
  def change
    add_column :game_skus, :is_valid, :boolean
  end
end
