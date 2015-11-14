class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.references :lease_order, index: true, foreign_key: true
      t.string :pingxx_ch_id
      t.text :raw_data

      t.timestamps null: false
    end
  end
end
