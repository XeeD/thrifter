require "spec_helper"

module Admin
  module ProductPhotosHelper
    describe "#product_photo_path_for_form" do
      let(:product) { mock_model(Product) }
      let(:product_photo) { mock_model(Product::Photo) }

      def method_result
        helper.product_photo_path_for_form(product, product_photo)
      end

      it "returns 'admin_product_photos_path' for new resource" do
        product_photo.as_new_record
        method_result.should == admin_product_photos_path(product)
      end

      it "returns 'admin_product_photo_path' for existing resource" do
        method_result.should == admin_product_photo_path(product, product_photo)
      end
    end

    describe "#additional_product_photos" do
      it "returns collection of persistent (new_record? == false) photos with main_photo == false" do
        photos = Product.first.photos
        photos.new(photos.first.attributes)
        helper.stub(product_photos: photos)
        helper.additional_product_photos.should == photos.reject(&:new_record?).reject(&:main_photo?)
      end
    end
  end
end