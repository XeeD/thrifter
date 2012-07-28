# encoding: UTF-8

class ParamValue < ActiveRecord::Base
  belongs_to :product
  belongs_to :param_item
end