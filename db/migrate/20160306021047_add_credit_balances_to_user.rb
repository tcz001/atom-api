class AddCreditBalancesToUser < ActiveRecord::Migration
  def change
    add_column :users, :free_credit_balance, 'decimal(9,2)'
    add_column :users, :frozen_credit_balance, 'decimal(9,2)'
  end
end
