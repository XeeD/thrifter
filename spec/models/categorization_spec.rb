# encoding: UTF-8
require 'spec_helper'

describe Categorization do
  # Associations
  it { should belong_to(:category) }
  it { should belong_to(:product) }

  # Category tree:
  #
  # Spořílek
  #  |
  #  |-- Televize (N) -- sporilek_tvs
  #  |    |
  #  |    |-- LED (P): template TV -- sporilek_tvs_led
  #  |    |
  #  |    \-- 3D (P): template TV -- sporilek_tvs_3d
  #  |
  #  \-- 3D technologie (N) -- sporilek_3d_tech
  #       |
  #       \-- Televizory (P): template TV -- sporilek_3d_tech_tvs
  #             |
  #             |-- LED LCD (D) -- sporilek_3d_tech_tvs_led
  #             |
  #             \-- Plazmové (D) -- sporilek_3d_tech_tvs_plasma
  #
  # Smart Elektro
  #  |
  #  \-- Televize (N) -- sporilek_tvs
  #       |
  #       |-- LED (P): template TV -- s_elektro_tvs_led
  #       |
  #       \-- 3D (P): template TV -- s_elektro_tvs_3d
  #
  #
  # Samsung UE55ES8000 - categorization:
  #     Televize -> LED
  #     Televize -> 3D (preferred)

  fixtures :categories
  fixtures :categorizations
  fixtures :products

  let(:product) { products(:samsung_tv) }

  def assign_product_to(category, preferred)
    unless category.kind_of?(Category)
      category = categories(category)
    end

    Categorization.new(
        product_id: product.id,
        category_id: category.id,
        preferred: !!preferred)
  end

  context "allows" do
    it "only one main category per shop" do
      categorization = assign_product_to(:sporilek_3d_tech_tvs_led, :preferred)
      categorization.should_not be_valid
    end

    it "assignment of product_list category" do
      assign_product_to(:s_elektro_tvs_led, :preferred).should be_valid
    end

    it "assigning only categories with the same param template for product (even across shops)" do
      categorization = assign_product_to(:sporilek_fridges, false)

      categorization.should_not be_valid
    end

    it "assignment of alternative category when it has preferred category in that shop" do
      assign_product_to(:s_elektro_tvs_led, true).save!
      categorization = assign_product_to(:s_elektro_tvs_3d, false)
      categorization.should be_valid
    end

    it "unassignment of preferred category when it has preferred category in another shop" do
      categorization = assign_product_to(:s_elektro_tvs_led, true)
      categorization.save!
      categorization.destroy
    end
  end

  context "doesn't allow" do
    it "assignment of navigational category" do
      assign_product_to(:s_elektro_tvs, false).should_not be_valid
    end

    it "assignment to alternative category when it has no preferred category in that shop" do
      categorization = assign_product_to(:s_elektro_tvs_led, false)
      categorization.should_not be_valid
    end

    it "unassignment of main category when it has alternative categories in shop" do
      lambda {
        categorizations(:categorization_samsung_tv_sporilek_tvs_3d).destroy
      }.should raise_error(ActiveRecord::ActiveRecordError)
    end

    it "product to be assigned to category when it is already assigned to it's ancestor" do
      assign_product_to(:sporilek_3d_tech_tvs, false).save!
      assign_product_to(:sporilek_3d_tech_tvs_led, false).should_not be_valid
    end

    it "unassignment of main category when it is last main category of product" do
      product.categorizations.where(preferred: false).delete_all
      lambda {
        product.categorizations.first.destroy
      }.should raise_error(ActiveRecord::ActiveRecordError)
    end
  end

  context "when assigned to multiple shops" do
    it "allows unassignment of main category when it is the only assigned in that shop" do
      categorization = assign_product_to(:s_elektro_tvs_led, true).save!
      expect {
        categorization.destroy
      }.to_not raise_error(ActiveRecord::ActiveRecordError)
    end
  end
end
