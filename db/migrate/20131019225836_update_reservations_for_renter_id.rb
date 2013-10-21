class UpdateReservationsForRenterId < ActiveRecord::Migration
  def change
    add_column :reservations, :renter_id, :integer
  end
end
