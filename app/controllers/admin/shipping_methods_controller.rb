# encoding: UTF-8

module Admin
  class ShippingMethodsController < Admin::AdminController
    def index
    end

    def new
      shipping_method.package_sizes.build
    end

    def create
      if shipping_method.save
        redirect_to admin_shipping_methods_url, :notice => "Typ dopravy #{shipping_method.name} byl vytvořen"
      else
        flash.now[:error] = "Chyba při vytváření typu dopravy"
        render "new"
      end
    end

    def edit
    end

    def update
      if shipping_method.update_attributes(params[:shipping_method])
        redirect_to admin_shipping_methods_url,
                    notice: "Typ dopravy #{shipping_method.name} byl upraven"
      else
        flash.now[:error] = "Chyba při ukládání typu dopravy"
        render "edit"
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít daný typ dopravy"
      redirect_to admin_shipping_methods_url
    end

    def destroy
      shipping_method.destroy
      flash[:notice] = "Typ dopravy #{shipping_method.name} byl smazán"
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít daný typ dopravy"
    ensure
      redirect_to admin_shipping_methods_url
    end

    def sort
      params[:shipping_method].each_with_index do |id, index|
        ShippingMethod.update_all({position: index+1}, {id: id})
      end
      render nothing: true
    end

    private

    def shipping_method
      @shipping_method ||= params[:id] ? ShippingMethod.find(params[:id]) : ShippingMethod.new(params[:shipping_method])
    end

    helper_method :shipping_method

    def shipping_methods
      @shipping_methods ||= ShippingMethod.all
    end

    helper_method :shipping_methods
  end
end