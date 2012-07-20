# encoding: UTF-8
require 'spec_helper'

describe Category do

  let(:category) { mock_model(Category).as_null_object }
  let(:subcategory) { mock_model(Category).as_null_object }

  # Associations
  it { should have_many(:categorizations) }
  it { should have_many(:products).through(:categorizations) }
  it { should belong_to(:parent_category) }
  it { should_not allow_value(category.id).for(:parent_id).with_message('nemůže být nadřazena sama sobě') }

  # Validations
  # short_name
  it { should validate_presence_of(:short_name) }
  it { should ensure_length_of(:short_name).is_at_most(80) }

  # url
  it { should validate_presence_of(:url) }
  it { should ensure_length_of(:url).is_at_most(120) }

  # plural_name
  it { should validate_presence_of(:plural_name) }
  it { should ensure_length_of(:plural_name).is_at_most(120) }

  # singular_name
  it { should ensure_length_of(:singular_name).is_at_most(120) }

  # category_type
  it { should ensure_inclusion_of(:category_type).in_array(Category::CATEGORY_TYPES.values) }

  describe "integrity constraints" do
    context "for navigational category type" do
      before do
        subcategory.stub(category_type: "navigational")
        category.stub(:parent_category).and_return(subcategory)
      end

      it "doesn't allow navigational category_type for subcategory" do
        category.should_not allow_value("navigational").for(:category_type)
      end

      it "allows product_list category_type for subcategory" do
        category.should allow_value("product_list").for(:category_type)
      end

      it "allows additional category_type for subcategory" do
        category.should allow_value("additional").for(:category_type)
      end
    end

    context "for product_list category type" do
      before do
        subcategory.stub(:category_type).and_return("product_list")
        category.stub(:parent_category).and_return(subcategory)
      end

      it "doesn't allow navigational category_type for subcategory" do
        category.should_not allow_value("navigational").for(:category_type)
      end

      it "doesn't allow product_list category_type for subcategory" do
        category.should_not allow_value("category_list").for(:category_type)
      end

      it "allows additional category_type for subcategory" do
        category.should allow_value("additional").for(:category_type)
      end
    end

    context "for additional category type" do
      before do
        subcategory.stub(:category_type).and_return("additional")
        category.stub(:parent_category).and_return(subcategory)
      end

      it "doesn't allow navigational category_type for subcategory" do
        category.should_not allow_value("navigational").for(:category_type)
      end

      it "doesn't allow product_list category_type for subcategory" do
        category.should_not allow_value("product_list").for(:category_type)
      end

      it "allows additional category_type for subcategory" do
        category.should allow_value("additional").for(:category_type)
      end
    end
  end

  context "with valid attributes" do
    it "should be valid" do
      Category.new(valid_category_attributes).should be_valid
    end
  end
end