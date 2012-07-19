# encoding: UTF-8
require 'spec_helper'

module Admin
  describe BrandsController do
    let(:brand) { mock_model(Brand).as_null_object }

    describe "GET index" do
      it "renders 'index' template" do
        get :index
        response.should render_template("index")
      end

      context "when rendering views" do
        render_views

        it "calls Brand#all" do
          Brand.should_receive(:all).with(no_args).once.and_return([brand])
          get :index
        end
      end
    end

    describe "GET new" do
      it "renders 'new' template" do
        get :new
        response.should render_template("new")
      end

      context "when rendering views" do
        render_views

        it "calls Brand#new" do
          Brand.should_receive(:new).with(nil).once.and_return(brand)
          get :new
        end

        it "shows form" do
          get :new
          response.body.should have_selector("form")
        end
      end
    end

    describe "POST create" do
      before do
        Brand.stub!(:new).and_return(brand)
      end

      # Valid attributes
      context "with valid attributes" do
        def post_valid_attributes
          post :create, brand: valid_brand_attributes
          brand.stub(:save).and_return(true)
        end

        it "creates new instance of Brand with those attributes" do
          Brand.should_receive(:new).with(valid_brand_attributes).once
          post_valid_attributes
        end

        it "redirects to index" do
          post :create
          response.should redirect_to(admin_brands_url)
        end

        it "saves the record" do
          brand.should_receive(:save).once
          post :create
        end

        it "sets notice message containing brand's name" do
          brand.stub(:name).and_return("LG")
          post :create
          flash[:notice].should include(brand.name)
        end
      end

      # Invalid attributes
      context "with invalid parameters" do
        before do
          brand.stub(:save).and_return(false)
        end

        it "renders the template 'new' again" do
          post :create
          response.should render_template("new")
        end

        it "sets error message for current request" do
          post :create
          flash.now[:error].should_not be_blank
        end
      end
    end

    describe "GET edit" do
      def get_edit
        get :edit, :id => brand.id
      end

      it "renders template 'edit'" do
        get_edit
        response.should render_template("edit")
      end

      context "when rendering views" do
        render_views

        before do
          Brand.stub(:find).and_return(brand)
        end

        it "finds the brand" do
          Brand.should_receive(:find).with(brand.id.to_s).once
          get_edit
        end

        it "renders edit form" do
          get :edit, :id => brand.id
          response.body.should have_selector("form")
        end
      end
    end


    describe "POST update" do
      # Valid attributes
      context "with valid parameters" do
        def put_with_valid_attributes
          put :update, id: brand.id, brand: valid_brand_attributes
        end

        before do
          Brand.stub!(:find).and_return(brand)
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

      # Invalid attributes
      context "with invalid parameters" do
        def put_with_invalid_params
          put :update, id: brand.id, brand: {}
        end

        before do
          brand.stub!(:update_attributes).and_return(false)
          Brand.stub!(:find).and_return(brand)
        end

        it "renders form for editing again" do
          put_with_invalid_params
          response.should render_template("edit")
        end

        it "sets error message for current request" do
          put_with_invalid_params
          flash.now[:error].should_not be_blank
        end
      end

      context "with non-existing brand id" do
        def put_with_invalid_id
          put :update, :id => brand.id + 1
        end

        it "redirects to index" do
          put_with_invalid_id
          response.should redirect_to(admin_brands_url)
        end

        it "sets error message" do
          put_with_invalid_id
          flash.now[:error].should_not be_blank
        end
      end
    end

    describe "DELETE destroy" do
      def delete_brand
        delete :destroy, id: brand.id
      end

      context "with valid brand id" do
        before do
          Brand.stub!(:find).and_return(brand)
        end

        it "finds the brand" do
          Brand.should_receive(:find).with(brand.id.to_s).once
          delete_brand
        end

        it "redirects to index" do
          delete_brand
          response.should redirect_to(admin_brands_url)
        end

        it "destroys the brand" do
          brand.should_receive(:destroy).once
          delete_brand
        end

        it "displays message with delete brand's name" do
          brand.stub(name: "LG")
          delete_brand
          flash[:notice].should include(brand.name)
        end
      end

      context "with non-existing brand id" do
        def delete_invalid_brand
          delete :destroy, :id => brand.id + 1
        end

        it "redirects back to index" do
          delete_invalid_brand
          response.should redirect_to(admin_brands_url)
        end

        it "sets error message" do
          delete_invalid_brand
          flash[:error].should_not be_blank
        end
      end
    end
  end
end