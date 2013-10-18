# Seeds development database with fake data to assist design and development.
# Creates fake users and assigns parking spots to users

FAKE_USERS_COUNT = 100
FAKE_SPOTS_COUNT = 100

require_relative "./geoseeds"

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
      zip_code: 94102 + rand(88),
      price: rand(1..30),
      user_id: VALID_USER_IDS.sample
    }
end

puts "----SEEDING DATABASE-----"
puts "\n----Creating Users-----"

FAKE_USERS_COUNT.times do
  print "."
  user = User.new(
       email: Faker::Internet.email,
    username: Faker::Internet.user_name,
    password: "foobar",
    password_confirmation: "foobar"
  )
  unless user.save
    print "x"
  end

end

puts "\n----Creating & Assigning Spots-----"

VALID_USER_IDS = User.pluck(:id)

FAKE_SPOTS.times do
  print "."
  spot = Spot.new(generate_fake_spot_data)
  unless spot.save
    print "x"
  end
end

puts "\n----Creating Test Accounts-----"

1.times do |make_test_users|
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


puts "\n----Finished-----"