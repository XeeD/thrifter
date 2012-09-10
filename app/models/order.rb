class Order < ActiveRecord::Base

  before_create :generate_token, :generate_number
  #after_create :create_shipment, :create_payment

  before_save :update_line_items, :update_totals
  #after_save :update_shipment, :update_payment

  def contains?(product)
    order_items.select {|order_item|
      order_item.product_id == product.product_id
    }.first
  end

  def add_product(product, quantity = 1)
    order_item = contains?(product)

    if order_item
      quantity > 1 ? order_item.quantity += quantity : order_item.quantity + 1
    else
      new_order_item = OrderItem.new({
                                         quantity: quantity,
                                         product_id: product.id
                                     })

      order_items << new_order_item
    end

    save
  end

  def update_line_items
    # delete products with 0 quantity
  end

  def update_totals
    # update order items cost
  end

  def update_totals!
    update_totals
    save!
  end

  def generate_number
  end

  def generate_token
  end
end