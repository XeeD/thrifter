# encoding: UTF-8

class Admin::ShopsController < Admin::AdminController
  def index
  end

  def new
  end

  def create
    if shop.save
      redirect_to admin_shops_url,
                  notice: "Obchod #{shop.name} byl vytvořen"
    else
      flash.now[:error] = "Chyba při ukládání obchodu"
      render "new"
    end
  end

  def edit
  end

  def update
    if shop.update_attributes(params[:shop])
      redirect_to admin_shops_url,
                  notice: "Obchod #{shop.name} byl upraven"
    else
      flash.now[:error] = "Chyba při editaci obchodu"
      render "edit"
    end
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Nelze najít daný obchod"
    redirect_to admin_shops_url
  end

  def deletion_confirmation
  end

  def destroy
    if params[:confirmation] == "SMAZAT"
      shop.destroy
      flash[:notice] = "Obchod #{shop.name} byl smazán"
    else
      flash[:error] = "Obchod nelze smazat bez předchozího potvrzení"
    end
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Nelze najít daný obchod"
  ensure
    redirect_to admin_shops_url
  end


  private

  def shop
    @shop ||= params[:id] ? Shop.find(params[:id]) : Shop.new(params[:shop])
  end

  helper_method :shop

  def shops
    @shops ||= Shop.all
  end

  helper_method :shops
end
