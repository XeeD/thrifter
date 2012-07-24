class ParamTemplate < ActiveRecord::Base
  # Associations
  has_many :categories
  has_many :param_groups

  # Attributes
  attr_accessible :name, :category_ids

  # Validations
  validates :name,
            presence: true,
            length: {maximum: 100},
            uniqueness: true
end