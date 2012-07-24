module Admin
  module ParamGroupsHelper
    def param_template_group_path_for_form(param_template, param_group)
      if param_group.new_record?
        admin_param_template_groups_path(param_template)
      else
        admin_param_template_group_path(param_template, param_group)
      end
    end

    def semantic_form_for_param_template_group(param_template, param_group, &block)
      path = param_template_group_path_for_form(param_template, param_group)
      semantic_form_for([:admin, param_template, param_group], url: path, &block)
    end
  end
end