class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :nick_name
      t.string :developer
      t.integer :min_player_num
      t.integer :max_player_num
      t.boolean :is_hot

      t.references :game_type, index: true, foreign_key: true

      t.integer :is_valid
      t.timestamps null: false
    end
  end
end
