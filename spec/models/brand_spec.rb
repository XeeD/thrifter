require 'spec_helper'

describe Brand do

  # Validations
  # name
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(100) }

  # url
  it { should validate_presence_of(:url) }
  it { should ensure_length_of(:url).is_at_most(100) }
  it {
    Brand.create!({
        name: "LG",
        url:  "lg",
        description: "LG Electronics"
    })
    should validate_uniqueness_of(:url)
  }

  # description
  it { should validate_presence_of(:description) }

  context "with valid attributes" do
    it "should be valid" do
      Brand.new(
          name: "LG",
          url:  "lg",
          description: "LG Electronics"
      ).should be_valid
    end
  end
end
