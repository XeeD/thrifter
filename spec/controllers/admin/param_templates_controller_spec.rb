# encoding: UTF-8
require 'spec_helper'

module Admin
  describe ParamTemplatesController do
    fixtures :param_templates

    let(:param_template) { mock_model(ParamTemplate).as_null_object }

    before do
      categories = []
      categories.stub(pluck: [])
      param_template.stub(:categories).and_return(categories)
    end

    describe "GET index" do
      it "renders 'index' template" do
        get :index
        response.should render_template("index")
      end

      context "when rendering views" do
        render_views

        it "calls ParamTemplate#all" do
          ParamTemplate.should_receive(:all).with(no_args).once.and_return([param_template])
          get :index
        end
      end
    end

    describe "GET show" do
      let(:param_template) { ParamTemplate.find_by_name("Chladničky") }

      def get_show
        get :show, id: param_template.id
      end

      it "renders 'show' template" do
        get_show
        response.should render_template("show")
      end

      context "when rendering views" do
        render_views

        it "finds the template" do
          ParamTemplate.should_receive(:find).with(param_template.id.to_s).once.and_return(param_template)
          get_show
        end

        it "finds template's groups" do
          ParamTemplate.stub(:find).and_return(param_template)
          param_template.should_receive(:groups).once.and_return([])
          get_show
        end
      end
    end

    describe "GET new" do
      it "renders 'new' template" do
        get :new
        response.should render_template("new")
      end

      context "when rendering views" do
        render_views

        it "calls ParamTemplate#new" do
          ParamTemplate.should_receive(:new).with(nil).once.and_return(param_template)
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
          post :create, :param_template => valid_param_template_attributes
        end

        before do
          ParamTemplate.stub(:new).and_return(param_template.new_instance)
        end

        it "creates new instance of ParamTemplate with those attributes" do
          ParamTemplate.should_receive(:new).with(valid_param_template_attributes).once
          post_valid_attributes
        end

        it "redirects to index" do
          post :create
          response.should redirect_to(admin_param_templates_url)
        end

        it "saves the record" do
          ParamTemplate.stub(:new).and_return(param_template)
          param_template.should_receive(:save).and_return(true)
          post_valid_attributes
        end

        it "sets notice message containing param template's name" do
          param_template.stub(:name).and_return("Chladničky")
          post :create
          flash[:notice].should include(param_template.name)
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        before do
          ParamTemplate.stub(:save).and_return(false)
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
        get :edit, :id => param_template.id
      end

      it "renders template 'edit'" do
        get_edit
        response.should render_template("edit")
      end

      context "when rendering views" do
        render_views

        before do
          ParamTemplate.stub(:find).and_return(param_template)
        end

        it "finds the param template" do
          ParamTemplate.should_receive(:find).with(param_template.id.to_s).once
          get_edit
        end

        it "renders edit form" do
          get :edit, :id => param_template.id
          response.body.should have_selector("form")
        end
      end
    end

    describe "PUT update" do
      # Valid attributes
      context "with valid attributes" do
        def put_update
          put :update, id: param_template.id, param_template: valid_param_template_attributes
        end

        before do
          ParamTemplate.stub(:find).and_return(param_template)
        end

        it "finds the param template" do
          ParamTemplate.should_receive(:find).with(param_template.id.to_s).once.and_return(param_template)
          put_update
        end

        it "updates attributes" do
          param_template.should_receive(:update_attributes).with(valid_param_template_attributes).once
          put_update
        end

        it "redirects to index" do
          put_update
          response.should redirect_to(admin_param_templates_url)
        end

        it "sets notice message containing param template's name" do
          param_template.stub(name: "Chladničky")
          put_update
          flash[:notice].should include(param_template.name)
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        def put_invalid_attributes
          put :update, id: param_template.id, param_template: {}
        end

        before do
          param_template.stub(:update_attributes).and_return(false)
          ParamTemplate.stub(:find).and_return(param_template)
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
          put :update, :id => param_template.id + 1
        end

        it "redirects to index" do
          put_with_invalid_id
          response.should redirect_to(admin_param_templates_url)
        end

        it "sets error message" do
          put_with_invalid_id
          flash.now[:error].should_not be_blank
        end
      end
    end

    describe "DELETE destroy" do
      context "with valid param template id" do
        def delete_param_template
          delete :destroy, :id => param_template.id
        end

        before do
          ParamTemplate.stub(:find).and_return(param_template)
        end

        it "finds the param template" do
          ParamTemplate.should_receive(:find).with(param_template.id.to_s).once
          delete_param_template
        end

        it "redirects to index" do
          delete_param_template
          response.should redirect_to(admin_param_templates_url)
        end

        it "destroys the param template" do
          param_template.should_receive(:destroy).once
          delete_param_template
        end

        it "sets notice message containing param template's name" do
          param_template.stub(name: "Pračky")
          delete_param_template
          flash[:notice].should include(param_template.name)
        end
      end

      context "with non-existing param template id" do
        def delete_invalid_param_template
          delete :destroy, :id => param_template.id + 1
        end

        it "redirects back to index" do
          delete_invalid_param_template
          response.should redirect_to(admin_param_templates_url)
        end

        it "sets error message" do
          delete_invalid_param_template
          flash[:error].should_not be_blank
        end
      end
    end
  end
end