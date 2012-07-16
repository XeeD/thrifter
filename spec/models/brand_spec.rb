require 'spec_helper'

describe Brand do
  let(:brand) do
    stub_model Brand, :id => 1
  end

  # it uses default Brand model to validate without any attributes
  it { should_not be_valid }

  it "should not be valid without name" do
    brand.should have(1).error_on(:name)
  end

  it "should not be valid without url" do
    brand.should have(1).error_on(:url)
  end

  it "should not be valid without description" do
    brand.should have(1).error_on(:description)
  end

  it "should be valid" do
    Brand.new(:name => "LG", :url => "lg", :description => "LG Electronics").should be_valid
  end
end