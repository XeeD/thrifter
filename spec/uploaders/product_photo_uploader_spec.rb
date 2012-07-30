require "spec_helper"
require 'carrierwave/test/matchers'

describe ProductPhotoUploader do
  include CarrierWave::Test::Matchers

  let(:product_photo) { Product::Photo.first }
  let(:uploader) { ProductPhotoUploader.new(product_photo, :image) }

  def store_dir
    "/img/produkty/#{product_photo.product_id}-#{product_photo.product.url}"
  end

  def regexp_for_path_and_filename(filename)
    store_dir_regexp = Regexp.escape(store_dir)
    filename_regexp = Regexp.escape(filename)
    /#{store_dir_regexp}\/#{filename_regexp}$/
  end

  before do
    ProductPhotoUploader.enable_processing = true
    uploader.store!(File.open(File.join(Rails.root, "spec/fixtures/images/product.jpg")))
  end

  after do
    ProductPhotoUploader.enable_processing = false
    uploader.remove!
  end

  it "stores the images in img/produkty/\#{model.product_id}-\#{model.product.url}/" do
    uploader.path.should =~ /#{Regexp.escape(store_dir)}\/[^\/]+$/
  end

  context "admin_thumb version" do
    it "should scale down a landscape image to fit within 100 by 100 pixels" do
      uploader.admin_thumb.should be_no_larger_than(100, 100)
    end

    it "saves it as admin_thumb_image.png" do
      uploader.admin_thumb.path.should =~ regexp_for_path_and_filename("admin_thumb_image.jpg")
    end
  end

  context "big_admin_thumb version" do
    it "should scale down a landscape image to fit within 200 by 200 pixels" do
      uploader.big_admin_thumb.should be_no_larger_than(200, 200)
    end

    it "saves it as admin_thumb_image.png" do
      uploader.big_admin_thumb.path.should =~ regexp_for_path_and_filename("big_admin_thumb_image.jpg")
    end
  end

  context "original version" do
    it "saves it as original_image.png" do
      uploader.original.path.should =~ regexp_for_path_and_filename("original_image.png")
    end
  end
end