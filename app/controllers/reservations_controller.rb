class ReservationsController < ApplicationController
  def update
    reservation = Reservation.find(params[:id])
    spot = reservation.spot_id
    reservation.update_attribute(:renter_id, current_user.id)
    reservation.save
    redirect_to spot_path(spot)
  end
end