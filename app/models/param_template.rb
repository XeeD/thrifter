class ParamTemplate < ActiveRecord::Base

  has_many :categories
  has_many :param_groups

  attr_accessible :name, :category_ids

  # Validations
  validates :name,
            presence: true,
            length: {maximum: 100}
end