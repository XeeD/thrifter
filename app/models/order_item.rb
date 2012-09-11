class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  def total
    quantity * price
  end
end