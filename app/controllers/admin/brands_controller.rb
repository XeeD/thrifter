# encoding: UTF-8

class Admin::BrandsController < Admin::AdminController
  def index
  end

  def new
  end

  def create
    if brand.save
      redirect_to admin_brands_url, notice: "Značka #{brand.name} byla vytvořena"
    else
      flash.now[:notice] = "Chyba při ukládání nové značky"
      render :action => :new
    end
  end

  def destroy
    brand.destroy
    flash[:notice] = "Značka #{brand.name} byla smazána"
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Neznámá značka"
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