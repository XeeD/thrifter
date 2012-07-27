require "spec_helper"
require 'carrierwave/test/matchers'

describe ProductPhotoUploader do
  include CarrierWave::Test::Matchers

  before do
    ProductPhotoUploader.enable_processing = true
    @product_photo = Product::Photo.first
    @uploader = ProductPhotoUploader.new(@product_photo, :image)
    @uploader.store!(File.open(File.join(Rails.root, "spec/resources/images/product.jpg")))
  end

  after do
    ProductPhotoUploader.enable_processing = false
    @uploader.remove!
  end

  context 'the admin_thumb version' do
    it "should scale down a landscape image to fit within 100 by 100 pixels" do
      @uploader.admin_thumb.should be_no_larger_than(100, 100)
    end
  end
end