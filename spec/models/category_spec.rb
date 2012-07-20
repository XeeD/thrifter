# encoding: UTF-8
require 'spec_helper'

describe Category do

  # Associations
  # products
  it { should have_and_belong_to_many(:products) }

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

  context "with valid attributes" do
    it "should be valid" do
      Category.new(valid_category_attributes).should be_valid
    end
  end
end