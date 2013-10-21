require 'Faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password 'foobar'
    password_confirmation 'foobar'
  end

  factory :spot do
    location_type { ['garage', 'street', 'yard', 'driveway'].sample }
    description { Faker::Company.catch_phrase }
    street { Faker::Address.zip_code + "California St"}
    latitude 12345
    longitude 12345
    zip_code '99999'
    price 30
    user_id 1
    start_date { Date.today.to_s.slice(0,10) }
    end_date { (Date.today + 1).to_s.slice(0,10) }
  end
end
