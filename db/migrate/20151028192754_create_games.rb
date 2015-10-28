class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.boolean :isHot
      t.string :gameType
      t.string :nickName
      t.string :developer
      t.integer :minplayer
      t.integer :maxplayer

      t.timestamps null: false
    end
  end
end
