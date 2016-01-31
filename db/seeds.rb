# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'factory_girl'
require 'faker'

DatabaseCleaner.clean_with(:truncation)

admin = FactoryGirl.create(:admin,{username:'admin',password:'$2a$10$xgpP4mcidUDQg0ns08gqqufPuqLIY3bub/jBxkQ0RsW88Smte3216'})
test_user = FactoryGirl.create(:user,{username:'18611000000',password:'12345678'})
FactoryGirl.create_list(:user, 25)
game_types = FactoryGirl.create_list(:game_type, 4)
game_types.each{|gt|FactoryGirl.create_list(:game, 10, game_type: gt)}
games = Game.all
SkuAttribute.create(name:'商品类型',option_value:'数字版')
SkuAttribute.create(name:'商品类型',option_value:'光盘版')
SkuAttribute.create(name:'地区',option_value:'港服')
SkuAttribute.create(name:'地区',option_value:'国服')
SkuAttribute.create(name:'地区',option_value:'美服')
SkuAttribute.create(name:'地区',option_value:'日服')
SkuAttribute.create(name:'租用天数',option_value:'3')
SkuAttribute.create(name:'租用天数',option_value:'7')
SkuAttribute.create(name:'租用天数',option_value:'15')
SkuAttribute.create(name:'租用天数',option_value:'30')
games.each{|g|
  GameSku.create(price:1.99,game: g,sku_attributes:[SkuAttribute.find_by_option_value('数字版'),SkuAttribute.find_by_option_value('港服'),SkuAttribute.find_by_option_value('7')])
  sku = GameSku.create(price:10.99,game: g,sku_attributes:[SkuAttribute.find_by_option_value('数字版'),SkuAttribute.find_by_option_value('港服'),SkuAttribute.find_by_option_value('7')])
  GameSku.create(price:100.99,game: g,sku_attributes:[SkuAttribute.find_by_option_value('数字版'),SkuAttribute.find_by_option_value('日服'),SkuAttribute.find_by_option_value('30')])
  lo = FactoryGirl.create(:lease_order, {user: test_user})
  FactoryGirl.create(:account,{game_sku:sku,lease_order:lo})
}
