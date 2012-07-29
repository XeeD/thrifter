class Categorization < ActiveRecord::Base
  # Associations
  belongs_to :category
  belongs_to :product

  # Validations
  validates :category_id,
            uniqueness: {scope: :product}
end
