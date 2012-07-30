require 'spec_helper'

describe Shop do
  # Associations
  it { should have_many(:categories) }

  # Validations
  # host
  it { should validate_presence_of(:host) }
  it { should ensure_length_of(:host).is_at_most(20).is_at_least(3) }
  it {
    Shop.create(valid_shop_attributes)
    should validate_uniqueness_of(:host)
  }

  # name
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(20) }
  it {
    Shop.create(valid_shop_attributes)
    should validate_uniqueness_of(:name)
  }

  # short_name
  it { should validate_presence_of(:short_name) }
  it { should ensure_length_of(:short_name).is_at_most(20) }
  it {
    Shop.create(valid_shop_attributes)
    should validate_uniqueness_of(:short_name)
  }

  context "with valid attributes" do
    it "should be valid" do
      Shop.new(valid_shop_attributes).should be_valid
    end
  end
end
