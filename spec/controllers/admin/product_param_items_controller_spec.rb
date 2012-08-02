# encoding: UTF-8
require 'spec_helper'

module Admin
  describe ProductParamItemsController do

    fixtures :products
    let(:product) { products(:lg_fridge) }

    describe "GET index" do
      def get_index
        get :index, product_id: product.id
      end

      it "renders 'index' template" do
        get_index
        response.should render_template("index")
      end

      before do
        product.stub(:param_template).and_return(false)
      end

      context "when rendering views" do
        render_views

        it "renders message when" do
          get_index
          response.body.should have_content("Produkt nemá přiřazenou žádnou šablonu parametrů")
        end
      end
    end
  end
end