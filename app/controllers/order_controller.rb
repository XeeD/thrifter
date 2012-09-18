# encoding: UTF-8

class OrderController < ApplicationController

  before_filter :order, :enforce_order, except: [:completed]

  def show
  end

  def completed
  end

  def complete
    if order.update_attributes(params[:order])
      order.complete!
      session[:order_token] = nil
      redirect_to completed_order_path #next_step
    else
      render :show
    end
  end

  def update
    if order.update_attributes(params[:order])
      order.complete!
    end
  end

  def edit
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
    redirect_to cart_path if order.nil? || order.completed?
  end
end