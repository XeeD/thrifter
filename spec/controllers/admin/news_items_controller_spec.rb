# encoding: UTF-8
require 'spec_helper'

module Admin
  describe NewsItemsController do
    fixtures :shops

    let(:shop) { shops(:sporilek) }
    let(:news_item) { mock_model(NewsItem).as_null_object }

    before do
      Shop.stub(find: shop)
    end

    describe "GET choose_shop" do
      render_views

      it "lists all shops" do
        Shop.should_receive(:all).and_return([shop])
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

        it "calls shop.news_items" do
          pending
          shop.should_receive(:news_items).and_return([news_item])
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

        it "calls News#new" do
          shop.stub_chain(:news_items, :new).and_return(news_item)
          shop.news_items.should_receive(:new).with(nil)
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
          post :create, shop_id: shop.id, news_item: valid_news_item_attributes
        end

        before do
          shop.stub_chain(:news_items, :new).and_return(news_item.new_instance)
        end

        it "creates new instance of news_item with those attributes" do
          shop.news_items.should_receive(:new).once
          post_valid_attributes
        end

        it "saves the record" do
          news_item.should_receive(:save).and_return(true)
          post_valid_attributes
        end

        it "redirects to index" do
          post_valid_attributes
          response.should redirect_to(admin_shop_news_items_url(shop))
        end

        it "sets the notice message with news_item title" do
          news_item.stub(title: valid_news_item_attributes["title"])
          post_valid_attributes
          flash[:notice].should include(news_item.title)
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        def post_invalid_attributes
          post :create, shop_id: shop.id
        end

        before do
          news_item.stub(:save).and_return(false)
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
        get :edit, shop_id: shop.id, id: news_item.id
      end

      it "renders template 'edit'" do
        get_edit
        response.should render_template("edit")
      end

      context "when rendering views" do
        render_views

        before do
          shop.stub_chain(:news_items, :find).and_return(news_item)
        end

        it "finds the news_items" do
          shop.news_items.should_receive(:find).with(news_item.id.to_s).once
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
          put :update, shop_id: shop.id, id: news_item.id, news_item: valid_news_item_attributes
        end

        before do
          shop.stub_chain(:news_items, :find).and_return(news_item)
        end

        it "finds the news_item" do
          shop.news_items.should_receive(:find).with(news_item.id.to_s).once.and_return(news_item)
          put_update
        end

        it "updates attributes" do
          news_item.should_receive(:update_attributes).with(valid_news_item_attributes).once
          put_update
        end

        it "redirects to index action" do
          put_update
          response.should redirect_to(admin_shop_news_items_url(shop))
        end

        it "sets the notice message with news title" do
          news_item.stub(title: valid_news_item_attributes["title"])
          put_update
          flash[:notice].should include(news_item.title)
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        def put_invalid_update
          put :update, shop_id: shop.id, id: news_item.id, news_item: {}
        end

        before do
          shop.stub_chain(:news_items, :find).and_return(news_item)
          news_item.stub(:update_attributes).and_return(false)
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

      context "with non-existing news_item id" do
        def put_with_invalid_id
          put :update, shop_id: shop.id, id: news_item.id + 1
        end

        it "redirects to index" do
          put_with_invalid_id
          response.should redirect_to(admin_shop_news_items_url(shop))
        end

        it "sets error message" do
          put_with_invalid_id
          flash.now[:error].should_not be_blank
        end
      end
    end

    describe "DELETE destroy" do
      context "with valid news item id" do
        def delete_news_item
          delete :destroy, shop_id: shop.id, id: news_item.id
        end

        before do
          shop.stub_chain(:news_items, :find).and_return(news_item)
        end

        it "finds the news item" do
          shop.news_items.should_receive(:find).with(news_item.id.to_s).once
          delete_news_item
        end

        it "redirects back to index" do
          delete_news_item
          response.should redirect_to(admin_shop_news_items_url(shop))
        end

        it "sets notice message containing news_item's name" do
          news_item.stub(title: valid_news_item_attributes["title"])
          delete_news_item
          flash[:notice].should include(news_item.title)
        end

        it "destroys the news_item" do
          news_item.should_receive(:destroy).once
          delete_news_item
        end
      end

      context "with non-existing news_item id" do
        def delete_with_invalid_id
          delete :destroy, shop_id: shop.id, id: news_item.id + 1
        end

        it "redirects back to index" do
          delete_with_invalid_id
          response.should redirect_to(admin_shop_news_items_url(shop))
        end

        it "sets error message" do
          delete_with_invalid_id
          flash.now[:error].should_not be_blank
        end
      end
    end
  end
end