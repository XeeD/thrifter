# encoding: UTF-8
require 'spec_helper'

module Admin
  describe ParamGroupsController do
    let(:param_group) { mock_model(ParamGroup).as_null_object }
    let(:param_template) { ParamTemplate.find_by_name("Chladničky") }

    describe "GET index" do
      def get_index
        get :index, param_template_id: param_template.id
      end

      it "renders 'index' template" do
        get_index
        response.should render_template("index")
      end

      context "when rendering views" do
        render_views

        before do
          ParamTemplate.stub(find: param_template)
        end

        it "uses ParamTemplate#groups association to fetch ParamGroups" do
          param_template.should_receive(:groups).with(no_args).once.and_return([param_group])
          get_index
        end

        it "fetches parent ParamTemplate" do
          ParamTemplate.should_receive(:find).with(param_template.id.to_s)
          get_index
        end
      end
    end
  end
end

__END__

    describe "GET new" do
      it "renders 'new' template" do
        get :new
        response.should render_template("new")
      end

      context "when rendering views" do
        render_views

        it "calls ParamGroup#new" do
          ParamGroup.should_receive(:new).with(nil).once.and_return(param_group)
          get :new
        end

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
          post :create, :param_group => valid_param_group_attributes
        end

        before do
          ParamGroup.stub(:new).and_return(param_group.new_instance)
        end

        it "creates new instance of ParamGroup with those attributes" do
          ParamGroup.should_receive(:new).with(valid_param_group_attributes).once
          post_valid_attributes
        end

        it "redirects to index" do
          post :create
          response.should redirect_to(admin_param_groups_url)
        end

        it "saves the record" do
          ParamGroup.stub(:new).and_return(param_group)
          param_group.should_receive(:save).and_return(true)
          post_valid_attributes
        end

        it "sets notice message containing param template's name" do
          param_group.stub(:name).and_return("Chladničky")
          post :create
          flash[:notice].should include(param_group.name)
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        before do
          ParamGroup.stub(:save).and_return(false)
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

    describe "GET edit" do
      def get_edit
        get :edit, :id => param_group.id
      end

      it "renders template 'edit'" do
        get_edit
        response.should render_template("edit")
      end

      context "when rendering views" do
        render_views

        before do
          ParamGroup.stub(:find).and_return(param_group)
        end

        it "finds the param template" do
          ParamGroup.should_receive(:find).with(param_group.id.to_s).once
          get_edit
        end

        it "renders edit form" do
          get :edit, :id => param_group.id
          response.body.should have_selector("form")
        end
      end
    end

    describe "PUT update" do
      # Valid attributes
      context "with valid attributes" do
        def put_update
          put :update, id: param_group.id, param_group: valid_param_group_attributes
        end

        before do
          ParamGroup.stub(:find).and_return(param_group)
        end

        it "finds the param template" do
          ParamGroup.should_receive(:find).with(param_group.id.to_s).once.and_return(param_group)
          put_update
        end

        it "updates attributes" do
          param_group.should_receive(:update_attributes).with(valid_param_group_attributes).once
          put_update
        end

        it "redirects to index" do
          put_update
          response.should redirect_to(admin_param_groups_url)
        end

        it "sets notice message containing param template's name" do
          param_group.stub(name: "Chladničky")
          put_update
          flash[:notice].should include(param_group.name)
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        def put_invalid_attributes
          put :update, id: param_group.id, param_group: {}
        end

        before do
          param_group.stub(:update_attributes).and_return(false)
          ParamGroup.stub(:find).and_return(param_group)
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

      context "with non-existing param template id" do
        def put_with_invalid_id
          put :update, :id => param_group.id + 1
        end

        it "redirects to index" do
          put_with_invalid_id
          response.should redirect_to(admin_param_groups_url)
        end

        it "sets error message" do
          put_with_invalid_id
          flash.now[:error].should_not be_blank
        end
      end
    end

    describe "DELETE destroy" do
      context "with valid param template id" do
        def delete_param_group
          delete :destroy, :id => param_group.id
        end

        before do
          ParamGroup.stub(:find).and_return(param_group)
        end

        it "finds the param template" do
          ParamGroup.should_receive(:find).with(param_group.id.to_s).once
          delete_param_group
        end

        it "redirects to index" do
          delete_param_group
          response.should redirect_to(admin_param_groups_url)
        end

        it "destroys the param template" do
          param_group.should_receive(:destroy).once
          delete_param_group
        end

        it "sets notice message containing param template's name" do
          param_group.stub(name: "Pračky")
          delete_param_group
          flash[:notice].should include(param_group.name)
        end
      end

      context "with non-existing param template id" do
        def delete_invalid_param_group
          delete :destroy, :id => param_group.id + 1
        end

        it "redirects back to index" do
          delete_invalid_param_group
          response.should redirect_to(admin_param_groups_url)
        end

        it "sets error message" do
          delete_invalid_param_group
          flash[:error].should_not be_blank
        end
      end
    end
  end
end