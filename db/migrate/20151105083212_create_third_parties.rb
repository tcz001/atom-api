class CreateThirdParties < ActiveRecord::Migration
  def change
    create_table :third_parties do |t|
      t.string :open_id
      t.integer :type

      t.references :user, index: true, foreign_key: true

      t.integer :is_valid
      t.timestamps null: false
    end
  end
end
