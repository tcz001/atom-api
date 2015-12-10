class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :account
      t.string :password
      t.integer :status
      t.datetime :start_at
      t.datetime :expire_at

      t.references :game, index: true, foreign_key: true
      t.references :lease_order, index: true, foreign_key: true

      t.integer :is_valid
      t.timestamps null: false
    end
  end
end
