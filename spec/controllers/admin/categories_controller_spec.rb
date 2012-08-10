# encoding: UTF-8
require 'spec_helper'

module Admin
  describe CategoriesController do
    fixtures :shops

    let(:shop) { shops(:sporilek) }
    let(:category) { mock_model(Category).as_null_object }

    before do
      Shop.stub(find: shop)
    end

    describe "GET choose_shop" do
      render_views

      it "lists all shops" do
        Shop.should_receive(:all).and_return([category])
        get :choose_shop
      end
    end

    describe "GET index" do
      def get_index
        get :index, shop_id: shop.id
      end

      it "renders index action" do
        get_index
        response.should render_template("index")
      end

      context "when rendering views" do
        render_views

        it "calls shop.categories" do
          shop.should_receive(:categories).and_return([category])
          get_index
        end
      end
    end

    describe "GET new" do
      def get_new
        get :new, shop_id: shop.id
      end

      it "renders new action" do
        get_new
        response.should render_template("new")
      end

      context "when rendering views" do
        render_views

        it "calls Category#new" do
          shop.stub_chain(:categories, :new).and_return(category)
          shop.categories.should_receive(:new).with(nil)
          get_new
        end

        it "shows form" do
          get_new
          response.body.should have_selector("form")
        end
      end
    end

    describe "POST create" do
      # Valid attributes
      context "with valid attributes" do
        def post_valid_attributes
          post :create, shop_id: shop.id, category: valid_category_attributes
        end

        before do
          shop.stub_chain(:categories, :new).and_return(category.new_instance)
        end

        it "creates new instance of category with those attributes" do
          shop.categories.should_receive(:new).with(valid_category_attributes).once
          post_valid_attributes
        end

        it "saves the record" do
          category.should_receive(:save).and_return(true)
          post_valid_attributes
        end

        it "redirects to index" do
          post_valid_attributes
          response.should redirect_to(admin_shop_categories_url(shop))
        end

        it "sets the notice message with category's plural name" do
          category.stub(plural_name: valid_category_attributes["plural_name"])
          post_valid_attributes
          flash[:notice].should include(category.plural_name)
        end
      end

      # Invalid attributes
      context "with invalid parameters" do
        def post_invalid_attributes
          post :create, shop_id: shop.id
        end

        before do
          category.stub(:save).and_return(false)
        end

        it "renders the template for new again" do
          post_invalid_attributes
          response.should render_template("new")
        end

        it "sets an error message" do
          post_invalid_attributes
          flash.now[:error].should_not be_blank
        end
      end
    end

    describe "GET edit" do
      def get_edit
        get :edit, shop_id: shop.id, id: category.id
      end

      it "renders template 'edit'" do
        get_edit
        response.should render_template("edit")
      end

      context "when rendering views" do
        render_views

        before do
          shop.stub_chain(:categories, :find).and_return(category)
        end

        it "finds the category" do
          shop.categories.should_receive(:find).with(category.id.to_s).once
          get_edit
        end

        it "renders edit form" do
          get_edit
          response.body.should have_selector("form")
        end
      end
    end

    describe "PUT update" do
      # Valid attributes
      context "with valid attributes" do
        def put_update
          put :update,
              shop_id: shop.id,
              id: category.id,
              category: valid_category_attributes
        end

        before do
          shop.stub_chain(:categories, :find).and_return(category)
        end

        it "finds the category" do
          shop.categories.should_receive(:find).with(category.id.to_s).once.and_return(category)
          put_update
        end

        it "updates attributes" do
          category.should_receive(:update_attributes).with(valid_category_attributes).once
          put_update
        end

        it "redirects to index action" do
          put_update
          response.should redirect_to(admin_shop_categories_url(shop))
        end

        it "sets the notice message with category's plural name" do
          category.stub(plural_name: valid_category_attributes["plural_name"])
          put_update
          flash[:notice].should include(category.plural_name)
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        def put_invalid_update
          put :update,
              shop_id: shop.id,
              id: category.id,
              category: {}
        end

        before do
          shop.stub_chain(:categories, :find).and_return(category)
          category.stub(:update_attributes).and_return(false)
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
          put :update, shop_id: shop.id, id: Category.maximum(:id) + 1
        end

        it "redirects to index" do
          put_with_invalid_id
          response.should redirect_to(admin_shop_categories_url(shop))
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
          delete :destroy, shop_id: shop.id, id: category.id
        end

        before do
          shop.stub_chain(:categories, :find).and_return(category)
        end

        it "finds the category" do
          shop.categories.should_receive(:find).with(category.id.to_s).once
          delete_category
        end

        it "redirects back to index" do
          delete_category
          response.should redirect_to(admin_shop_categories_url(shop))
        end

        it "sets notice message containing category name" do
          category.stub(plural_name: valid_category_attributes["plural_name"])
          delete_category
          flash[:notice].should include(category.plural_name)
        end

        it "destroys the category" do
          category.should_receive(:destroy).once
          delete_category
        end
      end

      context "with non-existing category id" do
        def delete_with_invalid_id
          delete :destroy, shop_id: shop.id, id: Category.maximum(:id) + 1
        end

        it "redirects back to index" do
          delete_with_invalid_id
          response.should redirect_to(admin_shop_categories_url(shop))
        end

        it "sets error message" do
          delete_with_invalid_id
          flash.now[:error].should_not be_blank
        end
      end
    end
  end
end