class ParamGroup < ActiveRecord::Base
  # Macros
  acts_as_list scope: :param_template

  # Associations
  belongs_to :param_template

  # Validations
  validates :name,
            presence: true,
            length: {maximum: 40},
            uniqueness: {scope: :param_template_id}
end
