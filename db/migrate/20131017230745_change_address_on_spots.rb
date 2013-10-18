class ChangeAddressOnSpots < ActiveRecord::Migration
  def change
    add_column :spots, :street, :string
    add_column :spots, :zip_code, :string
    remove_column :spots, :location, :string
  end
end
