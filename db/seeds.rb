STREET_NAMES = [
  "Alemany Boulevard", "Alvarado St", "Ambrose Bierce Alley", "Anza St", "Arguello Boulevard", "Ashbury St",
  "Baker St", "Balboa St", "Bartlett St", "Beale St", "Bernal Avenue", "Bluxome St", "Brannan St",
  "Brenham Place", "Broderick Street", "Bryant Street", "Buchanan Street", "Burnett Avenue", "Bush Street", "Cabrillo Street",
  "California Street", "Castro Street", "Cesar Chavez Street", "Clark Street", "Cole Street", "Coleman Street",
  "Colin P Kelly Junior Street", "Davidson Street", "Davis Street", "De Haro Street", "Dirk Dirksen Place", "Divisadero Street",
  "Dolores Street", "Duncan Street", "Elizabeth Street", "Fillmore Street", "Folsom Street", "Franklin Street", "Fremont Street",
  "Fulton Street", "Funston Street", "Geary Boulevard", "Gough Street", "Grant Street", "Guerrero Street", "Haight Street",
  "Harrison Street", "Hayes Street", "Howard Street", "Hyde Street", "Ingalls Street", "Irving Street", "Jack Kerouac Alley",
  "Jack Micheline Alley", "Jackson Street", "Jefferson Street", "Jerrold Avenue", "Jersey Street", "John F. Shelley Dr.",
  "John Muir Drive", "Jones Street", "Joost Avenue", "Jose Sarria Court", "Juan Bautista Circle", "Judah Street",
  "Junipero Serra Boulevard", "Justin Herman Plaza", "Kearny Street", "Keyes Avenue", "Kezar Drive", "Kirkham Street",
  "Laguna Street", "Lane St.", "Lapham Way", "Lapu Lapu St.", "Larkin St.", "Laussat St.", "Lawton St.",
  "Leavenworth St.", "Le Conte Avenue", "Lech Walesa St.", "Leese Street", "Leidesdorff Street", "Lendrum Street",
  "Liggett Avenue", "Linares Avenue", "Lincoln Boulevard", "Lincoln Court", "Lincoln Way", "Lombard Street", "Mason Street",
  "McAllister Street", "Montgomery Street", "Moraga Street", "Noe Street", "Noriega Street", "Octavia Street", "O'Farrell Street",
  "Ortega Street", "O'Shaughnessy Blvd", "Otis Street", "Pacheco Street", "Palou Avenue", "Peter Yorke Way", "Phelan Avenue",
  "Pierce Street", "Polk Street", "Portola Avenue", "Potrero Ave", "Rivera Street", "Rolph Street", "Sanchez Street",
  "Sansome Street", "Scott St", "Selby St", "Shafter Avenue", "Sheridan St", "Shotwell St", "Shrader St.",
  "Sloat Boulevard", "Spear St", "Stanyan St", "Steiner St", "Steuart St", "Stockton Street", "Sutter Street",
  "Taraval Street", "Taylor Street", "Terry A Francois Boulevard", "Thomas Avenue", "Tonquin Street", "Townsend Street",
  "Treat St", "Turk Street", "Ulloa Street", "Valencia Street", "Vallejo Street", "Van Ness Avenue", "Via Ferlinghetti",
  "Vicente Street", "Waller Street", "Washington Street", "Wawona Street", "Webb Street", "Yorba Street", "Zarick Street"
]

NEIGHBORHOODS = [
  "Bernal Heights", "Castro", "Chinatown", "Cole Valley", "Deco Ghetto", "Fisherman's Wharf", "Golden Gate Park", "Haight",
  "Hayes Valley", "Inner Richmond", "Inner Sunset", "Marina", "Mission", "Mission to Potrero", "Dolores", "Valencia Corridor",
  "24th Street", "Nob Hill", "Noe Valley", "North Beach", "Outer Richmond", "Outer Sunset", "Pacific Heights", "Potrero Hill",
  "Russian Hill", "SoMa", "Tenderloin", "Union Square", "Western Addition"
]

SPOT_TYPES = [
  "parking spot", "space", "spot", "yard", "driveway", "street parking", "parking spot", "double spot", "garage",
  "covered parking place", "parking lot"
]

NONCE = [
  "available", "ready for your car", "for rent", "from 9-5", "available weekdays", "available on weekends", "perfect for your winnebago",
  "close to AT&T Park", "near Giants Stadium", "motorcycle friendly", "going fast", "in quiet neighborhood", "for commuter", "", "", "", ""
]

ZIP_CODES = []

def generate_fake_spot_data
  my_spot = SPOT_TYPES.sample
  my_street = STREET_NAMES.sample
  my_hood = NEIGHBORHOODS.sample
  my_chatter = NONCE.sample
  my_description = [my_hood, my_street].sample + " " + my_spot + " " + my_chatter
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

100.times do |create_fake_users|
  print "."
  begin
    User.create!(
         email: Faker::Internet.user_name,
      username: Faker::Internet.email,
      password: "foobar",
      password_confirmation: "foobar"
    )
  rescue
    print "x"
  end

end

puts "\n----Creating & Assigning Spots-----"

VALID_USER_IDS = User.pluck(:id)

80.times do |create_and_assign_spots|
  print "."
  begin
    new_spot = Spot.create!(generate_fake_spot_data)
  rescue
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