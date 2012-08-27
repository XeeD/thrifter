# encoding: UTF-8

class ParamTemplate < ActiveRecord::Base
  # Associations
  has_many :categories
  has_many :groups, class_name: "ParamGroup", order: :position
  has_many :param_items, class_name: "ParamItem", include: :param_group
  has_many :products, through: :categories, group: :id

  default_scope -> { order(:name) }

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
        record.errors.add(
            :base,
            "#{category.plural_name} není produktová kategorie (přiřazené kategorie musí být produktové)")
      end
    end
  end
end
