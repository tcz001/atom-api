class CreateGameVersions < ActiveRecord::Migration
  def change
    create_table :game_versions do |t|
      t.integer :version
      t.integer :language
      t.column :original_price, 'decimal(9,2)'
      t.column :reference_price, 'decimal(9,2)'

      t.references :game, index: true, foreign_key: true

      t.integer :is_valid
      t.timestamps null: false
    end
  end
end
