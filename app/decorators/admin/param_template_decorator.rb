class Admin::ParamTemplateDecorator < Draper::Base
  decorates :param_template
  decorates_association :param_items, with: Admin::ParamItemDecorator

  def sorted_param_items_by_group_position
    param_items.sort do |param_item_1, param_item_2|
      param_item_1.param_group_position <=> param_item_2.param_group_position
    end
  end
end