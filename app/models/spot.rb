class Spot < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :zip_code, :street, :price, :location_type
end