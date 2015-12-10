FactoryGirl.define do
  factory :game_version do
    version { %w(1 2 remastered).sample }
    language { %w(CN US).sample }
  end

end
