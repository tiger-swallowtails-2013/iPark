  module CityDatumHelper
  def parse_search(user_input)
    if user_input =~ /(?:^|\s)(\d{5}|\d{5}-\d{4})(?:\s|$)/
      find_by_zip(user_input[/\d{5}/])
    elsif user_input =~ /^([a-zA-Z]+\s?)+/
      find_by_hood(user_input)
    elsif user_input =~ /\d+\w?\s\D*/
      find_by_address(user_input)
    else
      last_five_newest_available_spots
    end
  end

  def find_by_zip(input)
    Spot.where(zip_code: input)
  end

  def find_by_hood(input)
    query = input.downcase
    suggestions = CityData.where('neighborhood LIKE ?', "%#{query}%").select(:zip_code)
    arbitrary_zip = suggestions[0].zip_code unless suggestions[0].nil?
    if arbitrary_zip
      find_by_zip(arbitrary_zip)
    else
      last_five_newest_available_spots
    end
  end

  def find_by_address(input)
    json_results = Geocoder.search(input + " san francisco california")
    zip = parse_json_for_zip(json_results)
    find_by_zip(zip)
  end

  def parse_json_for_zip(json_results)
    json_results.each{|x| return x.postal_code if x.postal_code[0,2] == "94"}
  end

  def last_five_newest_available_spots
    Spot.last(5).select{|spot| spot unless spot.reservations.where(renter_id: nil)[0].nil?}
  end


end