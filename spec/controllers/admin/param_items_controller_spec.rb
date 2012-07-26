# encoding: UTF-8
require 'spec_helper'

module Admin
  describe ParamItemsController do
    let(:param_item) { mock_model(ParamItem).as_null_object }
    let(:param_template) { ParamTemplate.find_by_name("Chladničky") }

    before do
      ParamTemplate.stub(find: param_template)
    end

    describe "GET new" do
      def get_new
        get :new, param_template_id: param_template.id
      end

      it "renders 'new' template" do
        get_new
        response.should render_template("new")
      end

      context "when rendering views" do
        render_views

        let(:new_param_item) { mock_model(ParamItem).as_new_record }

        before do
          param_template.stub_chain(:param_items, :new).with(nil).and_return(new_param_item)
        end

        it "calls new through ParamTemplate.param_items" do
          param_template.param_items.should_receive(:new).with(nil).once
          get_new
        end

        it "shows form" do
          get_new
          response.body.should have_selector("form")
        end
      end
    end

    describe "POST create" do
      before do
        param_template.stub_chain(:param_items, :new).and_return(param_item.as_new_record)
      end

      def post_create(param_item_attributes=nil)
        post :create, param_template_id: param_template.id, param_item: param_item_attributes
      end

      # Valid attributes
      context "with valid attributes" do

        def post_valid_attributes
          post_create(valid_param_item_attributes)
        end

        it "creates new instance of ParamItem with those attributes" do
          param_template.param_items.should_receive(:new).with(valid_param_item_attributes).once
          post_valid_attributes
        end

        it "redirects to index" do
          post_create
          response.should redirect_to(admin_param_template_url(param_template))
        end

        it "saves the record" do
          param_item.should_receive(:save).and_return(true)
          post_create
        end

        it "sets notice message containing param_item's name" do
          param_item.stub(:name).and_return("Šířka")
          post_create
          flash[:notice].should include(param_item.name)
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        before do
          param_item.stub(:save).and_return(false)
        end

        it "renders the template 'new' again" do
          post_create
          response.should render_template("new")
        end

        it "sets error message for current request" do
          post_create
          flash.now[:error].should_not be_blank
        end
      end
    end

    describe "GET edit" do
      def get_edit
        get :edit, param_template_id: param_template.id, id: param_item.id
      end

      it "renders template 'edit'" do
        get_edit
        response.should render_template("edit")
      end

      context "when rendering views" do
        render_views

        before do
          param_template.stub_chain(:param_items, :find).and_return(param_item)
        end

        it "finds the param item" do
          param_template.param_items.should_receive(:find).with(param_item.id.to_s).once
          get_edit
        end

        it "renders edit form" do
          get_edit
          response.body.should have_selector("form")
        end
      end
    end

    describe "PUT update" do
      def put_update(attributes={})
        put :update,
            param_template_id: param_template.id,
            id: param_item.id,
            param_item: valid_param_item_attributes
      end

      before do
        param_template.stub_chain(:param_items, :find).and_return(param_item)
      end

      # Valid attributes
      context "with valid attributes" do
        def put_update_with_valid_attributes
          put_update(param_item: valid_param_item_attributes)
        end

        it "finds the param item" do
          param_template.param_items.should_receive(:find).with(param_item.id.to_s).once.and_return(param_item)
          put_update_with_valid_attributes
        end

        it "updates attributes" do
          param_item.should_receive(:update_attributes).with(valid_param_item_attributes).once
          put_update_with_valid_attributes
        end

        it "redirects to index" do
          put_update_with_valid_attributes
          response.should redirect_to(admin_param_template_url(param_template))
        end

        it "sets notice message containing param param item's name" do
          param_item.stub(name: "Výška")
          put_update_with_valid_attributes
          flash[:notice].should include(param_item.name)
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        before do
          param_item.stub(:update_attributes).and_return(false)
          ParamItem.stub(:find).and_return(param_item)
        end

        it "renders edit action again" do
          put_update
          response.should render_template("edit")
        end

        it "sets error message for current request" do
          put_update
          flash.now[:error].should_not be_blank
        end
      end

      context "with non-existing param item id" do
        def put_with_invalid_id
          put :update, param_template_id: param_template.id, id: param_item.id + 1
        end

        before do
          param_template.stub_chain(:param_items, :find).and_raise(ActiveRecord::RecordNotFound)
        end

        it "redirects to index" do
          put_with_invalid_id
          response.should redirect_to(admin_param_template_url(param_template))
        end

        it "sets error message" do
          put_with_invalid_id
          flash.now[:error].should_not be_blank
        end
      end
    end

    describe "DELETE destroy" do
      def delete_param_item
        delete :destroy, param_template_id: param_template.id, id: param_item.id
      end

      before do
        param_template.stub_chain(:param_items, :find).and_return(param_item)
      end

      it "redirects to index" do
        delete_param_item
        response.should redirect_to(admin_param_template_url(param_template))
      end

      context "with valid param item id" do
        it "destroys the param item" do
          param_item.should_receive(:destroy).once
          delete_param_item
        end

        it "sets notice message containing param item's name" do
          param_item.stub(name: "Šířka")
          delete_param_item
          flash[:notice].should include(param_item.name)
        end
      end

      context "with non-existing param item id" do
        def delete_invalid_param_item
          delete :destroy, param_template_id: param_template.id, id: param_item.id + 1
        end

        it "sets error message" do
          param_template.stub_chain(:param_items, :find).and_raise(ActiveRecord::RecordNotFound)
          delete_invalid_param_item
          flash[:error].should_not be_blank
        end
      end
    end
  end
end