# Creates fake users and assigns parking spots to users
# Uses fake street addresses and queries google for real geolocation data

require_relative "./geoseeds"
require_relative "./seed_helper"

# Important:
# - Make sure to adjust magic numbers before seeding the databse
# - Comment out Geocoder validations in Spot Model
CREATE_FAKE_USERS = true
  FAKE_USERS_COUNT = 10
  FAKE_SPOTS_COUNT = 300 # limit 2,500 requests per day
  GOOGLE_QUERY_SLEEPTIME = 0.25 # (0.25s) necessary to avoid exceeding google's per-second limit
CREATE_RESERVATIONS = false
CREATE_TEST_ACCOUNTS = false
SEED_CITY_DATABASE = false


if CREATE_FAKE_USERS
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
    spot = Spot.new(generate_fake_spot_with_real_data)
    spot.save ? (print ".") : (print "x")
    # sleep GOOGLE_QUERY_SLEEPTIME
  end
end


if CREATE_RESERVATIONS
  puts "\n----Creating Reservations-----"

  Spot.all.each do |spot|
      current_user =  VALID_USER_IDS.sample
      start_date = spot.start_date
      end_date = spot.end_date
      date_array = (start_date..end_date).to_a

      date_array.each do |date|
        reservation = Reservation.create(date: date)
        spot.reservations << reservation
        current_user.reservations << reservation
      end
      print "."
  end

end


if CREATE_TEST_ACCOUNTS
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

if SEED_CITY_DATABASE
  puts "\n----Populating CityData-----"
  ZIP_CODE_NEIGHBORHOOD_LOOKUP.each do |zip,hoods|
    hoods.each do |hood|
      CityData.create!(zip_code: zip, neighborhood: hood.downcase)
    end
  end
end

puts "\n----Finished-----"