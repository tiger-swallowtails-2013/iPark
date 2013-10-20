module SpotsHelper


  def create_date(params, type)
    date_list = params[type]["{:order=>"][":day, :month, :year"]
    day = date_list["}(3i)"].to_i
    month = date_list["}(2i)"].to_i
    year = date_list["}(1i)"].to_i
    Date.new(year, month, day)
  end

  def create_date_span(params)
    date_span = {
      end_date: create_date(params, "endDate"),
      start_date: create_date(params, "startDate")
    }
  end

  def set_date_span(spot, params)
    date_span = create_date_span(params)
    spot.end_date = date_span[:end_date] 
    spot.start_date = date_span[:start_date]
    spot.save
  end

  # parse user's chosen dates

  def chosen_days(params)
    days_of_week = {1 => "monday", 2 => "tuesday", 3 => "wednesday", 4 => "thursday", 5 => "friday", 6 => "saturday", 0 => "sunday"}
    days_of_week.keep_if do |key, day|
      params["spot"][day] == "1"
    end 
    days_of_week
  end

  # create reservations

  def create_dates_for_reservations(spot, params)
    days_available = chosen_days(params)
    dates = []
    days_available.each do |key, day|
      start_date = spot.start_date
      end_date = spot.end_date 
      day = [key.to_i]
      result = (start_date..end_date).to_a.select {|k| day.include?(k.wday)}
      dates << result
    end
    dates
  end

  def create_reservations(spot, params)
    dates = create_dates_for_reservations(spot, params)
    dates.each do |date_array|
      date_array.each do |date|
        reservation = Reservation.create(date: date)
        spot.reservations << reservation
        current_user.reservations << reservation
      end
    end
  end

  def set_up_reservations(spot, params)
    set_date_span(@spot, params)
    create_reservations(@spot, params)
  end
end
