require 'spec_helper'

describe PackageSize do
  # Associations
  it { should belong_to(:shipping_method) }

  # Validations
  # weight_min
  it { should validate_presence_of(:weight_min) }

  # weight_max
  it { should validate_presence_of(:weight_max) }

  # price
  it { should validate_presence_of(:price) }

  context "with valid attributes" do
    it "should be valid" do
      PackageSize.new(valid_package_size_attributes).should be_valid
    end
  end
end