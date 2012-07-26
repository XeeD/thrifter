module Admin
  class ParamItemsController < AdminController
    def new
      param_template.param_items
    end

    private

    def param_template
      @param_template ||= ParamTemplate.find(params[:param_template_id])
    end

    helper_method :param_template

    def param_item
      @param ||= params[:id] ?
          param_template.param_items.find(params[:id]) :
          param_template.param_items.new(params[:param])
    end

    helper_method :param_item

    def param_items
      param_template.param_items
    end

    helper_method :param_items
  end
end