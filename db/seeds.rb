SPOT_TYPE = ["parking spot", "space", "spot", "yard", "driveway", "street parking", "parking lot", "double spot", "garage", "covered parking place"]

def spot_on_description(my_spot)
  neighborhood = ["Bernal Heights", "The Castro", "Chinatown", "Cole Valley", "Deco Ghetto", "Fisherman's Wharf", "Golden Gate Park", "The Haight", "Hayes Valley", "Inner Richmond", "Inner Sunset", "The Marina", "The Mission", "Mission to Potrero", "Dolores and Valencia Corridor", "24th Street", "Nob Hill", "Noe Valley", "North Beach", "Outer Richmond", "Outer Sunset", "Pacific Heights", "Potrero Hill", "Russian Hill", "SoMa", "Tenderloin", "Union Square", "Western Addition"]
  nonce = ["available", "ready for your car", "for rent", "9-5", "daily", "on weekends", "perfect for your winnebago", "close to AT&T Park", "near Giants Stadium", "motorcycle friendly"]
  punctuation = ["!", ".", ".", ""]
  neighborhood.sample + " " + my_spot + " " + nonce.sample + punctuation.sample
end


1.times do |make_test_users|
  User.create(
       email: test@test.com
    username: test
    password: test
  )
  User.create(
       email: nishant@test.com
    username: nishant
    password: nishant
  )
  User.create(
       email: morgan@test.com
    username: morgan
    password: morgan
  )
end

500.times do |create_app_users|
  User.create!(
       email: Faker::Internet.user_name
    username: Faker::Internet.email
    password: Faker::Internet.password
  )
end

300.times do |create_and_assign_spots|
    my_spot = SPOT_TYPE.sample
    new_spot =  Spot.create!(
                  street: Faker::Address.street_name
                  zipcode: Faker::Address.zip_code
                  price: rand(1..30)
                  description: spot_on_description(my_spot)
                  type: my_spot
                )
    User.find(rand(1..100)).spots << new_spot
end

