# encoding: UTF-8

class CategorizationValidator < ActiveModel::Validator
  attr_reader :model

  def validate(model)
    @model = model
    validate_constraints
  end

  def error(message)
    model.errors.add(:base, message)
  end

  def validate_constraints
    # Product can have only one preferred category in shop
    if model.preferred? and product_has_preferred_category_in_shop?
      error "Produkt #{model.product.name} již má v tomto obchodě hlavní katgorii"
    end

    # Product cannot be assigned to additional category when it has no preferred category in that shop
    unless model.preferred?
      unless product_has_preferred_category_in_shop?
        error "Produkt #{model.product.name} nemá v tomto obchodě určenou hlavní katgorii, nemůžeme jej přidat do dodatečné kategorie"
      end
    end

    # Product cannot be assigned to category with different param template
    unless category_has_the_same_param_template_as_preferred?
      error "Produkt lze přidat pouze do kategorie se stejnou šablonou parametrů, jako má jeho hlavní kategorie"
    end

    # Product cannot be assigned to navigational category
    if model.category.navigational?
      error "Produkt lze přidat pouze do kategorie se stejnou šablonou parametrů, jako má jeho hlavní kategorie"
    end

    # Product cannot be assigned to a category when it is already assigned to it's ancestor
    if assigned_to_ancestors_of_category?
      error "Produkt je již přiřazen některé nadřazené kategorii"
    end
  end

  private

  def product_has_preferred_category_in_shop?
    model.categorizations_from_same_shop.where(categorizations: {preferred: true}).exists?
  end

  def sample_preferred_category
    Categorization.where(product_id: model.product_id, preferred: true).first.category
  end

  def category_has_the_same_param_template_as_preferred?
    model.category.assigned_param_template_id == sample_preferred_category.assigned_param_template_id
  end

  def assigned_to_ancestors_of_category?
    model.category.ancestors.joins(:categorizations).where(categorizations: {product_id: model.product_id}).exists?
  end
end