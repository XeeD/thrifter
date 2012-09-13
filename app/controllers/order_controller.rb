# encoding: UTF-8

class OrderController < ApplicationController

  def show
  end

  private

  def order
    @order ||= begin
      unless session[:order_token].blank?
        OrderDecorator.find_by_token(session[:order_token])
      else
        redirect_to cart_path
      end
    end
  end

  helper_method :order
end