FactoryGirl.define do
  factory :game do
    name { Faker::App.name }
    is_hot { [true, false].sample }
    nick_name { Faker::App.name }
    developer { Faker::App.author }
    game_type nil
    game_version nil
    min_player_num 1
    max_player_num { [1,2,3,4].sample }
    original_price { Faker::Number.decimal(2) }
    reference_price { Faker::Number.decimal(2) }
    release_at { Faker::Time.forward }
    language { ['English', 'Simplified Chinese', 'Traditional Chinese'].sample }
    detail { Faker::Hacker.say_something_smart }
  end

end
