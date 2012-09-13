class OrderItem < ActiveRecord::Base
  belongs_to :order, touch: true
  belongs_to :product

  before_save   :update_order_item

  after_save    :update_order
  after_destroy :update_order

  validates :quantity,
            numericality: {only_integer: true}

  validates :price,
            numericality: {only_integer: true}

  delegate :name,
           :model_name,
           :url,
           :default_price,
           :permalink,

           to: :product, prefix: true

  def total
    quantity * price
  end
  alias :cost :total

  private
  def update_order
    order.update_order!
  end

  def update_order_item
    self.quantity = 0 if quantity.nil? || quantity < 0
    self.destroy if quantity == 0
  end
end