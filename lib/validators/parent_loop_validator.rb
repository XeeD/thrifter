# encoding: UTF-8

class ParentLoopValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.id == value
      record.errors.add(attribute,:parent_loop)
    end
  end
end