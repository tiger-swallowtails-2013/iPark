class Spots < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :location, :price, :type, :user
end