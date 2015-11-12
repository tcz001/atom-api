class CreateLeaseOrders < ActiveRecord::Migration
  def change
    create_table :lease_orders do |t|
      t.string :serial_number, index: true
      t.integer :pay_type
      t.integer :status
      t.column :total_amount, 'decimal(9,2)'

      t.references :user, index: true, foreign_key: true

      t.integer :is_valid
      t.timestamps null: false
    end
  end
end
