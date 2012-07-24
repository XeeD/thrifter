# encoding: UTF-8
require 'spec_helper'

describe ParamTemplate do

  # Associations
  it { should belong_to(:category) }
  it { should have_many(:param_groups) }

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
end