class AddDepositToGame < ActiveRecord::Migration
  def change
    add_column :games, :deposit, 'decimal(9,2)'
  end
end
