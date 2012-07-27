require 'spec_helper'

describe Product::Photo do
  # Associations
  it { should belong_to(:product) }

  # Validations
  # title
  it { should ensure_length_of(:title).is_at_most(100) }

  # product_id
  it { should validate_presence_of(:product) }

  context "with valid attributes" do
    it "should be valid" do
      Product::Photo.new(valid_product_photo_attributes).should be_valid
    end
  end
end
