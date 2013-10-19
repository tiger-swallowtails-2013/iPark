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