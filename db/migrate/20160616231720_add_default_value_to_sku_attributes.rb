class AddDefaultValueToSkuAttributes < ActiveRecord::Migration
  def change
    SkuAttribute.find_or_create_by(name: '租用天数', option_value: '5')
  end
end
