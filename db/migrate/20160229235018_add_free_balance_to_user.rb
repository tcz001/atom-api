class AddFreeBalanceToUser < ActiveRecord::Migration
  def change
    add_column :users, :free_balance, :decimal
  end
end
