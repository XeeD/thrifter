class Purchasable
  module Interface
    extend ActiveSupport::Concern

    # Common shared and required attribtues between purchasable models
    DELEGATED_METHODS = [
      :vat_rate,
      :weight,
      :price,
      :name,
      :state,
      :permalink
    ]

    def self.included(base)
      define_association(base)
    end

    def self.define_association(base_class)
      # Shared Associations
      base_class.has_one :purchasable, as: :goods

      base_class.validates :purchasable,
                     presence: true

      # Shared callbacks
      base_class.before_validation :ensure_purchasable_exists
    end

    def ensure_purchasable_exists
      purchasable || build_purchasable
    end
  end
end
