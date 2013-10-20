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
      parse_search("99999").should eq(spot)
      parse_search("99999-9999").should eq(spot)
    end
    it "by invalid zipcode" do
      parse_search("999999").should_not eq(spot)
      parse_search("999999").should eq("error parsing search input")
    end
    it "by neighborhood" do
      expect(parse_search("Test Town")).to eq(spot)
    end
    it "by street address with zipcode" do
      expect(parse_search("157 Test Town Dr. San Francisco, CA 99999-9999")).to eq(spot)
    end
    pending "by street address without zipcode" do
      expect(parse_search("157 Test Town Dr")).to eq(spot)
    end
    pending "by nonsensical phrases" do
      expect(parse_search("nonsensical asdfphrases")).to eq("error parsing search input")
    end
  end
end
