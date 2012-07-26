# encoding: UTF-8

module Admin
  class ParamItemsController < AdminController
    def new
    end

    def create
      if param_item.save
        redirect_to admin_param_template_url(param_template),
                    notice: "Parametr #{param_item.name} byl vytvořen"
      else
        flash.now[:error] = "Chyba při vytváření parametru"
        render "new"
      end
    end

    def edit
    end

    def update
      if param_item.update_attributes(params[:param_item])
        redirect_to admin_param_template_url(param_template),
                    notice: "Parametr #{param_item.name} byl upraven"
      else
        flash.now[:error] = "Parametr nebylo možné uložit"
        render "edit"
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít daný parametr"
      redirect_to admin_param_template_url(param_template)
    end

    def destroy
      param_item.destroy
      flash[:notice] = "Parametr #{param_item.name} byl smazána"
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít daný parametr"
    ensure
      redirect_to admin_param_template_url(param_template)
    end

    private

    def param_template
      @param_template ||= ParamTemplate.find(params[:param_template_id])
    end

    helper_method :param_template

    def param_item
      @param_item ||= params[:id] ?
          param_template.param_items.find(params[:id]) :
          param_template.param_items.new(params[:param_item])
    end

    helper_method :param_item

    def param_items
      @param_items ||= param_template.param_items
    end

    helper_method :param_items
  end
end