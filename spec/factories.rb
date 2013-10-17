require 'Faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password 'foobar'
  end

  factory :spot do

  end
end