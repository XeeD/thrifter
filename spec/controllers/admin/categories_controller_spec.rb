# encoding: UTF-8
require 'spec_helper'

module Admin
  describe CategoriesController do
    let(:category) { mock_model(Category).as_null_object }

    describe "GET index" do
      it "renders index action" do
        get :index
        response.should render_template("index")
      end

      context "when rendering views" do
        render_views

        it "calls Category#all" do
          Category.should_receive(:all).once.and_return([category])
          get :index
        end
      end
    end

    describe "GET new" do
      it "renders new action" do
        get :new
        response.should render_template("new")
      end

      context "when rendering views" do
        render_views

        it "calls Category#new" do
          Category.should_receive(:new).with(nil).once.and_return(category)
          get :new
        end

        it "shows form" do
          get :new
          response.body.should have_selector("form")
        end
      end
    end

    describe "POST create" do
      # Valid attributes
      context "with valid attributes" do
        def post_valid_attributes
          post :create, :category => valid_category_attributes
        end

        before do
          Category.stub(:new).and_return(category.new_instance)
        end

        it "creates new instance of category with those attributes" do
          Category.should_receive(:new).with(valid_category_attributes).once
          post_valid_attributes
        end

        it "saves the record" do
          Category.stub(:new).and_return(category)
          category.should_receive(:save).and_return(true)
          post_valid_attributes
        end

        it "redirects to index" do
          post_valid_attributes
          response.should redirect_to(admin_categories_url)
        end

        it "sets the notice message with category name" do
          category.stub(:short_name).and_return("Pračky")
          post_valid_attributes
          flash[:notice].should include(category.short_name)
        end
      end

      # Invalid attributes
      context "with invalid parameters" do
        before do
          Category.stub(:save).and_return(false)
        end

        it "renders the template for new again" do
          post :create
          response.should render_template("new")
        end

        it "sets an error message" do
          post :create
          flash.now[:error].should_not be_blank
        end
      end
    end

    describe "GET edit" do
      def get_edit
        get :edit, :id => category.id
      end

      it "renders template 'edit'" do
        get_edit
        response.should render_template("edit")
      end

      context "when rendering views" do
        render_views

        before do
          Category.stub(:find).and_return(category)
        end

        it "finds the category" do
          Category.should_receive(:find)#.with(category.id.to_s).once
          get :edit, :id => category.id
        end

        it "renders edit form" do
          get :edit, :id => category.id
          response.body.should have_selector("form")
        end
      end
    end

    describe "PUT update" do
      # Valid attributes
      context "with valid attributes" do
        def put_update
          put :update, :id => category.id, :category => valid_category_attributes
        end

        before do
          Category.stub(:find).and_return(category)
        end

        it "finds the category" do
          Category.should_receive(:find).with(category.id.to_s).once.and_return(category)
          put_update
        end

        it "updates attributes" do
          category.should_receive(:update_attributes).with(valid_category_attributes).once
          put_update
        end

        it "redirects to index action" do
          put_update
          response.should redirect_to(admin_categories_url)
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        def put_invalid_update
          put :update, :id => category.id, :category => {}
        end

        before do
          category.stub(:update_attributes).and_return(false)
          Category.stub(:find).and_return(category)
        end

        it "renders edit action again" do
          put_invalid_update
          response.should render_template("edit")
        end

        it "sets error message" do
          put_invalid_update
          flash.now[:error].should_not be_blank
        end
      end

      context "with non-existing category id" do
        def put_with_invalid_id
          put :update, :id => category.id + 1
        end

        it "redirects to index" do
          put_with_invalid_id
          response.should redirect_to(admin_categories_url)
        end

        it "sets error message" do
          put_with_invalid_id
          flash.now[:error].should_not be_blank
        end
      end
    end

    describe "DELETE destroy" do
      context "with valid category id" do
        def delete_category
          delete :destroy, :id => category.id
        end

        before do
          Category.stub(:find).and_return(category)
        end

        it "finds the category" do
          Category.should_receive(:find).with(category.id.to_s).once
          delete_category
        end

        it "redirects back to index" do
          delete_category
          response.should redirect_to(admin_categories_url)
        end

        it "sets notice message containing category name" do
          category.stub(:short_name).and_return("Pračky")
          delete_category
          flash[:notice].should include(category.short_name)
        end

        it "destroys the category" do
          category.should_receive(:destroy).once
          delete_category
        end
      end

      context "with non-existing category id" do
        def delete_with_invalid_id
          delete :destroy, :id => category.id + 1
        end

        it "redirects back to index" do
          delete_with_invalid_id
          response.should redirect_to(admin_categories_url)
        end

        it "sets error message" do
          delete_with_invalid_id
          flash.now[:error].should_not be_blank
        end
      end
    end
  end
end