# encoding: UTF-8

module Admin
  class NewsItemsController < AdminController

    def choose_shop
    end

    def index
    end

    def new
    end

    def create
      if news_item.save
        redirect_to admin_shop_news_items_url(shop), :notice => "Novinka #{news_item.title} byla vytvořena"
      else
        flash.now[:error] = "Chyba při vytváření novinky"
        render "new"
      end
    end

    def edit
    end

    def update
      if news_item.update_attributes(params[:news_item])
        redirect_to admin_shop_news_items_url(shop), :notice => "Novinka #{news_item.title} byla upravena"
      else
        flash.now[:error] = "Chyba při ukládání novinky"
        render "edit"
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít danou novinku"
      redirect_to admin_shop_news_items_url(shop)
    end

    def destroy
      news_item.destroy
      flash[:notice] = "Novinka #{news_item.title} byla smazána"
    rescue
      flash[:error] = "Nelze najít danou novinku"
    ensure
      redirect_to admin_shop_news_items_url(shop)
    end

    private

    def shop
      @shop ||= Shop.find(params[:shop_id])
    end

    helper_method :shop

    def news_item
      @news_item ||= params[:id] ? news_items.find(params[:id]) : news_items.new(params[:news_item])
    end

    helper_method :news_item

    def news_items
      @news_items ||= shop.news_items
    end

    helper_method :news_items

    def news_items_paginated
      @news_items_paginated ||= Kaminari.paginate_array(news_items.all).page params[:page]
    end

    helper_method :news_items_paginated
  end
end