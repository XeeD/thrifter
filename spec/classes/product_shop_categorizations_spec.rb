# encoding: UTF-8
require 'spec_helper'

describe ProductShopCategorizations do
  describe "#set_alternative_categories" do
    fixtures :products
    fixtures :shops
    fixtures :categories
    fixtures :categorizations

    let(:product) { products(:samsung_tv) }
    let(:shop) { shops(:sporilek) }
    let(:product_shop_categorizations) { ProductShopCategorizations.new(product, shop) }

    def categorization_id(category_id)
      product.categorizations.find_by_category_id(category_id).id
    end

    def set_alternative_categories(category_ids)
      product_shop_categorizations.set_alternative_categories!(category_ids.map(&:to_s))
    end

    before do
      # Checking fixtures
      old_alternative_category_ids = product.alternative_categorizations.pluck(:category_id)
      old_alternative_category_ids.should == [7]
    end

    it "sets product's alternative_categories to category ids given as argument" do
      new_alternative_category_ids = [11, 12]
      set_alternative_categories(new_alternative_category_ids)

      persisted_category_ids = product.alternative_categorizations.pluck(:category_id)
      persisted_category_ids.should == new_alternative_category_ids
    end

    it "deletes unused categorizations and create new categorizations if needed" do
      to_be_deleted = categorization_id(7)
      set_alternative_categories([11])

      persisted_categorization_ids = product.alternative_categorizations.pluck(:id)
      persisted_categorization_ids.should_not include(to_be_deleted)
    end

    it "doesn't delete current categorizations when they are not changed" do
      current_categorization_id = categorization_id(7)
      set_alternative_categories([7, 11])

      persisted_categorization_ids = product.alternative_categorizations.pluck(:id)
      persisted_categorization_ids.should include(current_categorization_id)
    end

    it "doesn't delete preferred categories" do
      preferred_category = product.categorizations.preferred.pluck(:id)
      set_alternative_categories([11])

      product.categorizations.preferred.pluck(:id).should == preferred_category
    end

    it "doesn't delete categories in other shops" do
      product.categorizations.create!(category_id: 14, preferred: true)
      product.categorizations.create!(category_id: 15)

      set_alternative_categories([11])

      product.categorizations.pluck(:category_id).should include(14, 15)
    end
  end
end