class AddReleaseAtToGame < ActiveRecord::Migration
  def change
    add_column :games, :release_at, :dateTime
  end
end
