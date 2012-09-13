require 'spec_helper'

describe ShippingMethod do
  # Associations
  it { should have_many(:shipments) }
  it { should have_many(:orders).through(:shipments) }
  it { should have_many(:package_sizes) }
  it { should have_and_belong_to_many(:shops) }

  # Validations
  # shops
  it { should validate_presence_of(:shops) }

  # name
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(100) }

  # short_description
  it { should validate_presence_of(:short_description) }

  # description
  it { should validate_presence_of(:description) }

  #context "with valid attributes" do
  #  it "should be valid" do
  #    ShippingMethod.new(valid_shipping_method_attributes).should be_valid
  #  end
  #end
end