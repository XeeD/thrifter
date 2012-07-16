require 'spec_helper'

describe Admin::BrandsController do
  it "should show index page" do
    get :index
    response.should be_success
  end

  describe "tries create brand" do
    it "should render new form" do
      get :new
      response.should be_success
    end

    describe "with valid params" do
      it "creates a new brand" do
        brand = mock_model(Brand).as_null_object
        Brand.should_receive(:new).with(
            "name" => "LG",
            "url"  => "lg",
            "description" => "LG Electronics"
        ).and_return(brand)
        post :create, :brand => {
            "name" => "LG",
            "url"  => "lg",
            "description" => "LG Electronics"
        }
      end

      it "saves brand" do
        brand = mock_model(Brand)
        Brand.stub(:new).and_return(brand)
        brand.should_receive(:save)
        post :create
      end

      it "should redirect to detail" do
        #post :create
        #response.should redirect_to(:action => "show")
      end

      #let(:brand) do
      #  @brand = mock_model(Brand, :update_attributes => true)
      #  Brand.stub!(:find).with("1").and_return(@brand)
      #end

      #it "should find brand and return object" do
      #  Brand.should_receive(:find).with("1").and_return(@brand)
      #end

      #it "should update brand attributes" do
      #  @brand.should_receive(:update_attributes).and_return(true)
      #  put :update, :id => "1", :brand => {}
      #end

      #it "should redirect to the brand's show page" do
      #  response.should redirect_to(admin_brand_url(@brand))
      #end

      #it "should have a flash notice" do
      #  put :update, :id => "1", :bird => {}
      #  flash[:notice].should_not be_blank
      #end
    end

    describe "without valid params" do

    end
  end
end