# encoding: UTF-8
require 'spec_helper'

describe ParamTemplate do

  # Associations
  it { should have_many(:categories) }
  it { should have_many(:groups) }
  it { should have_many(:param_items) }
  it { should have_many(:products) }

  # Validations
  # name
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(100) }
  it {
    ParamTemplate.create(valid_param_template_attributes)
    should validate_uniqueness_of(:name)
  }

  context "with valid attributes" do
    it "should be valid" do
      ParamTemplate.new(valid_param_template_attributes).should be_valid
    end
  end

  context "with invalid attributes" do
    it "should fail associating with category that is not product list" do
      valid = valid_param_template_attributes
      non_product_category = Category.where("category_type != ?", "product_list").first
      valid[:category_ids] = non_product_category.id

      template = ParamTemplate.new(valid)

      template.errors_on(:base).should include_match(Regexp.escape(non_product_category.plural_name))
    end
  end
end