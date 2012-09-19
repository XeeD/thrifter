require 'spec_helper'

describe PaymentMethod do
  # Associations
  it { should have_many(:payments) }
  it { should have_many(:orders).through(:payments) }
  it { should have_and_belong_to_many(:shops) }
  it { should have_and_belong_to_many(:shipping_methods) }

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

  context "with valid attributes" do
    it "should be valid" do
      PaymentMethod.new(valid_payment_method_attributes).should be_valid
    end
  end
end