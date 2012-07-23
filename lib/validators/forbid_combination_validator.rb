# encoding: UTF-8

class ForbidCombinationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless record.parent_category.nil?
      options.each_pair { |parent, current_list|
        current_list.each { |current|
          if record.parent_category.category_type == parent &&
             record.category_type == current

            record.errors.add(attribute,:forbiden_combination)
          end
        }
      }
    end
  end
end