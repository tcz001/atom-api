FactoryGirl.define do
  factory :game_type do
    name { %w(RPG ACT FPS AVG SPT RTS SLG).sample }
  end

end
