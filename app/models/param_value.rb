# encoding: UTF-8

class ParamValue < ActiveRecord::Base
  # Associations
  belongs_to :param_item

  # Validations
  validates :param_item,
            presence: true

  validates :value,
            presence: true,
            length: {maximum: 40}
end