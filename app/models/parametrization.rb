# encoding: UTF-8

class Parametrization < ActiveRecord::Base
  # Associations
  belongs_to :product
  belongs_to :param_item
  belongs_to :param_value
end
