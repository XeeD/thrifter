# encoding: UTF-8

class CartController < ApplicationController
  def show
  end

  def show_summary
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

    redirect_to show_summary_cart_url, notice: "Zboží bylo přidáno"
  end

  def destroy
    order.order_items.destroy OrderItem.find(params[:id])

    redirect_to cart_path, notice: "Zboží bylo odstraněno"
  end

  private

  def order
    @order ||= begin
      unless session[:order_token].blank?
        #begin
          OrderDecorator.find_by_token(session[:order_token])
        #rescue ActiveRecord::RecordNotFound
        #  OrderDecorator.create
        #end
      else
        OrderDecorator.create
      end
    end
  end

  helper_method :order
end