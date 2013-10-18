class CreateReservationTable < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.belongs_to :user
      t.belongs_to :spot
      t.string :days
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
