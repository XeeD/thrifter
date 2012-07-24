module Admin
  class ParamGroupsController < AdminController
    def index
    end


    private

    def param_template
      @param_template ||= ParamTemplate.find(params[:param_template_id])
    end

    def param_group
      param_template.groups.find(params[:id])
    end

    helper_method :param_group

    def param_groups
      @param_groups ||= param_template.groups
    end

    helper_method :param_groups
  end
end