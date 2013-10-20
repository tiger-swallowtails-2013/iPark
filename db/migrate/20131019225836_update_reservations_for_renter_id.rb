class UpdateReservationsForRenterId < ActiveRecord::Migration
  def change
    add_column :reservations, :renter_id, :string
  end
end
