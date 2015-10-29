FactoryGirl.define do
  factory :game_version do
    game nil
    version { %w(1 2 3).sample }
    language { %w(EN JP ZH_CN ZH_HK).sample }
  end

end
