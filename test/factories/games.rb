FactoryGirl.define do
  factory :game do
    name { Faker::App.name }
    is_hot { [true, false].sample }
    nick_name { Faker::App.name }
    developer { Faker::App.author }
    game_type nil
    min_player_num 1
    max_player_num { [1,2,3,4].sample }
  end

end
