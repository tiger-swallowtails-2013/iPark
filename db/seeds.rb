STREET_NAMES = [
  "Alemany Boulevard", "Alvarado Street", "Ambrose Bierce Alley", "Anza Street", "Arguello Boulevard", "Ashbury Street",
  "Baker Street", "Balboa Street", "Bartlett Street", "Beale Street", "Bernal Avenue", "Bluxome Street", "Brannan Street",
  "Brenham Place", "Broderick Street", "Bryant Street", "Buchanan Street", "Burnett Avenue", "Bush Street", "Cabrillo Street",
  "California Street", "Castro Street", "Cesar Chavez Street", "Clark Street", "Cole Street", "Coleman Street",
  "Colin P Kelly Junior Street", "Davidson Street", "Davis Street", "De Haro Street", "Dirk Dirksen Place", "Divisadero Street",
  "Dolores Street", "Duncan Street", "Elizabeth Street", "Fillmore Street", "Folsom Street", "Franklin Street", "Fremont Street",
  "Fulton Street", "Funston Street", "Geary Boulevard", "Gough Street", "Grant Street", "Guerrero Street", "Haight Street",
  "Harrison Street", "Hayes Street", "Howard Street", "Hyde Street", "Ingalls Street", "Irving Street", "Jack Kerouac Alley",
  "Jack Micheline Alley", "Jackson Street", "Jefferson Street", "Jerrold Avenue", "Jersey Street", "John F. Shelley Drive",
  "John Muir Drive", "Jones Street", "Joost Avenue", "Jose Sarria Court", "Juan Bautista Circle", "Judah Street",
  "Junipero Serra Boulevard", "Justin Herman Plaza", "Kearny Street", "Keyes Avenue", "Kezar Drive", "Kirkham Street",
  "Laguna Street", "Lane Street", "Lapham Way", "Lapu Lapu Street", "Larkin Street", "Laussat Street", "Lawton Street",
  "Leavenworth Street", "Le Conte Avenue", "Lech Walesa Street", "Leese Street", "Leidesdorff Street", "Lendrum Street",
  "Liggett Avenue", "Linares Avenue", "Lincoln Boulevard", "Lincoln Court", "Lincoln Way", "Lombard Street", "Mason Street",
  "McAllister Street", "Montgomery Street", "Moraga Street", "Noe Street", "Noriega Street", "Octavia Street", "O'Farrell Street",
  "Ortega Street", "O'Shaughnessy Boulevard", "Otis Street", "Pacheco Street", "Palou Avenue", "Peter Yorke Way", "Phelan Avenue",
  "Pierce Street", "Polk Street", "Portola Avenue", "Potrero Avenue", "Rivera Street", "Rolph Street", "Sanchez Street",
  "Sansome Street", "Scott Street", "Selby Street", "Shafter Avenue", "Sheridan Street", "Shotwell Street", "Shrader Street.",
  "Sloat Boulevard", "Spear Street", "Stanyan Street", "Steiner Street", "Steuart Street", "Stockton Street", "Sutter Street",
  "Taraval Street", "Taylor Street", "Terry A Francois Boulevard", "Thomas Avenue", "Tonquin Street", "Townsend Street",
  "Treat Street", "Turk Street", "Ulloa Street", "Valencia Street", "Vallejo Street", "Van Ness Avenue", "Via Ferlinghetti",
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

def fake_spot_description
  my_spot = SPOT_TYPES.sample
  my_street = STREET_NAMES.sample
  my_hood = NEIGHBORHOODS.sample
  my_chatter = NONCE.sample
  my_description = [my_hood, my_street].sample + " " + my_spot + " " + my_chatter
  return {
      location_type: my_spot,
      description: my_description,
      street: my_street,
      zipcode: 94102 + rand(88)
    }
end

1.times do |make_test_users|
  User.create!(
       email: 'test@test.com',
    username: 'test',
    password: 'test'
  )
  User.create!(
       email: 'nishant@test.com',
    username: 'nishant',
    password: 'nishant'
  )
  User.create!(
       email: 'morgan@test.com',
    username: 'morgan',
    password: 'morgan'
  )
end

500.times do |create_fake_users|
  User.create!(
       email: Faker::Internet.user_name,
    username: Faker::Internet.email,
    password: "foobar",
    password_confirmation: "foobar"
  )
end

300.times do |create_and_assign_spots|
    my_description = fake_spot_description
    new_spot =  Spot.create!(
                  street: my_description[:street],
                  zipcode: my_description[:zipcode],
                  price: rand(1..30),
                  description: my_description[:description],
                  location_type: my_description[:type]
                )
    User.find(rand(1..100)).spots << new_spot
end


