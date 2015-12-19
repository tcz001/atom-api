FactoryGirl.define do
  factory :user do
    username { Faker::Number.number(10) }
    name { Faker::Internet.user_name }
    status 'active'
    note { name + ' is my friend' }
    email { Faker::Internet.safe_email(username) }
    password '12345678'
  end
end
