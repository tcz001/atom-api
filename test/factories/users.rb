FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.safe_email(username) }
    password '12345678'
  end
end
