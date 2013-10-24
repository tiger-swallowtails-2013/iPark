class SpotsController < ApplicationController
  include SpotsHelper
  include CityDatumHelper

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
        redirect_to spots_path and return
      else
        redirect_to spots_path and return
      end
    end
    redirect_to spots_path and return
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
    results = parse_search(query)
    render json: results.to_json
  end

  def autocomplete
    query = params[:q].downcase
    suggestions = CityData.where('neighborhood LIKE ?', "%#{query}%").select(:neighborhood)
    suggestions.map!{|obj| obj.neighborhood.titleize }
    render json: suggestions.to_json
  end

  def hood
    query = params[:q]
    p query
    results = CityData.find_by_zip_code(query)
    p results
    place = results.neighborhood.capitalize
    p place
    # results.map!{ |place| place.neighborhood }
    render json: place.to_json
  end
end
