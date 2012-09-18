# encoding: UTF-8

class ParamItem < ActiveRecord::Base

  after_initialize :set_defaults

  # Associations
  belongs_to :param_group
  belongs_to :param_template

  has_many :param_values
  has_many :parametrizations
  has_many :products, through: :parametrizations

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
      "Výběr z možností" => "choices",
      "Zaškrtávací" => "check_boxes"
  }

  BOOL_CHOICES = {
      "Ano" => "ano",
      "Ne" => "ne",
      "nic" => nil
  }

  # Validations
  validates :param_template,
            presence: true

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

  def is_sortable?
    self.importance == IMPORTANCE.fetch("Řazení")
  end

  private

  def set_defaults
    self.value_type  ||= 'string'
    self.choice_type ||= 'input'
    self.importance  ||= 'important'
  end
end