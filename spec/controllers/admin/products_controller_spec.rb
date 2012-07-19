require 'spec_helper'

module Admin
  describe ProductsController do
    let(:product) { mock_model(Product).as_null_object }

    describe "GET index" do
      it "renders index action" do
        get :index
        response.should be_success
      end

      context "when rendering views" do
        render_views

        it "calls Product#all" do
          Product.should_receive(:all).with(nil).once.and_return([product])
          get :index
        end
      end
    end

    describe "GET new" do
      it "renders new action" do
        get :new
        response.should be_success
      end

      context "when rendering views" do
        render_views

        it "calls Product#new" do
          Product.should_receive(:new).with(nil).once.and_return(product)
          get :new
        end
      end
    end

    describe "POST create" do
      # Valid attributes
      context "with valid attributes" do
        def post_valid_attributes
          post :create, :product => valid_product_attributes
        end

        before do
          Product.stub(:new).and_return(product.new_instance)
        end

        it "creates new instance of product with those attributes" do
          Product.should_receive(:new).with(valid_product_attributes).once
          post_valid_attributes
        end

        it "redirects to index" do
          post_valid_attributes
          response.should redirect_to(admin_products_url)
        end

        it "saves the record" do
          Product.stub(:new).and_return(product)
          product.should_receive(:save).and_return(true)
          post_valid_attributes
        end

        it "sets the notice message with product name" do
          product.stub(:name).and_return("LG GB3133TIJW")
          post_valid_attributes
          flash[:notice].should include(product.name)
        end
      end

      # Invalid
      context "with invalid attributes" do
        before do
          Product.stub(:save).and_return(false)
        end

        it "renders the template for new again" do
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
      render_views

      it "renders edit form" do
        Product.stub(:find).and_return(product)
        get :edit, :id => product.id
        response.body.should have_selector("form")
      end
    end

    describe "PUT update" do
      context "with valid attributes" do
        def put_update
          put :update, :id => product.id, :product => valid_product_attributes
        end

        before do
          Product.stub(:find).and_return(product)
        end

        it "finds the product" do
          Product.should_receive(:find).with(product.id.to_s).once.and_return(product)
          put_update
        end

        it "updates attributes" do
          product.should_receive(:update_attributes).with(valid_product_attributes).once
          put_update
        end

        it "redirects to index" do
          put_update
          response.should redirect_to(admin_products_url)
        end
      end

      context "with invalid attributes" do
        def put_invalid_update
          put :update, :id => product.id, :product => {}
        end

        before do
          product.stub(:update_attributes).and_return(false)
          Product.stub(:find).and_return(product)
        end

        it "renders edit action again" do
          put_invalid_update
          response.should render_template("edit")
        end

        it "sets error message for current request" do
          put_invalid_update
          flash.now[:error].should_not be_blank
        end
      end

      context "with non-existing product id" do
        def put_with_invalid_id
          put :update, :id => product.id + 1
        end

        it "redirects to index" do
          put_with_invalid_id
          response.should redirect_to(admin_products_url)
        end

        it "sets error message" do
          put_with_invalid_id
          flash.now[:error].should_not be_blank
        end
      end
    end

    describe "DELETE destroy" do
      context "with valid product id" do
        def delete_product
          delete :destroy, :id => product.id
        end

        before do
          Product.stub(:find).and_return(product)
        end

        it "finds the product" do
          Product.should_receive(:find).with(product.id.to_s).once
          delete_product
        end

        it "redirects back to index" do
          delete_product
          response.should redirect_to(admin_products_url)
        end

        it "destroys the product" do
          product.should_receive(:destroy).once
          delete_product
        end
      end

      context "with non-existing product id" do
        def delete_invalid_product
          delete :destroy, :id => product.id + 1
        end

        it "redirects back to index" do
          delete_invalid_product
          response.should redirect_to(admin_products_url)
        end

        it "sets error message" do
          delete_invalid_product
          flash[:error].should_not be_blank
        end
      end
    end
  end
end