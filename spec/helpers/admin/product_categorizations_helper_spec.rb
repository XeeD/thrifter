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
end
