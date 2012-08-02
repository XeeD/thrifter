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

    describe "POST create" do
      context "with valid product-category assignment" do
        fixtures :categories

        def new_categorization_attributes
          {
              category_id: categories(:sporilek_3d_tech_tvs_led).id.to_s,
              preferred: false
          }.stringify_keys
        end

        def post_create
          post :create, product_id: product.id, categorization: new_categorization_attributes
        end

        it "creates new categorization using product.categorizations scope" do
          new_categorization = mock_model(Categorization).as_new_record
          product.stub_chain(:categorizations, :new).and_return(new_categorization)
          product.categorizations.should_receive(:new).with(new_categorization_attributes)
          post_create
        end

        it "redirects back to index" do
          post_create
          response.should redirect_to(admin_product_categorizations_url(product))
        end
      end
    end

    describe "DELETE destroy" do
    end
  end
end