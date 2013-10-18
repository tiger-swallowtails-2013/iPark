class CreateReservationTable < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.belongs_to :user
      t.belongs_to :spot
      t.string :day
      t.string :year
      t.string :month
      t.timestamps
    end
  end
end
