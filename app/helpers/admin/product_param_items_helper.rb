module Admin
  module ProductParamItemsHelper
    def sort_by_param_group_position(param_items)
      param_items.sort do |param_item_1, param_item_2|
        param_item_1.param_group_position <=> param_item_2.param_group_position
      end
    end
  end
end