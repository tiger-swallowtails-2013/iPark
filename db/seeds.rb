# Seeds development database with fake data to assist design and development.
# Creates fake users and assigns parking spots to users
# Uses fake street addresses to query google for geolocation data

require_relative "./geoseeds"

FAKE_USERS_COUNT = 1
FAKE_SPOTS_COUNT = 2
CREATE_TEST_USERS = false
GOOGLE_QUERY_SLEEPTIME = 0.25 # necessary to avoid exceeding google's per-second limit

SPOT_TYPES = [
  "parking spot", "space", "spot", "yard", "driveway", "street parking", "parking spot", "double spot", "garage",
  "covered parking place", "parking lot"
]

STATUS = [
  "available", "ready for your car", "for rent", "from 9-5", "available weekdays", "available on weekends", "perfect for your winnebago",
  "close to AT&T Park", "near Giants Stadium", "motorcycle friendly", "going fast", "in quiet neighborhood", "for commuter", "", "", "", ""
]

def generate_fake_spot_data
  my_spot = SPOT_TYPES.sample
  my_street = STREET_NAMES.sample
  my_hood = NEIGHBORHOODS.sample
  my_status = STATUS.sample
  my_description = [my_hood, my_street].sample + " " + my_spot + " " + my_status
  return {
      location_type: my_spot,
      description: my_description,
      street: rand(1..3000).to_s + " " + my_street,
      zip_code: 94102 + rand(88), # field is reassigned by geocoder in Spot model
      price: rand(1..30),
      user_id: VALID_USER_IDS.sample
    }
end

def generate_more_accurate_spot_description(zip_code)
  my_hood = lookup_neighborhood_of_zipcode(zip_code)
  my_spot = SPOT_TYPES.sample
  my_status = STATUS.sample
  my_description = my_hood + " " + my_spot + " " + my_status
end

def lookup_neighborhood_of_zipcode(zip_code)
  if (94102..94134)===zip_code
    ZIP_CODE_NEIGHBORHOOD_LOOKUP[zip_code.to_s].sample
  else
    NEIGHBORHOODS.sample + "*"
  end
end

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
  if spot.save
    spot.description = generate_more_accurate_spot_description(spot.zip_code)
    print "."
  else
    print "x")
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