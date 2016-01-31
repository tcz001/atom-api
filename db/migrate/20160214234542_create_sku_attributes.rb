class CreateSkuAttributes < ActiveRecord::Migration
  def change
    create_table :sku_attributes do |t|
      t.string :name
      t.string :option_value

      t.timestamps null: false
    end
  end
end
