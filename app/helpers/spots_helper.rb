module SpotsHelper
  def parse_search(user_input)
    if user_input =~ /\d{5}-?\d{4}?/
      #zipcode
      find_by_zip(user_input)
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
    Spot.where(zip_code: input).limit(10)
  end

  def find_by_hood(input)

    #checks neighborhood_zipcode_lookup for zipcode
  end

  def find_by_address(input)
    #queries google maps for geo-coordinates and/or zipcode
  end
end
