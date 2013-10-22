class User < ActiveRecord::Base
  has_secure_password
  has_many :reservations
  has_many :rented_reservations, class_name: "Reservation", foreign_key: "renter_id"
  has_many :spots, :through => :reservations
  has_many :spots
  validates_presence_of :email, :username, :password_digest, :password_confirmation
  validates_uniqueness_of :email
end