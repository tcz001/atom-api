class CreateGameSkuAttributeSets < ActiveRecord::Migration
  def change
    create_table :game_sku_attribute_sets, id: false do |t|
      t.references :game_sku, index: true, foreign_key: true
      t.references :sku_attribute, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
