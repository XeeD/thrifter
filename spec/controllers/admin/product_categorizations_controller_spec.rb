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

        let(:new_categorization) { mock_model(Categorization).as_new_record }

        def new_categorization_attributes
          {
              category_id: categories(:sporilek_3d_tech_tvs_led).id.to_s,
              preferred: false
          }.stringify_keys
        end

        before do
          product.stub_chain(:categorizations, :new).and_return(new_categorization)
          new_categorization.stub(save: true)
        end

        def post_create
          post :create, product_id: product.id, categorization: new_categorization_attributes
        end

        it "creates new categorization using product.categorizations scope" do
          product.categorizations.should_receive(:new).with(new_categorization_attributes)
          post_create
        end

        it "saves the record" do
          new_categorization.should_receive(:save)
          post_create
        end

        it "redirects back to index" do
          post_create
          response.should redirect_to(admin_product_categorizations_url(product))
        end
      end

      context "with invalid product-category assignment" do
        fixtures :categories

        let(:category) { categories(:sporilek_3d_tech_tvs_led) }

        def post_create_with_invalid_assignment
          post :create, product_id: product.id, categorization: invalid_attributes
        end

        def invalid_attributes
          {
              category_id: category.id,
              preferred: true
          }
        end

        it "doesn't change the DB" do
          expect {
            post_create_with_invalid_assignment
          }.to_not change{Categorization.count}
        end

        it "copies errors on Categorization instace to flash.now[:error]" do
          post_create_with_invalid_assignment
          categorization = product.categorizations.new(invalid_attributes)
          product.stub_chain(:categorizations, :new).and_return(categorization)
          flash.now[:error].should == categorization.errors_on(:base)
        end

        it "renders the 'index' template again" do
          categorization = double("invalid categorization", save: false).as_null_object
          product.stub_chain(:categorizations, :new).and_return(categorization)
          post_create_with_invalid_assignment
          response.should render_template(:index)
        end
      end
    end

    describe "DELETE destroy" do
      def delete_destroy(categorization)
        delete :destroy, product_id: product.id, id: categorization.id
      end

      context "when we can destroy the assignment" do
        let(:categorization) { categorizations(:categorization_samsung_tv_sporilek_tvs_led) }

        before do
          product.stub_chain(:categorizations, :find).and_return(categorization)
        end

        it "destroys categorization" do
          categorization.should_receive(:destroy)
          delete_destroy(categorization)
        end

        it "finds the categorization by fiven id" do
          product.categorizations.should_receive(:find).with(categorization.id.to_s)
          delete_destroy(categorization)
        end

        it "redirects back to index" do
          delete_destroy(categorization)
          response.should redirect_to(admin_product_categorizations_url(product))
        end
      end

      context "when we try destroy assignment that is not currently destroyable" do
        # Preferred category - cannot be deleted, because product has alternative categories in shop
        let(:categorization) { categorizations(:categorization_samsung_tv_sporilek_tvs_3d) }

        it "redirects back to index" do
          delete_destroy(categorization)
          response.should redirect_to(admin_product_categorizations_url(product))
        end

        it "sets the error message to contain message of the exception" do
          exception = ActiveRecord::ActiveRecordError.new("XYZ")
          product.stub_chain(:categorizations, :find, :destroy).and_raise(exception)
          delete_destroy(categorization)
          flash[:error].should == exception.message
        end
      end
    end
  end
end