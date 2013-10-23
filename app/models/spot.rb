class Spot < ActiveRecord::Base
  belongs_to :user
  has_many :reservations
  has_many :renters, :through => :reservations
  validates_presence_of :zip_code, :street, :price, :location_type, :start_date, :end_date
  validate :date_cannot_be_in_the_past, :start_date_cannot_be_after_end_date
  geocoded_by :address do |spot_obj,results|
    if geo = results.first
      spot_obj.latitude = geo.latitude
      spot_obj.longitude = geo.longitude
    end
  end
  after_validation :geocode

  private

  def address
    [street, zip_code].compact.join(', ')
  end

  def date_cannot_be_in_the_past
    if dates_are_present && Date.parse(start_date.to_s) < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end

  def start_date_cannot_be_after_end_date
    if dates_are_present && Date.parse(start_date.to_s) > Date.parse(end_date.to_s)
      errors.add(:start_date, "can't be after end_date")
    end
  end

  def dates_are_present
    start_date.present? && end_date.present?
  end

end