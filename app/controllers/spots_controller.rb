class SpotsController < ApplicationController

  def new
    @spot = Spot.new
  end

  def create
    # {"utf8"=>"✓", "authenticity_token"=>"lkG6yi826S1ukjZ7aSbrvgselLTdAi4rIpLFoe6XtPQ=", "spot"=>{"street"=>"a", "zip_code"=>"a", "price"=>"a", "location_type"=>"a", "monday"=>"1"}, "commit"=>"Create Spot"}
    @spot = Spot.new(params.require(:spot).permit(:street, :zip_code, :price, :description, :location_type))
    if @spot.save
      p @spot
      current_user.spots << @spot
      redirect_to spots_path
    else
      render :new
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

