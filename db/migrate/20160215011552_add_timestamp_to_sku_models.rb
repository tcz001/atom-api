class AddTimestampToSkuModels < ActiveRecord::Migration
  CREATE_TIMESTAMP = 'DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP'
  UPDATE_TIMESTAMP = 'DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'
  def up
    change_column :game_skus,:created_at, CREATE_TIMESTAMP
    change_column :game_skus,:updated_at, UPDATE_TIMESTAMP
    change_column :game_sku_attribute_sets,:created_at, CREATE_TIMESTAMP
    change_column :game_sku_attribute_sets,:updated_at, UPDATE_TIMESTAMP
    change_column :sku_attributes,:created_at, CREATE_TIMESTAMP
    change_column :sku_attributes,:updated_at, UPDATE_TIMESTAMP
  end
end
