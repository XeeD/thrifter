require 'spec_helper'

describe Admin::ProductCategorizationsHelper do
  fixtures :products
  let(:product) { products(:samsung_tv) }

  describe "#assigned_shops" do
    it "returns all shops that the product is assigned to" do
      helper.stub(product: product)
      assigned_shops = product.categories.pluck(:shop_id).uniq
      helper.assigned_shops.map(&:id).should == assigned_shops
    end
  end

  describe "#preferred_category_in_shop" do
    fixtures :shops

    it "returns product's preferred category for given shop" do
      helper.stub(product: product)
      shop = shops(:sporilek)
      preferred_category = product.categorizations.preferred.in_shop(shop).first.category
      helper.preferred_category_in_shop(shop).id == preferred_category.id
    end
  end

  describe "#alternative_categories_in_shop" do
    fixtures :shops

    it "returns product's preferred category for given shop" do
      helper.stub(product: product)
      shop = shops(:sporilek)
      alternative_categories = product.alternative_categories.where(shop_id: shop.id)
      helper.alternative_categories_in_shop(shop) == alternative_categories
    end
  end

  describe "#shops" do
    it "calls Shop#all" do
      Shop.should_receive(:all)
      helper.shops
    end
  end

  describe "#already_assigned_categories_for_product" do
    fixtures :shops

    it "returns array of all categories assigned to products and their subcategories" do
      product = products(:samsung_tv)
      shop = shops(:sporilek)
      helper.stub(product: product)

      descendants = product.categories.map { |category| category.descendants.pluck(:id) }
      preferred = product.categorizations.preferred.in_shop(shop).pluck(:category_id)
      with_other_param_template =
          Category.in_shop(shop).
              where(category_type: :product_list).
              where("param_template_id != ? || param_template_id IS NULL", product.param_template.id).map do |category|
            category.self_and_descendants.pluck(:id)
          end

      expected = (descendants + preferred + with_other_param_template).flatten.uniq
      helper.disabled_categories_for_product_in_shop(shop).should == expected
    end
  end
end
