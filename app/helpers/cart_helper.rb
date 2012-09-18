# encoding: UTF-8

module CartHelper
  def shopping_cart_bar
    if shopping_cart_order.present? && shopping_cart_order.item_count > 0
      cart = shopping_cart_order

      link_to "<span>
                  <strong>#{cart.item_count}</strong>
                    #{translate_item_count(cart.item_count)}
                    za <strong><em>#{number_to_currency(cart.total)}</em></strong>
                </span>".html_safe,
              cart_path
    else
      "Košík je zatím prázdný"
    end.html_safe
  end

  def translate_item_count(count)
    case count
      when 1     then "položka"
      when 2..4  then "položky"
      else "položek"
    end
  end
end