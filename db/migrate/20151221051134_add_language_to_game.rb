class AddLanguageToGame < ActiveRecord::Migration
  def change
    add_column :games, :language, :string
  end
end
