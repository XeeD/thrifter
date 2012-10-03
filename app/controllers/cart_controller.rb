# encoding: UTF-8

class CartController < ApplicationController
  def show
  end

  def add_product
  end

  def update
    order.update_attributes(params[:order])
    
    redirect_to cart_url, notice: "Košík byl upraven"
  end

  def create
    goods = params[:goods]

    session[:order_token] = order.token

    purchasable = Purchasable.where(goods_id: goods[:id]).where(goods_type: goods[:type]).first

    order.add_goods(purchasable, goods[:quantity].to_i)

    order.save!

    redirect_to add_product_cart_url(id: purchasable.id)
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Tento produkt nelze vložit do košíku"
    redirect_to :back
  end

  def destroy
    order.order_items.destroy OrderItem.find(params[:id])

    redirect_to cart_path, notice: "Zboží bylo odstraněno"
  end

  private

  def added_product
    order.purchasables.find(params[:id])
  end

  helper_method :added_product

  def order
    @order ||= begin
      unless session[:order_token].blank?
        Order.find_by_token(session[:order_token]) || OrderDecorator.create
      else
        OrderDecorator.create!
      end
    end
  end

  helper_method :order
end