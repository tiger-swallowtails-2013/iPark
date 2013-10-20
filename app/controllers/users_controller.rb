class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :password, :email, :password_confirmation))
    if @user.save
      redirect_to spots_path
    else
      render :new
    end
  end

  def show
    @your_reservations = Reservation.all.where(renter_id: current_user.id.to_s)
    @your_spots = current_user.spots
  end
end