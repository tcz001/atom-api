class AddZmCreditToUser < ActiveRecord::Migration
  def change
    add_column :users, :zm_credit, :integer
  end
end
