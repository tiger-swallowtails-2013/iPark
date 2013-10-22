class AddNotificationsToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :notification, :boolean, :default => false
  end
end
