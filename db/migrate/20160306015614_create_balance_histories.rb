class CreateBalanceHistories < ActiveRecord::Migration
  def change
    create_table :balance_histories do |t|
      t.string :serial_number
      t.string :event
      t.column :amount, 'decimal(9,2)'
      t.string :related_order
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
