# encoding: UTF-8
require 'spec_helper'

module Admin
  describe ParamItemsController do
    let(:param_item) { mock_model(ParamItem).as_null_object }
    let(:param_template) { ParamTemplate.find_by_name("Chladničky") }

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

        it "calls new through ParamTemplate.params" do
          param_template.should_receive(:new).with(nil).once
          get_new
        end

        it "shows form" do
          get_new
          response.body.should have_selector("form")
        end
      end
    end
  end
end