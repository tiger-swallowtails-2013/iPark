require 'Faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password 'foobar'
  end

  factory :spot do
    street { Faker::Address.street_name }
    zip_code { Faker::Address.zip_code }
    price { rand(1..10) }
    description { Faker::Company.catch_phrase }
    type { ['garage', 'street', 'yard', 'driveway'].sample }
  end
end