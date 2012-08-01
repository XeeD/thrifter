# encoding: UTF-8
require 'spec_helper'

module Admin
  describe ParamGroupsController do
    fixtures :all

    let(:param_group) { mock_model(ParamGroup).as_null_object }
    let(:param_template) { param_templates(:fridges) }

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

        let(:new_param_group) { mock_model(ParamGroup).as_new_record }

        before do
          param_template.stub_chain(:groups, :new).with(nil).and_return(new_param_group)
        end

        it "calls new through ParamTemplate.groups" do
          param_template.groups.should_receive(:new).with(nil).once
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
        param_template.stub_chain(:groups, :new).and_return(param_group.as_new_record)
      end

      def post_create(param_group_attributes=nil)
        post :create, param_template_id: param_template.id, param_group: param_group_attributes
      end

      # Valid attributes
      context "with valid attributes" do

        def post_valid_attributes
          post_create(valid_param_group_attributes)
        end

        it "creates new instance of ParamGroup with those attributes" do
          param_template.groups.should_receive(:new).with(valid_param_group_attributes).once
          post_valid_attributes
        end

        it "redirects to index" do
          post_create
          response.should redirect_to(admin_param_template_url(param_template))
        end

        it "saves the record" do
          param_group.should_receive(:save).and_return(true)
          post_create
        end

        it "sets notice message containing param group's name" do
          param_group.stub(:name).and_return("Televize")
          post_create
          flash[:notice].should include(param_group.name)
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        before do
          param_group.stub(:save).and_return(false)
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
        get :edit, param_template_id: param_template.id, id: param_group.id
      end

      it "renders template 'edit'" do
        get_edit
        response.should render_template("edit")
      end

      context "when rendering views" do
        render_views

        before do
          param_template.stub_chain(:groups, :find).and_return(param_group)
        end

        it "finds the param group" do
          param_template.groups.should_receive(:find).with(param_group.id.to_s).once
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
            id: param_group.id,
            param_group: valid_param_group_attributes
      end

      before do
        param_template.stub_chain(:groups, :find).and_return(param_group)
      end

      # Valid attributes
      context "with valid attributes" do
        def put_update_with_valid_attributes
          put_update(param_group: valid_param_group_attributes)
        end

        it "finds the param group" do
          param_template.groups.should_receive(:find).with(param_group.id.to_s).once.and_return(param_group)
          put_update_with_valid_attributes
        end

        it "updates attributes" do
          param_group.should_receive(:update_attributes).with(valid_param_group_attributes).once
          put_update_with_valid_attributes
        end

        it "redirects to index" do
          put_update_with_valid_attributes
          response.should redirect_to(admin_param_template_url(param_template))
        end

        it "sets notice message containing param group's name" do
          param_group.stub(name: "Chladničky")
          put_update_with_valid_attributes
          flash[:notice].should include(param_group.name)
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        before do
          param_group.stub(:update_attributes).and_return(false)
          ParamGroup.stub(:find).and_return(param_group)
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

      context "with non-existing param group id" do
        def put_with_invalid_id
          put :update, param_template_id: param_template.id, id: param_group.id + 1
        end

        before do
          param_template.stub_chain(:groups, :find).and_raise(ActiveRecord::RecordNotFound)
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
      def delete_param_group
        delete :destroy, param_template_id: param_template.id, id: param_group.id
      end

      before do
        param_template.stub_chain(:groups, :find).and_return(param_group)
      end

      it "redirects to index" do
        delete_param_group
        response.should redirect_to(admin_param_template_url(param_template))
      end

      context "with valid param group id" do
        it "destroys the param group" do
          param_group.should_receive(:destroy).once
          delete_param_group
        end

        it "sets notice message containing param group's name" do
          param_group.stub(name: "Pračky")
          delete_param_group
          flash[:notice].should include(param_group.name)
        end
      end

      context "with non-existing param group id" do
        def delete_invalid_param_group
          delete :destroy, param_template_id: param_template.id, id: param_group.id + 1
        end

        it "sets error message" do
          param_template.stub_chain(:groups, :find).and_raise(ActiveRecord::RecordNotFound)
          delete_invalid_param_group
          flash[:error].should_not be_blank
        end
      end
    end

    describe "POST sort" do
      it "sets position to groups according to sent params" do
        old_order = ParamGroup.order(:position).pluck(:id)
        new_order_post = old_order.reverse

        post :sort, param_template_id: param_template.id, param_group: new_order_post

        new_order = ParamGroup.order(:position).pluck(:id)
        new_order.should == old_order.reverse
      end
    end
  end
end