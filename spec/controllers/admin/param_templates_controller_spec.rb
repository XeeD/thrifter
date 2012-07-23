# encoding: UTF-8
require 'spec_helper'

module Admin
  describe ParamTemplatesController do
    let(:param_template) { mock_model(ParamTemplate).as_null_object }

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
  end
end