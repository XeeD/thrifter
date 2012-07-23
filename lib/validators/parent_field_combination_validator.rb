# encoding: UTF-8

class ParentFieldCombinationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless record.parent_category.nil?
      options.each_pair { |parent, current_list|
        if record.parent_category.category_type.to_sym == parent
          unless current_list.include?(record.category_type.to_sym)
            record.errors.add(attribute, :forbiden_combination)
          end
        end
      }
    end
  end
end