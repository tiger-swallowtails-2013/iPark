require 'spec_helper'

describe Spot do
  let(:spot) { FactoryGirl.build(:spot) }

  before (:each) do
    Spot.destroy_all
  end

  it { should belong_to(:user) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:location_type) }

  context "given valid dates" do
    it "should save when start and end dates are the same" do
      spot.start_date = (Date.today).to_s.slice(0,10)
      spot.end_date = (Date.today).to_s.slice(0,10)
      expect{spot.save!}.to change{Spot.count}.by(1)
    end
    it "should save given a valid date range" do
      expect{spot.save!}.to change{Spot.count}.by(1)
    end
  end
  context "given invalid dates" do
    it "should not save if end_date is before start_date" do
      spot.start_date = (Date.today + 1).to_s.slice(0,10)
      spot.end_date = (Date.today).to_s.slice(0,10)
      expect{spot.save!}.to raise_error
    end
    it "should not save if start_date is in the past" do
      spot.start_date = (Date.today - 10).to_s.slice(0,10)
      spot.end_date = (Date.today + 1).to_s.slice(0,10)
      expect{spot.save!}.to raise_error
    end
  end
end
