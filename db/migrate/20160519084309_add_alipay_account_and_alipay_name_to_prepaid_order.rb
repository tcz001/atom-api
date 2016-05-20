class AddAlipayAccountAndAlipayNameToPrepaidOrder < ActiveRecord::Migration
  def change
    add_column :prepaid_orders, :alipay_account, :string
    add_column :prepaid_orders, :alipay_name, :string
  end
end
