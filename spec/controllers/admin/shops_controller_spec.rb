# encoding: UTF-8
require 'spec_helper'

module Admin
  describe ShopsController do
    let(:shop) { mock_model(Shop).as_null_object }

    describe "GET index" do
      it "renders 'index' template" do
        get :index
        response.should render_template("index")
      end

      context "when rendering views" do
        render_views

        it "calls Shop#all" do
          Shop.should_receive(:all).with(no_args).once.and_return([shop])
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

        it "calls Shop#new" do
          Shop.should_receive(:new).with(nil).once.and_return(shop)
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
        Shop.stub!(:new).and_return(shop)
      end

      # Valid attributes
      context "with valid attributes" do
        def post_valid_attributes
          post :create, shop: valid_shop_attributes
          shop.stub(:save).and_return(true)
        end

        it "creates new instance of Shop with those attributes" do
          Shop.should_receive(:new).with(valid_shop_attributes).once
          post_valid_attributes
        end

        it "redirects to index" do
          post :create
          response.should redirect_to(admin_shops_url)
        end

        it "saves the record" do
          shop.should_receive(:save).once
          post :create
        end

        it "sets notice message containing shop's name" do
          shop.stub(:name).and_return("LG")
          post :create
          flash[:notice].should include(shop.name)
        end
      end

      # Invalid attributes
      context "with invalid parameters" do
        before do
          shop.stub(:save).and_return(false)
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
        get :edit, :id => shop.id
      end

      it "renders template 'edit'" do
        get_edit
        response.should render_template("edit")
      end

      context "when rendering views" do
        render_views

        before do
          Shop.stub(:find).and_return(shop)
        end

        it "finds the shop" do
          Shop.should_receive(:find).with(shop.id.to_s).once
          get_edit
        end

        it "renders edit form" do
          get :edit, :id => shop.id
          response.body.should have_selector("form")
        end
      end
    end


    describe "POST update" do
      # Valid attributes
      context "with valid parameters" do
        def put_with_valid_attributes
          put :update, id: shop.id, shop: valid_shop_attributes
        end

        before do
          Shop.stub!(:find).and_return(shop)
        end

        it "receives find with shop's id" do
          Shop.should_receive(:find).with(shop.id.to_s).and_return(shop)
          put_with_valid_attributes
        end

        it "updates shop's attributes" do
          shop.should_receive(:update_attributes).with(valid_shop_attributes).once.and_return(true)
          put_with_valid_attributes
        end

        it "redirects to shops" do
          put_with_valid_attributes
          response.should redirect_to(admin_shops_url)
        end

        it "sets notice message containing shops's name" do
          shop.stub(name: "LG")
          put_with_valid_attributes
          flash[:notice].should include(shop.name)
        end
      end

      # Invalid attributes
      context "with invalid parameters" do
        def put_with_invalid_params
          put :update, id: shop.id, shop: {}
        end

        before do
          shop.stub!(:update_attributes).and_return(false)
          Shop.stub!(:find).and_return(shop)
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

      context "with non-existing shop id" do
        def put_with_invalid_id
          put :update, :id => shop.id + 1
        end

        it "redirects to index" do
          put_with_invalid_id
          response.should redirect_to(admin_shops_url)
        end

        it "sets error message" do
          put_with_invalid_id
          flash.now[:error].should_not be_blank
        end
      end
    end

    describe "DELETE destroy" do
      def delete_shop
        delete :destroy, id: shop.id
      end

      context "with valid shop id" do
        before do
          Shop.stub!(:find).and_return(shop)
        end

        it "finds the shop" do
          Shop.should_receive(:find).with(shop.id.to_s).once
          delete_shop
        end

        it "redirects to index" do
          delete_shop
          response.should redirect_to(admin_shops_url)
        end

        it "destroys the shop" do
          shop.should_receive(:destroy).once
          delete_shop
        end

        it "displays message with delete shop's name" do
          shop.stub(name: "LG")
          delete_shop
          flash[:notice].should include(shop.name)
        end
      end

      context "with non-existing shop id" do
        def delete_invalid_shop
          delete :destroy, :id => shop.id + 1
        end

        it "redirects back to index" do
          delete_invalid_shop
          response.should redirect_to(admin_shops_url)
        end

        it "sets error message" do
          delete_invalid_shop
          flash[:error].should_not be_blank
        end
      end
    end
  end
end