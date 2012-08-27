# encoding: UTF-8

module Admin
  class ArticlesController < AdminController

    def choose_shop
    end

    def index
    end

    def new
    end

    def create
      if article.save
        redirect_to admin_shop_articles_url(shop), :notice => "Článek #{article.name} byl vytvořen"
      else
        flash.now[:error] = "Chyba při vytváření článku"
        render "new"
      end
    end

    def edit
    end

    def update
      if article.update_attributes(params[:article])
        redirect_to admin_shop_articles_url(shop), :notice => "Článek #{article.name} byl upraven"
      else
        flash.now[:error] = "Článek nebylo možné uložit"
        render "edit"
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít daný článek"
      redirect_to admin_shop_articles_url(shop)
    end

    def destroy
      article.destroy
      flash[:notice] = "Článek #{article.name} byl smazán"
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít daný článek"
    ensure
      redirect_to admin_shop_articles_url(shop)
    end

    private

    def article
      @article ||= params[:id] ? articles.find(params[:id]) : articles.new(params[:article])
    end

    helper_method :article

    def articles
      @articles ||= shop.articles
    end

    helper_method :articles

    def articles_paginated
      @articles_paginated ||= articles.try(:page, params[:page])
    end

    helper_method :articles_paginated

    def shop
      @shop ||= Shop.find(params[:shop_id])
    end

    helper_method :shop
  end
end