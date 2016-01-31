class CreateGameSkus < ActiveRecord::Migration
  def change
    create_table :game_skus do |t|
      t.references :game, index: true, foreign_key: true
      t.column :price, 'decimal(9,2)'
      t.integer :amount

      t.timestamps null: false
    end
  end
end
