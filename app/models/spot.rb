class Spot < ActiveRecord::Base
  belongs_to :user
  has_many :reservations
  has_many :renters, :through => :reservations
  validates_presence_of :zip_code, :street, :price, :location_type, :start_date, :end_date
  validate :date_cannot_be_in_the_past, :start_date_cannot_be_after_end_date
  # geocoded_by :street do |spot_obj,results|
  #   if geo = results.first
  #     spot_obj.latitude = geo.latitude
  #     spot_obj.longitude = geo.longitude
  #   end
  # end
  # after_validation :geocode

  private

  def date_cannot_be_in_the_past
    if Date.parse(start_date) < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end

  def start_date_cannot_be_after_end_date
    if Date.parse(start_date) > Date.parse(end_date)
      errors.add(:start_date, "can't be after end_date")
    end
  end

end