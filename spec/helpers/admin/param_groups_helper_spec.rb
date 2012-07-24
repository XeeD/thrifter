require "spec_helper"

module Admin
  module ParamGroupHelper
    describe "#param_template_group_path_for_form" do
      let(:param_template) { mock_model(ParamTemplate) }
      let(:param_group) { mock_model(ParamGroup) }

      def method_result
        helper.param_template_group_path_for_form(param_template, param_group)
      end

      it "returns 'admin_param_template_groups_path' for new resource" do
        param_group.as_new_record
        method_result.should == admin_param_template_groups_path(param_template)
      end

      it "returns 'admin_param_template_group_path' for existing resource" do
        method_result.should == admin_param_template_group_path(param_template, param_group)
      end
    end
  end
end