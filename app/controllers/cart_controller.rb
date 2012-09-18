# encoding: UTF-8

class CartController < ApplicationController
  def show
  end

  def add_product
    order.products.find(params[:id])
  end

  def update
    order.update_attributes(params[:order])
    
    redirect_to cart_url, notice: "Košík byl upraven"
  end

  def create
    cart = params[:cart]

    product = Product.find(cart[:product_id])

    session[:order_token] = order.token

    order.add_product(product, cart[:quantity].to_i)
    order.save

    redirect_to add_product_cart_url(id: cart[:product_id]), notice: "Zboží bylo přidáno"
  end

  def destroy
    order.order_items.destroy OrderItem.find(params[:id])

    redirect_to cart_path, notice: "Zboží bylo odstraněno"
  end

  private

  def added_product
    order.products.find(params[:id])
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