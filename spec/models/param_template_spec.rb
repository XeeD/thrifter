# encoding: UTF-8
require 'spec_helper'

describe ParamTemplate do

  # Associations
  it { should have_many(:categories) }
  it { should have_many(:groups) }

  # Validations
  # name
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(100) }
  it { should validate_uniqueness_of(:name) }

  context "with valid attributes" do
    it "should be valid" do
      ParamTemplate.new(valid_param_template_attributes).should be_valid
    end
  end

  context "with invalid attributes" do
    it "should fail associating with non product_list category" do
      valid = valid_param_template_attributes
      valid[:category_ids] = "1"

      template = ParamTemplate.new(valid)
      template.errors_on(:base).should include("Přiřazené kategorie musí být produktového typu")
    end
  end
end