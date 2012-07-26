require 'spec_helper'

describe ParamItem do
  # Associations
  it { should belong_to(:param_template) }
  it { should belong_to(:param_group) }

  # Validations
  # name
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(100) }
  it { should validate_uniqueness_of(:name).scoped_to(:param_template_id) }

  # importance
  # unit
  # choice_type
  # value_type

  context "with valid attributes" do
    it "should be valid" do
      Param.new(valid_param_attributes).should be_valid
    end
  end
end