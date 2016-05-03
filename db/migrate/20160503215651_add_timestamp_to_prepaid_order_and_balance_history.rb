class AddTimestampToPrepaidOrderAndBalanceHistory < ActiveRecord::Migration
  CREATE_TIMESTAMP = 'DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP'
  UPDATE_TIMESTAMP = 'DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'

  def change
    change_column :prepaid_orders, :created_at, CREATE_TIMESTAMP
    change_column :prepaid_orders, :updated_at, UPDATE_TIMESTAMP
    change_column :balance_histories, :created_at, CREATE_TIMESTAMP
    change_column :balance_histories, :updated_at, UPDATE_TIMESTAMP
  end
end
