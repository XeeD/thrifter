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

  it "allows only one main category per shop" do
    categorization = assign_product_to(:sporilek_3d_tech_tvs_led, :preferred)
    categorization.should_not be_valid
  end

  context "when assigned to multiple shops" do
    it "allows unassignment of main category when it is the only assigned in that shop"
  end

  it "doesn't allow assignment to additional category when it has no preferred category in that shop" do
    categorization = assign_product_to(:s_elektro_tvs_led, false)
    categorization.should_not be_valid
  end

  it "doesn't allow unassignment of main category when it has alternative categories in shop" do
    lambda {
      categorizations(:categorization_samsung_tv_sporilek_tvs_3d).destroy
    }.should raise_error(ActiveRecord::ActiveRecordError)
  end

  it "allows assigning only categories with the same param template for product (even across shops)" do
    categorization = assign_product_to(:sporilek_fridges, false)

    categorization.should_not be_valid
  end

  it "doesn't allow product to be assigned to category when it is already assigned to it's ancestor"

  it "doesn't allow unassignment of main category when it is last main category of product"

  it "doesn't allow assignment of navigational category" do
    categorization = assign_product_to(:s_elektro_tvs, false)
    categorization.should_not be_valid
  end

  it "doesn't allow assignment of navigational category" do
    assign_product_to(:s_elektro_tvs, :preferred).should_not be_valid
  end

  it "allows assignment of product_list category" do
    assign_product_to(:s_elektro_tvs_led, :preferred).should be_valid
  end
end
