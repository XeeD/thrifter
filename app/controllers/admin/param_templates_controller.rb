# encoding: UTF-8

module Admin
  class ParamTemplatesController < AdminController
    def index
    end

    def new
    end

    def create
      if param_template.save
        redirect_to admin_param_templates_path, :notice => "Šablona parametrů #{param_template.name} byla vytvořena"
      else
        flash.now[:error] = "Chyba při vytváření nové šablony parametrů"
        render "new"
      end
    end

    def edit
    end

    def update
      if param_template.update_attributes(params[:param_template])
        redirect_to admin_param_templates_url, :notice => "Šablona parametrů #{param_template.name} byla upravena"
      else
        flash.now[:error] = "Chyba při ukládání šablony parametrů"
        render "edit"
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít danou kategorii"
      redirect_to admin_param_templates_url
    end

    def destroy
      param_template.destroy
      flash[:notice] = "Šablona parametrů #{param_template.name} byla smazána"
    rescue
      flash[:error] = "Nelze najít danou šablonu parametrů"
    ensure
      redirect_to admin_param_templates_url
    end

    private

    def param_template
      @param_templates ||= params[:id] ? ParamTemplate.find(params[:id]) : ParamTemplate.new(params[:param_template])
    end

    helper_method :param_template

    def param_templates
      @param_templates ||= ParamTemplate.all
    end

    helper_method :param_templates
  end
end