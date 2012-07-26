require 'spec_helper'

describe ParamGroup do
  # Associations
  it { should belong_to(:param_template) }
  it { should have_many(:param_items) }

  # Validations
  # name
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(40) }
  it { should validate_uniqueness_of(:name).scoped_to(:param_template_id) }

  context "with valid attributes" do
    it "should be valid" do
      ParamGroup.new(valid_param_group_attributes).should be_valid
    end
  end
end
