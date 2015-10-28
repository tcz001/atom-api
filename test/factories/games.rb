FactoryGirl.define do
  factory :game do
    name { Faker::App.name }
    isHot { [true, false].sample }
    gameType { ["RPG", "ACT", "FPS", "AVG", "SPT", "RTS", "SLG"].sample }
    nickName { Faker::App.name }
    developer { Faker::App.author }
    minplayer 1
    maxplayer { [1,2,3,4].sample }
  end

end
