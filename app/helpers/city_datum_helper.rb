  module CityDatumHelper
  def parse_search(user_input)
    if user_input =~ /(?:^|\s)(\d{5}|\d{5}-\d{4})(?:\s|$)/
      find_by_zip(user_input[/\d{5}/])
    elsif user_input =~ /^([a-zA-Z]+\s?)+/
      find_by_hood(user_input)
    elsif user_input =~ /\d+\w?\s\D*/
      find_by_address(user_input)
    else
      "error parsing search input"
    end
  end

  def find_by_zip(input)
    return Spot.where(zip_code: input)
  end

  def find_by_hood(input)
    zip = CityData.where(neighborhood: input.downcase).select(:zip_code)
    find_by_zip(zip)
  end

  def find_by_address(input)
    json_results = Geocoder.search(input + " san francisco california")
    zip = parse_json_for_zip(json_results)
    find_by_zip(zip)
  end

  def parse_json_for_zip(json_results)
    json_results.each{|x| return x.postal_code if x.postal_code[0,2] == "94"}
  end

end