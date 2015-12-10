class CreateGameVersions < ActiveRecord::Migration
  def change
    create_table :game_versions do |t|
      t.string :version
      t.string :language

      t.integer :is_valid
      t.timestamps null: false
    end
  end
end
