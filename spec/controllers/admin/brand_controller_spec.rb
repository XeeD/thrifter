require 'spec_helper'

describe Admin::BrandsController do
  it "should show index page" do
    get :index
    response.should be_success
  end

  describe "should create brand" do
    it "should render new form" do
      get :new
      response.should be_success
    end

    describe "with valid params" do
      before(:each) do
        @brand = mock_model(Brand)
      end
    end

    describe "without valid params" do

    end
  end
end