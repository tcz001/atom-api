class CreateLeaseOrders < ActiveRecord::Migration
  def change
    create_table :lease_orders do |t|
      t.references :game, index: true, foreign_key: true
      t.references :game_version, index: true, foreign_key: true
      t.references :third_party, index: true, foreign_key: true
      t.column :loan_price, 'decimal(9,2)' 
      t.datetime :loan_time
      t.integer :is_valid
      t.integer :pay_type
      t.integer :status
      t.integer :code
      t.string :account
      t.string :password
      t.timestamps null: false
    end
  end
end
