class CityData < ActiveRecord::Base
    validates_presence_of :zip_code, :neighborhood
end
