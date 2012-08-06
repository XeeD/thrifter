class Admin::ParamTemplateDecorator < Draper::Base
  decorates :param_template
  decorates_association :param_items, with: Admin::ParamItemDecorator
end