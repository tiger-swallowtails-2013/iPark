class SpotsController < ApplicationController

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(params.require(:spot).permit(:street, :zip_code, :price, :description, :location_type))
    if @spot.save
      render :index
    else
      redirect_to :new
    end
  end

  def show
    p 'got here'
    @spot = Spot.find(params[:id])
  end

  def index
  end
end
