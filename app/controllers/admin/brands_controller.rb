# encoding: UTF-8

module Admin
  class BrandsController < AdminController
    def index
    end

    def new
    end

    def create
      if brand.save
        redirect_to admin_brands_url, notice: "Značka #{brand.name} byla vytvořena"
      else
        flash.now[:error] = "Chyba při vytváření nové značky"
        render :action => :new
      end
    end

    def edit
    end

    def update
      if brand.update_attributes(params[:brand])
        redirect_to admin_brands_url, notice: "Značka #{brand.name} byla upravena"
      else
        flash.now[:error] = "Chyba při upravování značky #{brand.name}"
        render :action => :edit
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Neexistující značka"
      redirect_to admin_brands_url
    end

    def destroy
      brand.destroy
      flash[:notice] = "Značka #{brand.name} byla smazána"
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Neznámá značka"
    ensure
      redirect_to admin_brands_url
    end

    private

    def brand
      @brand ||= params[:id] ? Brand.find(params[:id]) : Brand.new(params[:brand])
    end

    helper_method :brand

    def brands
      @brands ||= Brand.all
    end

    helper_method :brands
  end
end