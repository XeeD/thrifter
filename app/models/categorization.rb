# encoding: UTF-8

class Categorization < ActiveRecord::Base
  # Associations
  belongs_to :category
  belongs_to :product
  scope :in_shop, ->(shop) {
    joins(:category).where(categories: {shop_id: shop.id})
  }
  scope :preferred, -> {
    where(preferred: true)
  }

  # Callabacks
  before_destroy :keep_at_least_one_preferred, :delete_preferred_only_if_no_alternative_in_shop

  def keep_at_least_one_preferred
    if preferred? && Categorization.preferred.where(product_id: product_id).size == 1
      errors.add(:base, "Produkt musí mít alespoň jednu hlavní kategorii")
      # Halt destruction & callback chain
      return false
    end
    true
  end

  def delete_preferred_only_if_no_alternative_in_shop
    if preferred && product_has_additional_categories_in_shop?
      errors.add(:base, "Nelze smazat hlavní kategorii produktu, pokud má produkt v obchodu dodatečné kategorie")
      # Halt destruction & callback chain
      return false
    end
    true
  end

  # Instance methods
  def categorizations_from_same_shop
    Category.where(shop_id: category.shop_id).joins(:categorizations).where("categorizations.product_id = ?", product_id)
  end

  # Validations
  validates_with CategorizationValidator

  private

  def product_has_additional_categories_in_shop?
    categorizations_from_same_shop.where(categorizations: {preferred: false}).exists?
  end
end
