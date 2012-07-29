require "spec_helper"

module Admin
  module ProductPhotoHelper
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
  end
end