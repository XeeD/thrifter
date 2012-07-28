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

  context "when saving with uploaded image file" do
    def valid_product_photo_attributes_with_image
      valid_product_photo_attributes.merge(image: File.new(Rails.root + "spec/fixtures/images/product.jpg"))
    end

    it "saves the image" do
      product_photo = Product::Photo.new(valid_product_photo_attributes_with_image)
      product_photo.save
      File.exists?(product_photo.image.path).should be_true
    end
  end

  context "when setting photo as main" do
    context "and another photo is already main" do
      it "sets current main photo as not main when creating new main photo" do
        current_main = Product::Photo.where(main_photo: true).first
        Product::Photo.create(product_id: current_main.product_id, main_photo: true)
        current_main.reload
        current_main.should_not be_main_photo
      end

      it "sets current main photo as not main when another photo is set as main" do
        current_main = Product::Photo.where(main_photo: true).first
        current_not_main = Product::Photo.where(main_photo: true).first
        current_not_main.main_photo = true
        current_not_main.save
        current_main.reload
        current_main.should_not be_main_photo
      end
    end
  end
end
