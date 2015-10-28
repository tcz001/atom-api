FactoryGirl.define do
  factory :user do
    name { Faker::Internet.user_name }
    email { Faker::Internet.safe_email(name) }
    mobile { Faker::PhoneNumber.cell_phone }
  end

end
