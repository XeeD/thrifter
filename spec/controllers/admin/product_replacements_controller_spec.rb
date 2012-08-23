require 'spec_helper'

module Admin
  describe ProductReplacementsController do
    fixtures(:products)

    let(:product) { ProductDecorator.new(products(:philips_tv)) }
    let(:replacement_lg) { products(:lg_tv) }
    let(:replacement_samsung) { products(:samsung_tv) }

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

        it "shows form" do
          get_index
          response.body.should have_selector("form")
        end
      end
    end

    describe "POST create" do
      context "with several valid replacement ids" do
        def post_create
          post :create, product_id: product.id, product: {replacement_ids: [replacement_lg.id, replacement_samsung.id]}
        end

        it "updates product replacements" do
          expect {
            post_create
          }.to change{product.replacements.size}.by(2)
        end

        it "redirects back to product replacements" do
          post_create
          response.should redirect_to(admin_product_replacements_url(product))
        end

        it "sets notice message" do
          post_create
          flash[:notice].should_not be_blank
        end
      end
    end

    describe "DELETE destroy" do
      context "with one valid replacement id" do
        def delete_replacement
          delete :destroy, product_id: product.id, id: replacement_lg.id
        end

        it "removes one replacement" do
          expect {
            delete_replacement
          }.to change{product.replacements.size}.by(-1)
        end

        it "redirects back to product replacements" do
          delete_replacement
          response.should redirect_to(admin_product_replacements_url(product))
        end

        it "sets notice message" do
          delete_replacement
          flash[:notice].should_not be_blank
        end
      end

      context "with several valid replacement ids" do
        def delete_replacements
          delete :destroy, product_id: product.id, id: "all"
        end

        it "removes all replacements" do
          expect {
            delete_replacements
          }.to change{product.replacements.size}.to(0)
        end

        it "redirects back to product replacements" do
          delete_replacements
          response.should redirect_to(admin_product_replacements_url(product))
        end

        it "sets notice message" do
          delete_replacements
          flash[:notice].should_not be_blank
        end
      end
    end
  end
end