require 'spec_helper'

describe Brand do
  setup do
    @brand = Brand.new
  end

  it "should not be valid without name" do
    @brand.new.should_not_be_valid
  end

  it "should not be valid without url" do

  end

  it "should not be valid without description" do

  end

  it "should be valid with all required attributes" do

  end
end