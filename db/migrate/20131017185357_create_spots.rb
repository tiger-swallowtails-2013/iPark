class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.references :user
      t.string :location
      t.integer :price
      t.string :image
      t.text :description
      t.string :type
      t.timestamps
    end
  end
end
