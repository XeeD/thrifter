class Company < ActiveRecord::Base
  belongs_to :customer
  has_one :order, through: :customer

  validates :name,
            presence: true,
            length: {maximum: 80}
end