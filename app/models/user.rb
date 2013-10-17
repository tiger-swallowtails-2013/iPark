Class Users < ActiveRecord::Base
  has_many :spots
  validates_presence_of :email, :username, :password_digest,
  validates_uniqueness_of :email
end