class ParamTemplate < ActiveRecord::Base
  # Associations
  has_many :categories
  has_many :groups, class_name: "ParamGroup"

  # Attributes
  attr_accessible :name, :category_ids

  # Validations
  validates :name,
            presence: true,
            length: {maximum: 100},
            uniqueness: true
end