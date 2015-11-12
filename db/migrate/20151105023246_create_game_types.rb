class CreateGameTypes < ActiveRecord::Migration
  def change
    create_table :game_types do |t|
      t.string :name

      t.integer :is_valid
      t.timestamps null: false
    end
  end
end
