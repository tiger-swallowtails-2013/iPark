class CreateReservationTable < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.belongs_to :user
      t.belongs_to :spot
      t.integer :day 
      t.integer :month
      t.integer :year
      t.timestamps
    end
  end
end
