class CreateUseExplains < ActiveRecord::Migration
  def change
    create_table :use_explains do |t|
      t.string :title
      t.string :detail
      t.integer :type
      t.integer :sort
      t.integer :is_valid

      t.timestamps null: false
    end
  end
end
