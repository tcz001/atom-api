class AddGradeToUser < ActiveRecord::Migration
  def change
    add_column :users, :grade, :integer
  end
end
