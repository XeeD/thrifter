class OrderItem < ActiveRecord::Base
  belongs_to :order, touch: true
  belongs_to :product

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

           to: :product, prefix: true

  def total
    quantity * price
  end
  alias :cost :total

  private
  def update_order
    order.update_order!
  end
end