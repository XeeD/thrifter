require 'spec_helper'

module Admin
  describe ShippingMethodsController do
    fixtures :shipping_methods
    let(:shipping_method) { mock_model(ShippingMethod).as_null_object }

    describe "GET index" do
      it "renders 'index' template" do
        get :index
        response.should render_template("index")
      end
    end

    describe "GET new" do
      it "renders 'new' template" do
        get :new
        response.should render_template("new")
      end

      context "when rendering views" do
        render_views

        it "shows form" do
          get :new
          response.body.should have_selector("form")
        end
      end
    end

    describe "POST create" do
      # Valid attributes
      context "with valid attributes" do
        def post_valid_attributes
          post :create, :shipping_method => valid_shipping_method_attributes
        end

        before do
          ShippingMethod.stub(:new).and_return(shipping_method.new_instance)
        end

        it "creates new instance of ShippingMethod with those attributes" do
          ShippingMethod.should_receive(:new).with(valid_shipping_method_attributes).once
          post_valid_attributes
        end

        it "redirects to index" do
          post :create
          response.should redirect_to(admin_shipping_methods_url)
        end

        it "saves the record" do
          ShippingMethod.stub(:new).and_return(shipping_method)
          shipping_method.should_receive(:save).and_return(true)
          post_valid_attributes
        end

        it "sets notice message containing shipping method's name" do
          shipping_method.stub(:name).and_return("LG GB3133TIJW")
          post :create
          flash[:notice].should include(shipping_method.name)
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        before do
          ShippingMethod.stub(:save).and_return(false)
        end

        it "renders the template 'new' again" do
          post :create
          response.should render_template("new")
        end

        it "sets error message for current request" do
          post :create
          flash.now[:error].should_not be_blank
        end
      end
    end

    def stub_find
      ShippingMethod.stub(:find).and_return(shipping_method)
    end

    describe "GET edit" do
      def get_edit
        get :edit, :id => shipping_method.id
      end

      it "renders template 'edit'" do
        get_edit
        response.should render_template("edit")
      end

      context "when rendering views" do
        render_views

        before do
          stub_find
        end

        it "finds the shipping_method" do
          ShippingMethod.should_receive(:find).with(shipping_method.id.to_s).once
          get_edit
        end

        it "renders edit form" do
          get :edit, :id => shipping_method.id
          response.body.should have_selector("form")
        end
      end
    end

    describe "PUT update" do
      # Valid attributes
      context "with valid attributes" do
        def put_update
          put :update, id: shipping_method.id, shipping_method: valid_shipping_method_attributes
        end

        before do
          stub_find
        end

        it "finds the shipping_method" do
          ShippingMethod.should_receive(:find).with(shipping_method.id.to_s).once.and_return(shipping_method)
          put_update
        end

        it "updates attributes" do
          shipping_method.should_receive(:update_attributes).with(valid_shipping_method_attributes).once
          put_update
        end

        it "redirects to index" do
          put_update
          response.should redirect_to(admin_shipping_methods_url)
        end

        it "sets notice message containing shipping_method's name" do
          shipping_method.stub(name: "PPL")
          put_update
          flash[:notice].should include(shipping_method.name)
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        def put_invalid_attributes
          put :update, id: shipping_method.id, shipping_method: {}
        end

        before do
          shipping_method.stub(:update_attributes).and_return(false)
          stub_find
        end

        it "renders edit action again" do
          put_invalid_attributes
          response.should render_template("edit")
        end

        it "sets error message for current request" do
          put_invalid_attributes
          flash.now[:error].should_not be_blank
        end
      end

      context "with non-existing shipping_method id" do
        def put_with_invalid_id
          put :update, :id => shipping_method.id + 1
        end

        it "redirects to index" do
          put_with_invalid_id
          response.should redirect_to(admin_shipping_methods_url)
        end

        it "sets error message" do
          put_with_invalid_id
          flash.now[:error].should_not be_blank
        end
      end
    end

    describe "DELETE destroy" do
      context "with valid shipping_method id" do
        def delete_shipping_method
          delete :destroy, :id => shipping_method.id
        end

        before do
          stub_find
        end

        it "finds the shipping_method" do
          ShippingMethod.should_receive(:find).with(shipping_method.id.to_s).once
          delete_shipping_method
        end

        it "redirects to index" do
          delete_shipping_method
          response.should redirect_to(admin_shipping_methods_url)
        end

        it "destroys the shipping_method" do
          shipping_method.should_receive(:destroy).once
          delete_shipping_method
        end

        it "sets notice message containing shipping_method's name" do
          shipping_method.stub(name: "LG GB3133TIJW")
          delete_shipping_method
          flash[:notice].should include(shipping_method.name)
        end
      end

      context "with non-existing shipping_method id" do
        def delete_invalid_shipping_method
          delete :destroy, :id => shipping_method.id + 1
        end

        it "redirects back to index" do
          delete_invalid_shipping_method
          response.should redirect_to(admin_shipping_methods_url)
        end

        it "sets error message" do
          delete_invalid_shipping_method
          flash[:error].should_not be_blank
        end
      end
    end
  end
end