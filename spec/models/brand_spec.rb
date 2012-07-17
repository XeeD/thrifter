require 'spec_helper'

describe Brand do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:description) }

  context "with valid attributes" do
    it "should be valid" do
      Brand.new(:name => "LG", :url => "lg", :description => "LG Electronics").should be_valid
    end
  end
end
