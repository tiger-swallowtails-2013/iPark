class User < ActiveRecord::Base
  has_secure_password
  has_many :spots
  validates_presence_of :email, :username, :password_digest, :password_confirmation
  validates_uniqueness_of :email
end