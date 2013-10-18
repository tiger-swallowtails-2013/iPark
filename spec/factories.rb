require 'Faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password 'foobar'
    password_confirmation 'foobar'
  end

  factory :spot do
    user_id 1
    street { Faker::Address.street_name }
    zip_code { Faker::Address.zip_code }
    price { rand(1..10) }
    description { Faker::Company.catch_phrase }
    location_type { ['garage', 'street', 'yard', 'driveway'].sample }
  end
end