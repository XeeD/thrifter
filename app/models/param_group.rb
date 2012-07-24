class ParamGroup < ActiveRecord::Base
  # Associations
  belongs_to :param_template

  # Validations
  validates :name,
            presence: true,
            length: {maximum: 40},
            uniqueness: {scope: :param_template_id}
end
