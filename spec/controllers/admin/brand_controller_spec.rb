# encoding: UTF-8
require 'spec_helper'

describe Admin::BrandsController do
  let(:brand) {
    mock_model(Brand).as_null_object
  }

  before do
    Admin::BrandsController.stub!(:brand).and_return(brand)
  end

  describe "GET index" do
    it "renders index of all brands" do
      get :index
      response.should be_success
    end
  end

  describe "GET new" do
    it "renders new form" do
      get :new
      response.should be_success
    end
  end

  # CREATE
  describe "POST create" do
    before do
      Brand.stub(:new).and_return(brand)
    end

    # VALID
    describe "with valid parameters" do
      it "should create a new brand" do
        Brand.should_receive(:new).and_return(brand)

        post :create, :brand => {
            "name" => "LG",
            "url"  => "lg",
            "description" => "LG Electronics"
        }
      end

      it "creates brand with exactly the given parameters"

      it "should save brand" do
        brand.should_receive(:save)
        post :create
      end

      it "should redirect to detail" do
        post :create
        response.should redirect_to(:action => "index")
      end

      it "should have a flash notice" do
        post :create
        flash[:notice].should_not be_blank
      end
    end

    # INVALID
    describe "with invalid parameters" do
      before do
        brand.stub(:save).and_return(false)
      end

      def post_with_invalid_params
        post :create, brand: {}
      end

      it "renders form for new brand again" do
        post_with_invalid_params
        response.should render_template("new")
      end

      it "set an error notice" do
        post_with_invalid_params
        flash.now[:notice].should_not be_blank
      end
    end
  end

  describe "DELETE destroy" do
    before do
      Brand.stub!(:find).and_return(brand)
    end

    def delete_brand
      delete :destroy, id: brand.id
    end

    it "should find brand" do
      Brand.should_receive(:find).with(brand.id.to_s).and_return(brand)
      delete_brand
    end

    it "should redirect to brands" do
      delete_brand
      response.should redirect_to(admin_brands_url)
    end

    it "should delete brand from database" do
      brand.should_receive(:destroy)
      delete_brand
    end

    it "displays message with delete brand's name" do
      brand.stub(:name => "LG")
      delete_brand
      flash[:notice].should include(brand.name)
    end

    it "displays error message when brand doesn't exist" do
      Brand.stub(:find).and_raise(ActiveRecord::RecordNotFound)
      delete :destroy, id: brand.id + 1
      flash[:notice].should include("Neznámá značka")
    end
  end
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