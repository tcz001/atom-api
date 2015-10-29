class CreateGameVersions < ActiveRecord::Migration
  def change
    create_table :game_versions do |t|
      t.references :game, index: true, foreign_key: true
      t.string :version
      t.string :language

      t.timestamps null: false
    end
  end
end
