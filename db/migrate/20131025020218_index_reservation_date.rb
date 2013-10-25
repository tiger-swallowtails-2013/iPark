class IndexReservationDate < ActiveRecord::Migration
  def change
   add_index :reservations, :date
  end
end
