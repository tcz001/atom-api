class AddDepositsLeaseOrder < ActiveRecord::Migration
  def change
    add_column :lease_orders, :deposit, 'decimal(9,2)'
    add_column :lease_orders, :deposit_credit, 'decimal(9,2)'
  end
end
