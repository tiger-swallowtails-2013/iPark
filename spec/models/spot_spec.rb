require 'spec_helper'

describe Spot do
  it { should belong_to(:user) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:location_type) }
end
