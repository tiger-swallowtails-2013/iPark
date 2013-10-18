class Spot < ActiveRecord::Base
  belongs_to :user
  has_many :reservations
  has_many :users, :through => :reservations
  validates_presence_of :zip_code, :street, :price, :location_type
end