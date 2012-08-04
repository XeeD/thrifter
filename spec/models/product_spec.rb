# encoding: UTF-8
require 'spec_helper'

describe Product do
  # Associations
  it { should belong_to(:brand) }
  it { should have_many(:categorizations) }
  it { should have_many(:categories).through(:categorizations) }
  it { should have_many(:photos).dependent(:destroy) }
  it { should have_one(:main_photo).conditions(main_photo: true) }
  it { should have_many(:additional_photos).conditions(main_photo: false) }
  it { should have_one(:sample_preferred_categorization) }
  it { should have_one(:sample_preferred_category).through(:sample_preferred_categorization) }
  it { should have_many(:alternative_categorizations) }
  it { should have_many(:alternative_categories).through(:alternative_categorizations) }

  # Validations
  # name
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(171) }

  # model_name
  it { should validate_presence_of(:model_name) }
  it { should ensure_length_of(:model_name).is_at_most(140) }

  # url
  it { should validate_presence_of(:url) }
  it { should ensure_length_of(:url).is_at_most(171) }
  it {
    Product.create(valid_product_attributes)
    should validate_uniqueness_of(:url)
  }

  # short_description
  it { should validate_presence_of(:short_description) }

  # description
  it { should validate_presence_of(:description) }

  # default_price
  it { should validate_presence_of(:default_price) }
  it { should validate_numericality_of(:default_price) }

  # recommended_price
  it { should validate_presence_of(:recommended_price) }
  it { should validate_numericality_of(:recommended_price) }

  # purchase_price
  it { should validate_presence_of(:purchase_price) }
  it { should validate_numericality_of(:purchase_price) }

  # warranty
  it { should validate_presence_of(:warranty) }
  it { should validate_numericality_of(:warranty) }

  # recycling_fee
  it { should validate_presence_of(:recycling_fee) }
  it { should validate_numericality_of(:recycling_fee) }

  # vat_rate
  it { should validate_presence_of(:vat_rate) }
  it { should validate_numericality_of(:vat_rate) }

  # external_id
  it { should validate_presence_of(:external_id) }
  it { should validate_numericality_of(:external_id) }

  # brand
  it { should validate_presence_of(:brand) }

  context "with valid attributes" do
    it "should be valid" do
      Product.new(valid_product_attributes).should be_valid
    end
  end
end