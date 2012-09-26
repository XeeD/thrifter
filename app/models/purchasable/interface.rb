class Purchasable
  module Interface
    extend ActiveSupport::Concern

    # Common shared and required attribtues between purchasable models
    REQUIRED_ATTRIBUTES = [
      :vat_rate,
      :weight,
      :recycling_fee,
      :default_price,
      :name,
      :state
    ]

    REQUIRED_METHODS = [
      :permalink
    ]

    DELEGATED_METHODS = REQUIRED_ATTRIBUTES + REQUIRED_METHODS

    def self.included(base)
      # Shared Associations
      base.has_one :purchasable, as: :goods

      base.validates :purchasable,
                     presence: true

      # Shared callbacks
      base.before_validation :build_purchasable_record

      # Check for required attributes
      REQUIRED_ATTRIBUTES.each do |required_attribute_name|
        unless base.attribute_names.include?(required_attribute_name.to_s)
          raise "Must provide required attribute '#{required_attribute_name}' in subclass #{base.to_s}"
        end
      end

      # Check for required methods
      REQUIRED_METHODS.each do |required_method_name|
        raise base.methods.to_s
        unless base.instance_methods.include?(required_method_name)
          raise "Must provide required method '#{required_method_name}' in subclass #{base.to_s}"
        end
      end
    end

    def build_purchasable_record
      self.purchasable || self.build_purchasable
    end

    module InstanceMethods
      # Shared Instance method definitions
    end

    module ClassMethods
      # Shared Class method definitions
    end
  end
end