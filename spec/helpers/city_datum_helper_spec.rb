require 'spec_helper'

describe CityDatumHelper do

  before(:suite) do
    Spot.destroy_all
  end

  describe "searching for locations" do
    include CityDatumHelper
    let!(:spot) { FactoryGirl.create(:spot) }
    let!(:lookup) { CityData.create(zip_code: 99999, neighborhood: "test town") }

    before(:each) do
      spot.update_attribute(:zip_code, 99999)
    end

    it "by valid zipcode" do
      parse_search("99999").should include(spot)
      parse_search("99999-9999").should include(spot)
    end
    it "by invalid zipcode" do
      parse_search("999999").should eq("error parsing search input")
    end
    it "by neighborhood" do
      parse_search("Test Town").should include(spot)
    end
    it "by street address with zipcode" do
      parse_search("157 Test Town Dr. San Francisco, CA 99999-9999").should include(spot)
    end
    pending "by nonsensical phrases" do
      parse_search("nonsensical asdfphrases").should eq("error parsing search input")
    end
    it "by street address without zipcode [for a real location]" do
      devbootcamp = Spot.create!(user_id: 1, street: "717 California St", zip_code: 94108, price: 0, description: "Awesome", location_type: "on top of bike rack", start_date: "2013-10-30", end_date: "2013-10-30")
      another_location_with_same_zip = Spot.create!(user_id: 1, street: "710 California St", zip_code: 94108, price: 0, description: "Awesome", location_type: "on top of bike rack", start_date: "2013-10-30", end_date: "2013-10-30")
      parse_search("717 California St").should include(devbootcamp)
    end
  end
end
