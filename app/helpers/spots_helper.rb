module CitySearchHelper
  def parse_search(user_input)
    if user_input =~ /\d{5}-?\d{4}?/
      #zipcode
      find_by_zip(user_input[/\d{5}/])
    elsif user_input =~ /^([a-zA-Z]+\s?)+/
      #neighborhood
      find_by_hood(user_input)
    elsif user_input =~ /\d+\w?\s\D*/ #skips zip code => \d+\w?\s\D*(\d{5}-?\d{4}?)?/
      #address
      find_by_address(user_input)
    else
      puts "error parsing search input"
    end
  end

  def find_by_zip(input)
    puts Spot.where(zip_code: input).limit(1)
  end

  def find_by_hood(input)
    zip = CityData.where(neighborhood: input.downcase).select(:zip_code)
    find_by_zip(zip)
  end

  def find_by_address(input)
    #Geocoder.search(input)
  end
end

__END__

#test strings:
["717 California St", "94108", "chinatown", "Noe Valley", "717a California Ave 94108-1232"].each{|str| parse_search(str)}