class SpotsController < ApplicationController
  include SpotsHelper
  include CityDatumHelper
  include ReservationsHelper

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(params.require(:spot).permit(:street, :zip_code, :price, :description, :location_type))
    set_date_span(@spot, params)
    unless @spot.start_date.nil?
      if @spot.save
        current_user.spots << @spot
        create_reservations(@spot, params)
      end
    end
    redirect_to spots_path 
  end

  def show
    @spot = Spot.find(params[:id])
  end

  def index
  end

  def destroy
    spot = Spot.find(params[:spot][:id])
    spot.destroy
    redirect_to spots_path
  end

  def search
    query = params[:q] || "94108"
    date = (params[:d].empty? ? Date.today.strftime("%Y\-%m\-%d") : params[:d])
    results = parse_search(query)
    good_results = results.select{|spot| spot unless spot.reservations.where(date: date, renter_id: nil)[0].nil?}
    if good_results.empty?
      redirect_to spots_path # this may cause an infinite loop if there are no spots in default location (c-town) on default date (today)
    else
      render json: good_results.to_json
    end
  end

  def autocomplete
    query = params[:q].downcase
    suggestions = CityData.where('neighborhood LIKE ?', "%#{query}%").select(:neighborhood)
    suggestions.map!{|obj| obj.neighborhood.titleize }
    render json: suggestions.to_json
  end

  def hood
    query = params[:q]
    results = CityData.find_by_zip_code(query)
    place = results.neighborhood.capitalize
    render json: place.to_json
  end
end
