FactoryGirl.define do
  factory :account do
    game nil
    lease_order nil
    account { Faker::Internet.safe_email }
    password { Faker::Internet.password }
    status 1
    is_valid 1
  end

end
