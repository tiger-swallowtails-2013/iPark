class SpotsController < ApplicationController
  include SpotsHelper
  include CityDatumHelper

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(params.require(:spot).permit(:street, :zip_code, :price, :description, :location_type))
    if @spot.save
      current_user.spots << @spot
      set_up_reservations(@spot, params)
      redirect_to spots_path
    else
      redirect_to new_spot_path
    end
  end

  def show
    @spot = Spot.find(params[:id])
  end

  def index
    @spot = Spot.new
    @spots = Spot.all
    if signed_in?
      render :index
    else
      redirect_to new_session_path
    end
  end

  def destroy
    spot = Spot.find(params[:spot][:id])
    spot.destroy
    redirect_to spots_path
  end

  def find
    spots = Spot.last(10)
    render json: spots.to_json
  end

  def search
    query = params[:q]
    results = parse_search(query)
    geolocations = get_latitudes_longitudes(results)
    render json: geolocations.to_json
  end

  private

  def get_latitudes_longitudes(locations)
    locations.map { |l| [l.latitude, l.longitude] }
  end

end

