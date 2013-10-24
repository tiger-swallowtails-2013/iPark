module ReservationsHelper

  def dates_to_array(params)
    new_reservation_dates = params[:dates].split(",")
  end

  def parse_too_long_dates(params)
    parsed_dates = dates_to_array(params).map{|date| date.slice(0..14)}
  end

  def create_dates_from_strings(params)
    short_dates = parse_too_long_dates(params)
    date_objects = short_dates.map{|date| Date.parse(date).to_s}
    date_objects
  end

  def create_reservations_with_date_objects(params)
    dates = create_dates_from_strings(params)
    dates.each do |date|
      reservation = Reservation.create(date: date)
      current_user.reservations << reservation
      @spot.reservations << reservation
    end
  end

  def show_current_dates(reservations)
    dates = reservations.map do |reservation|
      reservation.date.to_date.inspect
    end
    content_tag :ul do
      dates.collect {|date| concat(content_tag(:p, date))}
    end
  end

  def reserved?(reservation)
    reservation.renter_id != nil
  end

  def reservation_notification?(reservation)
     reservation.notification == true
  end

  def find_spot(reservation)
    spot = Spot.find(reservation.spot_id)
  end

  def rented_by(reservation)
    User.find(reservation.renter_id).username
  end
end
