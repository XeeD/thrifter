class Order < ActiveRecord::Base

  has_many :order_items, autosave: true

  belongs_to :customer

  before_create :set_token, :set_number
  #after_create :create_shipment, :create_payment

  before_save :update_line_items, :update_totals
  #after_save :update_shipment, :update_payment

  validates :token, uniqueness: true

  state_machine :state, initial: :in_progress do

    event :complete do
      transition :all => :completed
    end
  end

  def contains?(product)
    order_items.select {|order_item|
      order_item.product_id == product.id
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

  private

  def set_number
  end

  def set_token
    while (self.token = generate_token)
      break unless Order.find_by_token(self.token)
    end
  end

  def generate_token
    (0...10).map{65.+(rand(25)).chr}.join
  end
end