FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    status 'valid'
    note { Faker::Internet.user_name + ' is my friend' }
    email { Faker::Internet.safe_email(username) }
    password '12345678'
  end
end
