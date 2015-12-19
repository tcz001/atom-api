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

admin = FactoryGirl.create(:user,{username:'admin',password:'12345678'})
test_user = FactoryGirl.create(:user,{username:'18611000000',password:'12345678'})
FactoryGirl.create_list(:user, 25)
game_types = FactoryGirl.create_list(:game_type, 4)
FactoryGirl.create_list(:game_version, 3)
game_types.each{|gt|FactoryGirl.create_list(:game, 10, game_type: gt, game_version:GameVersion.all.sample, is_valid: true)}
games = Game.all
games.each{|g|
  lo = FactoryGirl.create(:lease_order, {user: test_user})
  FactoryGirl.create(:account,{game:g, lease_order:lo})
}
