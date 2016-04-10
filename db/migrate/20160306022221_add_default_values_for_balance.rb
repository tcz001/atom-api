class AddDefaultValuesForBalance < ActiveRecord::Migration
  def up
    User.update_all({
        free_balance: 0,
        frozen_balance: 0,
        free_credit_balance: 0,
        frozen_credit_balance: 0
    })
    change_column :users,:free_balance, 'decimal(9,2)'
    change_column_default :users, :free_balance, 0
    change_column_default :users, :frozen_balance, 0
    change_column_default :users, :free_credit_balance, 0
    change_column_default :users, :frozen_credit_balance, 0
  end

  def down
    change_column_default :users, :free_balance, nil
    change_column_default :users, :frozen_balance, nil
    change_column_default :users, :free_credit_balance, nil
    change_column_default :users, :frozen_credit_balance, nil

  end
end
