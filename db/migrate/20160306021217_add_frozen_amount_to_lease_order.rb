class AddFrozenAmountToLeaseOrder < ActiveRecord::Migration
  def change
    add_column :lease_orders, :frozen_amount, 'decimal(9,2)'
  end
end
