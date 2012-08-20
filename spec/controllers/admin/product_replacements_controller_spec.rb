require 'spec_helper'

module Admin
  describe ProductReplacementsController do
    fixtures(:products)

    let(:product) { ProductDecorator.new(products(:samsung_tv)) }
    let(:replacement_lg) { products(:lg_tv) }
    let(:replacement_philips) { product(:philips) }

    before do
      ProductDecorator.stub(find: product)
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

        before do
          product.stub_chain(:replacements).and_return([replacement_lg])
        end

        it "calls ProductDecorator.find" do
          ProductDecorator.should_receive(:find).once.and_return(product)
          get_index
        end

        it "shows form" do
          get_index
          response.body.should have_selector("form")
        end

        it "calls product.replacements" do
          product.should_receive(:replacements).and_return([replacement_lg])
          get_index
        end
      end
    end

    describe "POST create" do
      def post_valid_attributes
        post :create, product: {replacement_ids: [replacement_lg.id, replacement_philips.id]}
      end

      it "updates product replacement ids" do
        post_valid_attributes
      end
    end

    describe "DELETE destroy" do
      before do
        product.stub_chain(:replacements, :find).and_return([replacement_lg, replacement_philips])
      end

      context "with replacement id destroys one record" do
        def delete_replacement
          delete :destroy, id: replacement_lg.id
        end
      end
    end
  end
end