SPOT_TYPES = [
  "parking spot", "space", "spot", "yard", "driveway", "street parking", "parking spot", "double spot", "garage",
  "covered parking place", "parking lot"
]

STATUS = [
  "available", "ready for your car", "for rent", "from 9-5", "available weekdays", "available on weekends", "perfect for your winnebago",
  "close to AT&T Park", "near Giants Stadium", "motorcycle friendly", "going fast", "in quiet neighborhood", "for commuter", "", "", "", ""
]

def generate_fake_spot_with_real_data
    my_price = rand(1..60)
    my_spot = SPOT_TYPES.sample

    dates_data = make_fake_dates
    my_start_date = dates_data[:start_date]
    my_end_date = dates_data[:end_date]
  begin
    my_street = STREET_NAMES.sample
    my_street_address = rand(1..3000).to_s + " " + my_street

    geocoder_data = hitup_google_for_data(my_street_address)
    my_zip_code = geocoder_data.postal_code
    my_latitude = geocoder_data.latitude
    my_longitude = geocoder_data.longitude
  rescue
    retry
  end
  my_user_id = VALID_USER_IDS.sample
  my_description = generate_spot_description(my_street, my_zip_code, my_spot)
  return {
      location_type: my_spot,
      description: my_description,
      street: my_street_address,
      latitude: my_latitude,
      longitude: my_longitude,
      zip_code: my_zip_code,
      price: my_price,
      user_id: my_user_id,
      start_date: my_start_date,
      end_date: my_end_date
  }

end

def make_fake_dates
  start_date = Date.today + rand(1..20)
  end_date = start_date + rand(1..20)
  {start_date: format_date(start_date), end_date: format_date(end_date)}
end

def format_date(date)
  date.to_s.slice(0,10)
end

def hitup_google_for_data(street_address)
  begin
    Geocoder.search(street_address + " san francisco california").each{|x| return x if x.postal_code[0,3] == "941"}
  rescue
    nil
  end
end

def generate_spot_description(my_street, my_zip_code, my_spot)
  begin
    my_hood_or_street = lookup_neighborhood_of_zipcode(my_zip_code)
  rescue
    my_hood_or_street = my_street
  end
  my_status = STATUS.sample
  my_description = my_hood_or_street + " " + my_spot + " " + my_status
end

def lookup_neighborhood_of_zipcode(zip_code)
  if hood = ZIP_CODE_NEIGHBORHOOD_LOOKUP[zip_code.to_s].sample
    return hood
  end
end