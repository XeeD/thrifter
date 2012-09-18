# encoding: UTF-8

class OrderController < ApplicationController

  before_filter :enforce_order, except: [:completed]

  def show
  end

  def completed
  end

  def update
    if order.update_attributes(params[:order])
      redirect_to completed_order_path #next_step
    else
      render :show
    end
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

  def enforce_order
    redirect_to cart_path unless order
  end
end