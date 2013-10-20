class SpotsController < ApplicationController
  include SpotsHelper

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
        redirect_to new_spot_path and return
      end
    end
    redirect_to new_spot_path and return
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
    render json: spot.to_json
  end
end
