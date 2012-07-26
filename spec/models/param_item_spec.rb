require 'spec_helper'

describe ParamItem do
  # Associations
  it { should belong_to(:param_template) }
  it { should belong_to(:param_group) }

  # Validations
  # name
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(100) }

  # importance
  it { should validate_presence_of(:importance) }
  it { should ensure_length_of(:importance).is_at_most(15) }
  it { should ensure_inclusion_of(:importance).in_array(ParamItem::IMPORTANCE.values) }

  # unit
  it { should ensure_length_of(:unit).is_at_most(30) }

  # choice_type
  it { should validate_presence_of(:choice_type) }
  it { should ensure_length_of(:choice_type).is_at_most(15) }
  it { should ensure_inclusion_of(:choice_type).in_array(ParamItem::CHOICE_TYPES.values) }

  # value_type
  it { should validate_presence_of(:value_type) }
  it { should ensure_length_of(:value_type).is_at_most(10) }
  it { should ensure_inclusion_of(:value_type).in_array(ParamItem::VALUE_TYPES.values) }

  context "with valid attributes" do
    it "should be valid" do
      ParamItem.new(valid_param_item_attributes).should be_valid
    end
  end
end