# encoding: UTF-8
require 'spec_helper'

describe Categorization do
  # Associations
  it { should belong_to(:category) }
  it { should belong_to(:product) }

  # Kategorie:
  #
  #  |-- Televize (N) -- sporilek_tvs
  #  |    |
  #  |    |-- LED (P): šablona TV -- sporilek_tvs_led
  #  |    |
  #  |    \-- 3D (P): šablona TV -- sporilek_tvs_3d
  #  |
  #  \-- 3D technologie (N) -- sporilek_3d_tech
  #       |
  #       \-- Televizory (P): šablona TV -- sporilek_3d_tech_tvs
  #             |
  #             |-- LED LCD (D) -- sporilek_3d_tech_tvs_led
  #             |
  #             \-- Plazmové (D) -- sporilek_3d_tech_tvs_plasma
  #
  #
  # Samsung UE55ES8000 - zařazení:
  #     Televize -> LED
  #     Televize -> 3D

  fixtures :categories
  fixtures :products

  it "allows only one main category per shop"

  context "when assigned to multiple shops" do
    it "allows unassigment of main category when it is the only assigment in that shop"
  end

  it "doesn't allow unassigment of main category when it has alternative categories in shop"

  it "allows assigning only categories with the same param template for product (even across shops)"

  it "doesn't allow product to be assigned to category when it is already assigned to it's ancestor"

  it "doesn't allow deletion of main category when it is last main category of product"
end
