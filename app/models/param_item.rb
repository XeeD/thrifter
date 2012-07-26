class ParamItem < ActiveRecord::Base
  belongs_to :param_template
  belongs_to :param_group
end