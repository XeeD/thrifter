# encoding: UTF-8
require 'spec_helper'

describe ParamTemplate do

  # Associations
  it { should have_many(:categories) }
  it { should have_many(:groups) }
  it { should have_many(:param_items) }

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
      valid[:category_ids] = Category.where("category_type != ?", "product_list").first.id

      template = ParamTemplate.new(valid)
      template.errors_on(:base).should include("Přiřazené kategorie musí být produktového typu")
    end
  end
end