require 'spec_helper'

module Admin
  describe ProductReplacementsController do
    fixtures(:products)

    let(:product) { ProductDecorator.new(products(:samsung_tv)) }
    let(:replacement) { products(:lg_tv) }

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

        before do
          Product.stub(:find).and_return(product)
          Product.stub_chain(:replacements, :all).and_return([replacement])
        end

        it "calls Product.find" do
          Product.should_receive(:find).and_return(product)
          get_index
        end

        it "shows form" do
          get_index
          response.body.should have_selector("form")
        end

        it "calls product.replacements" do
          product.should_receive(:replacements).and_return([replacement])
          get_index
        end
      end
    end

    describe "POST create" do
      def post_valid_attributes
        post :create, product: {replacement_ids: ["1"]}
      end
    end
  end
end