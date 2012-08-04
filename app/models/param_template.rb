# encoding: UTF-8

class ParamTemplate < ActiveRecord::Base
  # Associations
  has_many :categories
  has_many :groups, class_name: "ParamGroup", order: :position
  has_many :param_items, class_name: "ParamItem", include: :param_group

  # Attributes
  attr_accessible :name, :category_ids

  # Validations
  validates :name,
            presence: true,
            length: {maximum: 100},
            uniqueness: true

  validate do |record|
    record.categories.each do |category|
      unless category.product_list?
        record.errors.add(:base, "Přiřazené kategorie musí být produktového typu")
      end
    end
  end
end
