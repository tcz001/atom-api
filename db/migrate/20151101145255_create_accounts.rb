class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :game_version, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :account
      t.string :password
      t.integer :status
      t.integer :is_valid

      t.timestamps null: false
    end
  end
end
