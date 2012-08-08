# encoding: UTF-8
require 'spec_helper'

module Admin
  describe ProductCategorizationsController do
    fixtures :products

    let(:product) { products(:samsung_tv) }

    before do
      Product.stub(find: product)
    end

    describe "GET index" do
      def get_index
        get :index, product_id: product.id
      end

      it "renders 'index' template" do
        get_index
        response.should render_template("index")
      end

      context "when rendering views" do
        render_views

        it "contains the name of product that the categorizations belong to" do
          get_index
          response.body.should have_selector("h2", content: product.name)
        end
      end
    end

    describe "GET edit_alternative" do
      context "when shop_id is specified in params" do
        fixtures :shops
        render_views

        it "renders form" do
          get :edit_alternative, product_id: product.id, shop_id: shops(:sporilek).id
          response.body.should have_selector("form")
        end
      end

      context "when no shop_id is specified in params" do
        def get_edit_alternative_without_shop_id
          get :edit_alternative, product_id: product.id
        end

        it "redirects to index" do
          get_edit_alternative_without_shop_id
          response.should redirect_to(admin_product_categorizations_url(product))
        end

        it "sets error message" do
          get_edit_alternative_without_shop_id
          flash[:error].should be_present
        end
      end
    end

    describe "PUT update_alternative" do
      fixtures :shops

      let(:shop) { shops(:sporilek) }

      def put_update_alternative
        put :update_alternative, shop_id: shop.id, product_id: product.id, product: {category_ids: []}
      end

      it "instantiates new ProductShopCategorizations with Product and Shop instances" do
        Shop.stub(find: shop)
        categorizator = double("categorizator").as_null_object
        ProductShopCategorizations.should_receive(:new).with(product, shop).and_return(categorizator)
        put_update_alternative
      end

      it "redirects back to index" do
        put_update_alternative
        response.should redirect_to(admin_product_categorizations_url(product))
      end
    end

    describe "GET edit_preferred" do
      fixtures :categorizations

      context "with valid preferred categorization" do
        let(:categorization) { categorization = categorizations(:categorization_samsung_tv_sporilek_tvs_3d) }

        def get_edit_preferred_valid
          get :edit_preferred, product_id: product.id, id: categorization.id
        end

        it "finds Categorization by id" do
          product.stub_chain(:categorizations, :find).and_return(categorization)
          product.categorizations.should_receive(:find).with(categorization.id.to_s)
          get_edit_preferred_valid
        end

        context "when rendering views" do
          render_views

          it "displays form" do
            get_edit_preferred_valid
            response.body.should have_selector("form")
          end
        end
      end

      context "with non-preferred categoriaztion" do
        let(:categorization) { categorization = categorizations(:categorization_samsung_tv_sporilek_tvs_led) }

        def get_edit_preferred_invalid
          get :edit_preferred, product_id: product.id, id: categorization.id
        end

        it "redirects back to index" do
          get_edit_preferred_invalid
          response.should redirect_to(admin_product_categorizations_url(product))
        end

        it "sets error message" do
          get_edit_preferred_invalid
          flash[:error].should_not be_blank
        end
      end
    end
  end
end