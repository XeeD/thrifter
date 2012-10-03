class OrderItem < ActiveRecord::Base
  belongs_to :order, touch: true

  belongs_to :purchasable

  before_save   :update_order_item

  after_save    :update_order
  after_destroy :update_order

  validates :quantity,
            presence: true,
            numericality: {only_integer: true, greater_than_or_equal: 0}

  validates :price,
            presence: true,
            numericality: {only_integer: true, greater_than_or_equal: 0}

  validates :recycling_fee,
            numericality: {only_integer: true, greater_than_or_equal: 0}

  validates :purchasable,
            presence: true

  Purchasable::Interface::DELEGATED_METHODS.each do |attribute|
    delegate attribute,
             to: "purchasable.goods"
  end

  delegate :permalink,
  #         :default_price,
  #         :name,
  #
  #         #:model_name,
  #         #:url,
  #         #:default_price,
  #         #:permalink,
  #
           to: :purchasable#, prefix: true

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