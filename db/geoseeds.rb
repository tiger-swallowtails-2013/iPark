# This is its own file so that we can seed production data seperately from test data

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


ZIP_CODE_NEIGHBORHOOD_LOOKUP = {
  "94102" => ["Hayes Valley", "Tenderloin", "North of Market"],
  "94103" => ["SoMa"],
  "94104" => ["Financial District"],
  "94105" => ["Embarcadero", "SoMa"],
  "94107" => ["Potrero Hill"],
  "94108" => ["Chinatown"],
  "94109" => ["Nob Hill", "Russian Hill"],
  "94110" => ["Mission", "Bernal Heights"],
  "94111" => ["Embarcadero", "Barbary Coast"],
  "94112" => ["Ingelside-Excelsior"],
  "94114" => ["Castro", "Noe Valley"],
  "94115" => ["Pacific Heights", "Western Addition", "Japantown"],
  "94116" => ["Outer Sunset"],
  "94117" => ["Haight Ashbury", "Cole Valley"],
  "94118" => ["Inner Richmond"],
  "94121" => ["Outer Richmond"],
  "94122" => ["Inner Sunset"],
  "94123" => ["Marina", "Cow Hollow"],
  "94124" => ["Bayview"],
  "94127" => ["St. Francis Wood", "West Portal"],
  "94129" => ["Presidio"],
  "94131" => ["Twin Peaks", "Glen Park"],
  "94132" => ["Lake Merced"],
  "94133" => ["North Beach", "Fisherman's Wharf"],
  "94134" => ["Visitacion Valley"]
}