class ParamTemplate < ActiveRecord::Base

  belongs_to :category
  has_many :param_groups

  # Validations
  validates :name,
            presence: true,
            length: {maximum: 100}

end