FactoryGirl.define do
  factory :game_version do
    game nil
    version { [0,1,2,3].sample }
    language { [0,1,2,3].sample }
  end

end
