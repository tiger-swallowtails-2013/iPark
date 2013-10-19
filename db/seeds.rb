# Seeds development database with fake data to assist design and development.
# Creates fake users and assigns parking spots to users
# Uses fake street addresses and queries google for real geolocation data
# Updates Spot object based on geolocation data (zipcode, neighborhood, description)

require_relative "./geoseeds"
require_relative "./seed_helper"

#Make sure to adjust magic numbers before seeding the databse:
FAKE_USERS_COUNT = 1
FAKE_SPOTS_COUNT = 10 # limit 2,500 requests per day
CREATE_TEST_USERS = false # boolean
GOOGLE_QUERY_SLEEPTIME = 0.25 # (0.25s) necessary to avoid exceeding google's per-second limit

puts "----SEEDING DATABASE-----"
puts "\n----Creating Users-----"

FAKE_USERS_COUNT.times do
  user = User.new(
       email: Faker::Internet.email,
    username: Faker::Internet.user_name,
    password: "foobar",
    password_confirmation: "foobar"
  )
  user.save ? (print ".") : (print "x")
end

puts "\n----Creating & Assigning Spots-----"
puts "This will take #{FAKE_SPOTS_COUNT*GOOGLE_QUERY_SLEEPTIME} seconds"

VALID_USER_IDS = User.pluck(:id)

FAKE_SPOTS_COUNT.times do
  spot = Spot.new(generate_fake_spot_data)
  if spot.save # before_save Geocoder adds accurate latitude, longitutude and zipcode
    spot.description = generate_more_accurate_spot_description(spot.zip_code)
    print "."
  else
    print "x"
  end
  sleep GOOGLE_QUERY_SLEEPTIME
end

if CREATE_TEST_USERS
  puts "\n----Creating Test Accounts-----"
  1.times do
    User.create!(
         email: 'test@test.com',
      username: 'test',
      password: 'test',
      password_confirmation: 'test'
    )
    User.create!(
         email: 'nishant@test.com',
      username: 'nishant',
      password: 'nishant',
      password_confirmation: 'nishant'
    )
    User.create!(
         email: 'morgan@test.com',
      username: 'morgan',
      password: 'morgan',
      password_confirmation: 'morgan'
    )
  end
end

puts "\n----Finished-----"