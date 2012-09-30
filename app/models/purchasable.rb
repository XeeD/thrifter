class Purchasable < ActiveRecord::Base
  belongs_to :goods, polymorphic: true

  Purchasable::Interface::DELEGATED_METHODS.each do |attribute|
    delegate attribute,
             to: :goods
  end
end