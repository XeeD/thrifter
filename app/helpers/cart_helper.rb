# encoding: UTF-8

module CartHelper
  def shopping_cart
    if has_shopping_order?
      shopping_order.inspect
    else
      "Košík je zatím prázdný"
    end.html_safe
  end
end