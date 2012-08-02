# encoding: UTF-8

class Categorization < ActiveRecord::Base
  # Associations
  belongs_to :category
  belongs_to :product

  validate do
    # Product can have only one preferred category in shop
    if preferred? and product_has_preferred_category_in_shop?
      errors.add(:base, "Produkt #{product.name} již má v tomto obchodě hlavní katgorii")
    end

    # Product cannot be assigned to additional category when it has no preferred category in that shop
    unless preferred?
      unless product_has_preferred_category_in_shop?
        errors.add(
            :base,
            "Produkt #{product.name} nemá v tomto obchodě určenou hlavní katgorii, nemůžeme jej přidat do dodatečné kategorie")
      end
    end

    # Product cannot be assigned to category with different param template
    unless category_has_the_same_param_template_as_preferred?
      errors.add(
          :base,
          "Produkt lze přidat pouze do kategorie se stejnou šablonou parametrů, jako má jeho hlavní kategorie")
    end

    # Product cannot be assigned to navigational category
    if category.navigational?
      errors.add(
          :base,
          "Produkt lze přidat pouze do kategorie se stejnou šablonou parametrů, jako má jeho hlavní kategorie")
    end

    # Product cannot be assigned to a category when it is already assigned to it's ancestor
    if assigned_to_ancestors_of_category?
      errors.add(
          :base,
          "Produkt je již přiřazen některé nadřazené kategorii")
    end
  end

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

  private

  def product_has_preferred_category_in_shop?
    categorizations_from_same_shop.where(categorizations: {preferred: true}).exists?
  end

  def product_has_additional_categories_in_shop?
    categorizations_from_same_shop.where(categorizations: {preferred: false}).exists?
  end

  def categorizations_from_same_shop
    Category.where(shop_id: category.shop_id).joins(:categorizations).where("categorizations.product_id = ?", product_id)
  end

  def sample_preferred_category
    Categorization.where(product_id: product_id, preferred: true).first.category
  end

  def category_has_the_same_param_template_as_preferred?
    category.assigned_param_template_id == sample_preferred_category.assigned_param_template_id
  end

  def assigned_to_ancestors_of_category?
    category.ancestors.joins(:categorizations).where(categorizations: {product_id: product_id}).exists?
  end
end
