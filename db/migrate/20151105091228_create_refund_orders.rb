class CreateRefundOrders < ActiveRecord::Migration
  def change
    create_table :refund_orders do |t|
      t.references :third_party, index: true, foreign_key: true
      # t.integer :third_party_id
      t.string :payment_account
      t.string :mobile
      t.string :customer_name
      t.string :why
      t.integer :status
      t.integer :is_valid
      t.column :price, 'decimal(9,2)'  
      t.timestamps null: false
    end
  end
end
