class AddDurationToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :duration, :integer
  end
end
