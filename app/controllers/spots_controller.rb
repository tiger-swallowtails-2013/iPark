class SpotsController < ApplicationController

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(params.require(:spot).permit(:street, :zip_code, :price, :description, :location_type))
    if @spot.save
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
end
