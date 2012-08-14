# encoding: UTF-8
require 'spec_helper'

module Admin
  describe ArticlesController do
    fixtures :shops

    let(:shop) { shops(:sporilek) }
    let(:article) { mock_model(Article).as_null_object }

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

        it "calls shop.articles" do
          shop.should_receive(:articles).and_return([article])
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

        it "calls Article#new" do
          shop.stub_chain(:articles, :new).and_return(article)
          shop.articles.should_receive(:new).with(nil)
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
          post :create, shop_id: shop.id, article: valid_article_attributes
        end

        before do
          shop.stub_chain(:articles, :new).and_return(article.new_instance)
        end

        it "creates new instance of article with those attributes" do
          shop.articles.should_receive(:new).with(valid_article_attributes).once
          post_valid_attributes
        end

        it "saves the record" do
          article.should_receive(:save).and_return(true)
          post_valid_attributes
        end

        it "redirects to index" do
          post_valid_attributes
          response.should redirect_to(admin_shop_articles_url(shop))
        end

        it "sets the notice message with article name" do
          article.stub(name: valid_article_attributes["name"])
          post_valid_attributes
          flash[:notice].should_not be_blank
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        def post_invalid_attributes
          post :create, shop_id: shop.id, article: {}
        end

        before do
          article.stub(:save).and_return(false)
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
        get :edit, shop_id: shop.id, id: article.id
      end

      it "renders template 'edit'" do
        get_edit
        response.should render_template("edit")
      end

      context "when rendering views" do
        render_views

        before do
          shop.stub_chain(:articles, :find).and_return(article)
        end

        it "finds the article" do
          shop.articles.should_receive(:find).once.and_return(article)
          get_edit
        end

        it "renders form" do
          get_edit
          response.body.should have_selector("form")
        end
      end
    end

    describe "PUT update" do
      # Valid attributes
      context "with valid attributes" do
        def put_update
          put :update, shop_id: shop.id, id: article.id, article: valid_article_attributes
        end

        before do
          shop.stub_chain(:articles, :find).and_return(article)
        end

        it "finds the article" do
          shop.articles.should_receive(:find).and_return(article)
          put_update
        end

        it "updates attributes" do
          article.should_receive(:update_attributes).with(valid_article_attributes).once
          put_update
        end

        it "redirects to index action" do
          put_update
          response.should redirect_to(admin_shop_articles_url(shop))
        end

        it "sets the notice message with article's name" do
          article.stub(name: valid_article_attributes["name"])
          put_update
          flash[:notice].should include(article.name)
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        def put_invalid_update
          put :update, shop_id: shop.id, id: article.id, article: {}
        end

        before do
          shop.stub_chain(:articles, :find).and_return(article)
          article.stub(:update_attributes).and_return(false)
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
          put :update, shop_id: shop.id, id: article.id + 1
        end

        it "redirects to index" do
          put_with_invalid_id
          response.should redirect_to(admin_shop_articles_url(shop))
        end

        it "sets error message" do
          put_with_invalid_id
          flash.now[:error].should_not be_blank
        end
      end
    end

    describe "DELETE destroy" do
      context "with valid article id" do
        def delete_article
          delete :destroy, shop_id: shop.id, id: article.id
        end

        before do
          shop.stub_chain(:articles, :find).and_return(article)
        end

        it "finds the article" do
          shop.articles.should_receive(:find).once
          delete_article
        end

        it "redirects back to index" do
          delete_article
          response.should redirect_to(admin_shop_articles_url(shop))
        end

        it "sets notice message containing article's name" do
          article.stub(name: valid_article_attributes["name"])
          delete_article
          flash[:notice].should include(article.name)
        end

        it "destroys the article" do
          article.should_receive(:destroy).and_return(true)
          delete_article
        end
      end

      context "with non-existing article id" do
        def delete_with_invalid_id
          delete :destroy, shop_id: shop.id, id: article.id + 1
        end

        it "redirects back to index" do
          delete_with_invalid_id
          response.should redirect_to(admin_shop_articles_path(shop))
        end

        it "sets error message" do
          delete_with_invalid_id
          flash.now[:error].should_not be_blank
        end
      end
    end
  end
end
