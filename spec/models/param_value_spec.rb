# encoding: utf-8
require 'spec_helper'

describe ParamValue do

  # Associations
  it { should belong_to(:param_item) }
  it { should have_many(:parametrizations) }
  it { should have_many(:products).through(:parametrizations) }

  # Validations
  # param_item
  it { should validate_presence_of(:param_item) }

  # value
  it { should validate_presence_of(:value) }
  it { should ensure_length_of(:value).is_at_most(40) }

  context "with valid attributes" do
    it "should be valid" do
      ParamValue.new(valid_param_value_attributes).should be_valid
    end
  end
end