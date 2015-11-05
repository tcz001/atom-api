class CreateThirdParties < ActiveRecord::Migration
  def change
    create_table :third_parties do |t|
      t.string :party_id
      t.integer :type
      t.string :mobile
      t.string :name
      t.integer :is_valid
      t.column :deposit, 'decimal(9,2)'  

      t.timestamps null: false
    end
  end
end
