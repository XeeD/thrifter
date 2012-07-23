# encoding: UTF-8

module Admin
  class ParamTemplatesController < AdminController
    def index
    end

    def new
    end

    private

    def category
      @category ||= params[:id] ? Category.find(params[:id]) : Category.new(params[:category])
    end

    helper_method :category

    def param_templates
      @param_templates ||= ParamTemplate.all
    end

    helper_method :param_templates
  end
end