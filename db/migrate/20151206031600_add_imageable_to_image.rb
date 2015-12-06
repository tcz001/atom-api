class AddImageableToImage < ActiveRecord::Migration
  def change
    add_column :images, :name, :string
    add_column :images, :imageable_id, :integer
    add_index :images, :imageable_id
    add_column :images, :imageable_type, :string
  end
end
