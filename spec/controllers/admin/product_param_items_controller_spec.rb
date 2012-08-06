# encoding: UTF-8
require 'spec_helper'

module Admin
  describe ProductParamItemsController do

    fixtures :products
    fixtures :param_templates
    fixtures :param_items

    let(:product) { products(:lg_fridge) }
    let(:param_template) { param_templates(:fridges) }
    let(:processor) { ProductParamItemsProcessor.as_null_object }

    before do
      Product.stub(find: product)
      processor.stub(:save_params).with(valid_param_items_attributes).and_return(true)
    end

    def valid_param_items_attributes
      {
          1 => "100",
          3 => %w(BioShield BigBox)
      }
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

        it "renders message when has no param template assigned" do
          product.stub_chain(:param_template, :nil?).and_return(true)
          get_index
          response.body.should have_selector(".empty_set")
        end

        it "renders message when param template has no parameters assigned" do
          product.param_template.stub_chain(:param_items, :nil?).and_return(true)
          get_index
          response.body.should have_selector(".empty_set")
        end

        it "shows form" do
          get_index
          response.body.should have_selector("form")
        end

        it "contains the name of product that parameters belong to" do
          get_index
          response.body.should have_selector("h2", content: product.name)
        end
      end
    end

    describe "POST create" do
      def post_create
        @request.env["HTTP_REFERER"] = admin_product_params_url(product)
        post :create, product_id: product.id, param_items: valid_param_items_attributes
      end

      context "params processor" do
        it "receives new with product id" do
          processor.should_receive(:new).with(product.id.to_s)
          post_create
        end

        it "receives save_params with valid_param_items_attributes" do
          processor.should_receive(:new).with(product.id.to_s)
          processor.should_receive(:save_params).with(valid_param_items_attributes).and_return(true)
          post_create
        end
      end

      it "redirects back to parameters tab" do
        post_create
        response.should redirect_to(admin_product_params_url(product))
      end

      it "sets notice message" do
        post_create
        flash[:notice].should_not be_blank
      end
    end
  end
end