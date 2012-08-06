class Admin::ParamItemDecorator < Draper::Base
  decorates :param_item

  def param_group_position
    param_group.position rescue 0
  end

  def param_group_name
    param_group.name rescue nil
  end
end