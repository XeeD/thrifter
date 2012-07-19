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

  describe "GET edit" do
    it "renders editation form" do
      get :edit, id: brand.id
      response.should be_success
    end
  end

  # CREATE
  describe "POST create" do
    before do
      Brand.stub!(:new).and_return(brand)
    end

    # VALID
    context "with valid parameters" do
      def valid_brand_attributes
        {
            "name" => "LG",
            "url" => "lg",
            "description" => "LG Electronics"
        }
      end

      it "creates brand with exactly the given parameters" do
        Brand.should_receive(:new).with(valid_brand_attributes).once
        post :create, brand: valid_brand_attributes
      end

      it "should save brand" do
        brand.should_receive(:save).and_return(true)
        post :create
      end

      it "should redirect to index" do
        post :create
        response.should redirect_to(action: "index")
      end

      it "should have a flash notice" do
        post :create
        flash[:notice].should_not be_blank
      end
    end

    # INVALID
    context "with invalid parameters" do
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
        flash.now[:error].should_not be_blank
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
      brand.stub(name: "LG")
      delete_brand
      flash[:notice].should include(brand.name)
    end

    it "displays error message when brand doesn't exist" do
      Brand.stub(:find).and_raise(ActiveRecord::RecordNotFound)
      delete :destroy, id: brand.id + 1
      flash[:error].should_not be_blank
    end
  end

  # EDIT
  describe "POST update" do

    # VALID
    context "with valid parameters" do
      def valid_brand_attributes
        {
            "name" => "Samsung",
            "url" => "samsung",
            "description" => "Samsung"
        }
      end

      before do
        Brand.stub!(:find).and_return(brand)
      end

      def put_with_valid_attributes
        put :update, id: brand.id, brand: valid_brand_attributes
      end

      it "receives find with brand's id" do
        Brand.should_receive(:find).with(brand.id.to_s).and_return(brand)
        put_with_valid_attributes
      end

      it "updates brand's attributes" do
        brand.should_receive(:update_attributes).with(valid_brand_attributes).once.and_return(true)
        put_with_valid_attributes
      end

      it "should redirect to brands" do
        put_with_valid_attributes
        response.should redirect_to(admin_brands_url)
      end

      it "should have a flash notice" do
        put_with_valid_attributes
        flash[:notice].should_not be_blank
      end
    end

    # INVALID
    context "with invalid parameters" do
      before do
        brand.stub!(:update_attributes).and_return(false)
        Brand.stub!(:find).and_return(brand)
      end

      def put_with_invalid_params
        put :update, id: brand.id, brand: {}
      end

      it "receives find with brand's id" do
        Brand.should_receive(:find).with(brand.id.to_s).and_return(brand)
        put_with_invalid_params
      end

      it "doesn't update brand's attributes" do
        brand.should_receive(:update_attributes).and_return(false)
        put_with_invalid_params
      end

      it "renders form for editing again" do
        put_with_invalid_params
        response.should render_template("edit")
      end

      it "set an error notice" do
        put_with_invalid_params
        flash[:error].should_not be_blank
      end
    end

    context "with non-existing bramd id" do
      def post_with_invalid_id
        post :update, :id => brand.id + 1
      end

      it "redirects to index" do
        post_with_invalid_id
        response.should redirect_to(admin_brands_url)
      end

      it "sets error message" do
        post_with_invalid_id
        flash.now[:error].should_not be_blank
      end
    end
  end
end