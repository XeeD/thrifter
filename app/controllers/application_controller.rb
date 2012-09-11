class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :set_layout_template

  def set_pjax_data(id, data)
    pjax_data[id.to_sym] = data
  end

  def pjax_data
    @pjax_data ||= {}
  end

  protected

  def has_shopping_order?
    !session[:order_token].blank?
  end

  helper_method :has_shopping_order?

  def shopping_order
    @shopping_order ||= Order.find_by_token(session[:order_token]) if has_shopping_order?
  end

  helper_method :shopping_order

  def pjax_request?
    env['HTTP_X_PJAX'].present?
  end

  private

  def set_layout_template
    if request.headers['X-PJAX']
      "pjax"
    else
      "application"
    end
  end
end