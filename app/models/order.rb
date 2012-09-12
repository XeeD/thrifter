class Order < ActiveRecord::Base

  has_many :order_items, autosave: true, dependent: :destroy

  belongs_to :customer

  before_create :set_order_token, :set_order_number
  #after_create :create_shipment, :create_payment

  before_save :update_order
  #after_save :update_shipment, :update_payment

  validates :token, uniqueness: true

  attr_protected :item_total, :total, :token, :number

  state_machine :state, initial: :in_progress do

    event :complete do
      transition :in_progress => :completed
    end

    event :confirm do
      transition :completed => :confirmed
    end

    event :cancel do
      transition [:resumed, :completed, :confirmed] => :canceled
    end

    event :resume do
      transition :canceled => :resumed
    end

    event :send do
      transition [:resumed, :confirmed] => :sent
    end

    event :return do
      transition :sent => :returned
    end
  end

  def completed?
    !! completed_at
  end

  def contains?(product)
    order_items.select {|order_item|
      order_item.product_id == product.id
    }.first
  end

  def add_product(product, quantity = 1)
    order_item = contains?(product)

    if order_item
      quantity > 1 ? order_item.quantity += quantity : order_item.quantity += 1
    else
      new_order_item = OrderItem.new({
                                         quantity: quantity,
                                         price: product.default_price,
                                         product_id: product.id
                                     })

      order_items << new_order_item
    end
  end

  def update_line_items
    # delete products with 0 quantity
  end

  def update_order
    # update order items cost
    self.item_total = order_items.collect(&:cost).sum

    self.total = item_total
  end

  def update_order!
    update_order
    save!
  end

  private

  def set_order_number
    self.number = generate_order_number
  end

  def set_order_token
    while (self.token = generate_token)
      break unless Order.find_by_token(self.token)
    end
  end

  def generate_number

  end

  def generate_token
    (0...10).map{65.+(rand(25)).chr}.join
  end
end