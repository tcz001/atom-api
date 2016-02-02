class DataMigrationForSku < ActiveRecord::Migration
  def change
    add_column :game_skus, :is_valid, :integer
    SkuAttribute.find_or_create_by(name: '商品类型', option_value: '数字版')
    SkuAttribute.find_or_create_by(name: '商品类型', option_value: '光盘版')
    SkuAttribute.find_or_create_by(name: '账号地区', option_value: '港服')
    SkuAttribute.find_or_create_by(name: '账号地区', option_value: '国服')
    SkuAttribute.find_or_create_by(name: '账号地区', option_value: '美服')
    SkuAttribute.find_or_create_by(name: '账号地区', option_value: '日服')
    SkuAttribute.find_or_create_by(name: '认证方式', option_value: '非认证')
    SkuAttribute.find_or_create_by(name: '认证方式', option_value: '可认证')
    SkuAttribute.find_or_create_by(name: '租用天数', option_value: '3')
    SkuAttribute.find_or_create_by(name: '租用天数', option_value: '7')
    SkuAttribute.find_or_create_by(name: '租用天数', option_value: '15')
    SkuAttribute.find_or_create_by(name: '租用天数', option_value: '30')
    games = Game.all
    games.each { |g|
      GameSku.create(price: g.reference_price, is_valid: true, game: g, sku_attributes: [SkuAttribute.find_by_option_value('数字版'), SkuAttribute.find_by_option_value('港服'), SkuAttribute.find_by_option_value('非认证'), SkuAttribute.find_by_option_value('7')])
      GameSku.create(price: g.reference_price, is_valid: false, game: g, sku_attributes: [SkuAttribute.find_by_option_value('数字版'), SkuAttribute.find_by_option_value('港服'), SkuAttribute.find_by_option_value('可认证'), SkuAttribute.find_by_option_value('15')])
    }
  end
end
