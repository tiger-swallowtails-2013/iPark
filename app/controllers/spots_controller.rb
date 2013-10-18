class SpotsController < ApplicationController

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(params.require(:spot).permit(:street, :zip_code, :price, :description, :location_type))
    if @spot.save
      render :index
    else
      render :new
    end
  end

  def show
    @spot = Spot.find(params[:id])
  end

  def index
    @spots = Spot.all
  end

  def destroy
    spot = Spot.find(params[:id])
    spot.destroy
    render :index
  end
end
