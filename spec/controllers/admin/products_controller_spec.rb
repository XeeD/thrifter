require 'spec_helper'

module Admin
  describe ProductsController do
    context "GET index" do
      it "renders index" do
        get :index
        response.should be_success
      end
    end

    context "GET new" do
      it "renders new action" do
        get :new
        response.should be_success
      end

      context "when rendering views" do
        render_views
        
        it "calls Product#new" do
          get :new
          Product.should_receive(:new).with(no_args).once
        end
      end
    end
  end
end