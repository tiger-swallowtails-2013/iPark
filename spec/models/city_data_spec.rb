require 'spec_helper'

describe CityData do
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:neighborhood) }
end
