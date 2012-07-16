require 'spec_helper'

describe Brand do
  it "is valid with valid attributes" do
    Brand.new.should be_valid
  end
end