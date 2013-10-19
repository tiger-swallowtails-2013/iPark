class CreateCityData < ActiveRecord::Migration
  def change
    create_table :city_data do |t|
      t.string :zip_code
      t.string :neighborhood
      t.timestamps
    end
  end
end
