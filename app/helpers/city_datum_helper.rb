module CityDatumHelper
  def parse_search(user_input)
    if user_input =~ /(?:^|\s)(\d{5}|\d{5}-\d{4})(?:\s|$)/
      #zipcode
      find_by_zip(user_input[/\d{5}/])
    elsif user_input =~ /^([a-zA-Z]+\s?)+/
      #neighborhood
      find_by_hood(user_input)
    elsif user_input =~ /\d+\w?\s\D*/
      #address
      find_by_address(user_input)
    else
      "error parsing search input"
    end
  end

  def find_by_zip(input)
    Spot.where(zip_code: input).last
  end

  def find_by_hood(input)
    zip = CityData.where(neighborhood: input.downcase).select(:zip_code)
    find_by_zip(zip)
  end

  def find_by_address(input)
    #Geocoder.search(input)
  end

end