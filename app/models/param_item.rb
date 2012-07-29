# encoding: UTF-8

class ParamItem < ActiveRecord::Base

  after_initialize :set_defaults

  # Associations
  belongs_to :param_group
  belongs_to :param_template

  has_many :param_values

  #accepts_nested_attributes_for :param_values, allow_destroy: true, reject_if: :reject_param_values

  # Enumerations
  IMPORTANCE = {
      "Důležitý" => "important",
      "Řazení"  => "sortable",
      "Dodatečný" => "additional"
  }

  VALUE_TYPES = {
      "Řetězec" => "string",
      "Číslo" => "int",
      "Pravdivostní hodnota" => "bool"
  }

  CHOICE_TYPES = {
      "Normální" => "input",
      "Výběr z možností" => "radio_buttons",
      "Zaškrtávací" => "check_boxes"
  }

  # Validations
  validates :name,
            presence: true,
            length: {maximum: 65},
            uniqueness: {scope: :param_template_id}

  validates :value_type,
            presence: true,
            length: {maximum: 10},
            inclusion: {in: VALUE_TYPES.values}

  validates :choice_type,
            presence: true,
            length: {maximum: 15},
            inclusion: {in: CHOICE_TYPES.values}

  validates :unit,
            length: {maximum: 30}

  validates :importance,
            presence: true,
            length: {maximum: 15},
            inclusion: {in: IMPORTANCE.values}

  def set_defaults
    self.value_type  ||= 'string'
    self.choice_type ||= 'input'
    self.importance  ||= 'important'
  end

  #def reject_param_values(attrs)
  #  attrs['value'].blank?
  #end
end