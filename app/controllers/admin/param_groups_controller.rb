# encoding: UTF-8

module Admin
  class ParamGroupsController < AdminController
    def new
    end

    def create
      if param_group.save
        redirect_to admin_param_template_url(param_template),
                    notice: "Skupina parametrů #{param_group.name} byla vytvořena"
      else
        flash.now[:error] = "Chyba při vytváření skupiny parametrů"
        render "new"
      end
    end

    def edit
    end

    def update
      if param_group.update_attributes(params[:param_group])
        redirect_to admin_param_template_url(param_template),
                    notice: "Skupina parametrů #{param_group.name} byla upravena"
      else
        flash.now[:error] = "Skupinu parametrů nebylo možné uložit"
        render "edit"
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít danou skupinu parametrů"
      redirect_to admin_param_template_url(param_template)
    end

    def destroy
      param_group.destroy
      flash[:notice] = "Skupina parametrů #{param_group.name} byla smazána"
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít danou skupinu parametrů"
    ensure
      redirect_to admin_param_template_url(param_template)
    end

    def sort
      params[:param_group].each_with_index do |id, index|
        ParamGroup.update_all({position: index+1}, {id: id, param_template_id: param_template.id})
      end
      render nothing: true
    end

    private

    def param_group
      @param_group ||= params[:id] ?
          param_groups.find(params[:id]) :
          param_groups.new(params[:param_group])
    end

    helper_method :param_group

    def param_groups
      @param_groups ||= param_template.groups
    end

    helper_method :param_groups

    def param_template
      @param_template ||= ParamTemplate.find(params[:param_template_id])
    end

    helper_method :param_template
  end
end