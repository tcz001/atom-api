class AddPrepaidOrderToCharge < ActiveRecord::Migration
  def change
    add_reference :charges, :prepaid_order, index: true, foreign_key: true
  end
end
