class SpotsController < ApplicationController
  include SpotsHelper

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
    spot = Spot.last(10)
    geolocations = spot.map { |location| [location.latitude, location.longitude] }
    render json: geolocations.to_json
  end


end

