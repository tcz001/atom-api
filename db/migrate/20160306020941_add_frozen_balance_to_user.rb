class AddFrozenBalanceToUser < ActiveRecord::Migration
  def change
    add_column :users, :frozen_balance, 'decimal(9,2)'
  end
end
