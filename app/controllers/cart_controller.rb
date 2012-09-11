# encoding: UTF-8

class CartController < ApplicationController
  def show
  end

  def update
    cart = params[:cart]

    product = Product.find(cart[:product_id])

    session[:order_token] = order.token

    order.add_product(product, cart[:quantity].to_i)

    order.save

    redirect_to cart_url, notice: "Zboží bylo přidáno"
  end

  def destroy
    order.order_items.clear
  end

  private

  def order
    @order ||= begin
      unless session[:order_token].blank?
        OrderDecorator.find_by_token(session[:order_token])
      else
        OrderDecorator.create
      end
    end
  end

  helper_method :order
end