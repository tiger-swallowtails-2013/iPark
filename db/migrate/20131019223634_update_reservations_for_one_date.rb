class UpdateReservationsForOneDate < ActiveRecord::Migration
  def change
    add_column :reservations, :date, :string
    remove_column :reservations, :day, :string
    remove_column :reservations, :month, :string
    remove_column :reservations, :year, :string
  end
end
