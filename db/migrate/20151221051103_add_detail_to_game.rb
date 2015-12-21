class AddDetailToGame < ActiveRecord::Migration
  def change
    add_column :games, :detail, :text
  end
end
