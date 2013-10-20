class Spot < ActiveRecord::Base
  belongs_to :user
  has_many :reservations
  has_many :users, :through => :reservations
  validates_presence_of :zip_code, :street, :price, :location_type
  geocoded_by :street do |spot_obj,results|
    if geo = results.first
      spot_obj.zip_code = geo.postal_code # this ONLY applies to test env seed data
      spot_obj.latitude = geo.latitude
      spot_obj.longitude = geo.longitude
    end
  end
  after_validation :geocode
end