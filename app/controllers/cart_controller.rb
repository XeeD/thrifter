# encoding: UTF-8

class CartController < ApplicationController
  def show
  end

  def update
    cart = params[:cart]

    product = Product.find(cart[:product_id])

    #session[:order_token] = order.token

    order.add_product(product, cart[:quantity])

    redirect_to cart_url, notice: "Zboží bylo přidáno"
  end

  private

  def order
    @order ||= Order.create
  end
end