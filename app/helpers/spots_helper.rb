module SpotsHelper

  def create_start_date(params)
    date_list = params["startDate"]["{:order=>"][":day, :month, :year"]
    day = date_list["}(3i)"].to_i
    month = date_list["}(2i)"].to_i
    year = date_list["}(1i)"].to_i
    Date.new(year, month, day)
  end

  def create_end_date(params)
    date_list = params["endDate"]["{:order=>"][":day, :month, :year"]
    day = date_list["}(3i)"].to_i
    month = date_list["}(2i)"].to_i
    year = date_list["}(1i)"].to_i
    Date.new(year, month, day)
  end

  def create_date_span(params)
    date_span = {
      end_date: create_end_date(params),
      start_date: create_start_date(params)
    }
  end

  def set_date_span(spot, params)
    date_span = create_date_span(params)
    spot.end_date = date_span[:end_date] 
    spot.start_date = date_span[:start_date]
  end

end
