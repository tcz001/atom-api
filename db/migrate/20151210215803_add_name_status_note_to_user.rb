class AddNameStatusNoteToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :status, :string
    add_column :users, :note, :text
  end
end
