# encoding: UTF-8

class Categorization < ActiveRecord::Base
  # Associations
  belongs_to :category
  belongs_to :product

  # Callabacks
  def destroy
    if preferred?
      if product_has_additional_categories_in_shop?
        raise ActiveRecord::ActiveRecordError, "Nelze smazat hlavní kategorii produktu, pokud má produkt v obchodu dodatečné kategorie"
      end
      if Categorization.where(product_id: product_id, preferred: true).size == 1
        raise ActiveRecord::ActiveRecordError, "Produkt musí mít alespoň jednu hlavní kategorii"
      end
    end
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
