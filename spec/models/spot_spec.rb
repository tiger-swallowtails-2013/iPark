require 'spec_helper'

describe Spot do
  it { should belong_to(:user) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:user) }
end
