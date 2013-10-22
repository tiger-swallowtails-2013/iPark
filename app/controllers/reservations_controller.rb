class ReservationsController < ApplicationController
  include ReservationsHelper

  def update
    reservation = Reservation.find(params[:id])
    spot = reservation.spot_id
    reservation.update_attribute(:renter_id, current_user.id)
    if reservation.save
      reservation.update_attribute(:notification, true)
      User.find(reservation.user_id).update_attribute(:notification, true)
      redirect_to spot_path(spot)
    else
      redirect_to spot_path(spot)
    end
  end

  def destroy
    reservation = Reservation.find(params[:id])
    reservation.destroy
    redirect_to user_path(current_user)
  end

  def new
    @spot = Spot.find(params[:spot_id])
    @reservations = @spot.reservations
  end

  def create
    @spot = Spot.find(params[:spot_id])
    dates = create_reservations_with_date_objects(params)
    redirect_to new_reservation_path(spot_id: @spot.id)
  end

  def clear_notifications
    current_user.update_attribute(:notification, false)
    active_reservations = Reservation.where(notification: true)
    active_reservations.each {|reservation| reservation.update_attribute(:notification, false)}
    redirect_to user_path(current_user)
  end
end