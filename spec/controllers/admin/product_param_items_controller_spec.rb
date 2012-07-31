# encoding: UTF-8
require 'spec_helper'

module Admin
  describe ProductParamItemsController do
    let(:product) { Product.find_by_name("LG GB3133TIJW") }

    describe "GET index" do
      def get_index
        get :index, product_id: product.id
      end

      it "renders 'index' template" do
        get_index
        response.should render_template("index")
      end

      context "when rendering views"
    end
  end
end