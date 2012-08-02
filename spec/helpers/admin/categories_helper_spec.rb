require "spec_helper"

module Admin
  module CategoriesHelper
    describe "#shop_category_path_for_form" do
      fixtures :shops

      let(:shop) { shops(:sporilek) }
      let(:category) { mock_model(Category) }

      def method_result
        helper.shop_category_path_for_form(shop, category)
      end

      it "returns 'admin_shop_categories_path' for new resource" do
        category.as_new_record
        method_result.should == admin_shop_categories_path(shop)
      end

      it "returns 'admin_shop_category_path' for existing resource" do
        method_result.should == admin_shop_category_path(shop, category)
      end
    end
  end
end