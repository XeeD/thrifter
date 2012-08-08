# encoding: UTF-8

class CategorizationValidator < ActiveModel::Validator
  attr_reader :record

  def validate(record)
    @record = record
    validate_category and validate_constraints
  end

  def error(message)
    record.errors.add(:base, message)
  end

  def validate_category
    if record.category_id.nil?
      record.errors.add(:category, :blank)
      false
    elsif !Category.exists?(record.category_id)
      record.errors.add(:category, :invalid)
      false
    else
      true
    end
  end

  def validate_constraints
    if record.preferred? and product_has_preferred_category_in_shop?
      error "Produkt #{record.product.name} již má v tomto obchodě hlavní katgorii"
    end

    # Product cannot be assigned to additional category when it has no preferred category in that shop
    unless record.preferred?
      unless product_has_preferred_category_in_shop?
        error "Produkt #{record.product.name} nemá v tomto obchodě určenou hlavní katgorii, nemůžeme jej přidat do dodatečné kategorie"
      end
    end

    # Product cannot be assigned to category with different param template
    unless category_has_the_same_param_template_as_preferred?
      error "Produkt lze přidat pouze do kategorie se stejnou šablonou parametrů, jako má jeho hlavní kategorie"
    end

    # Product cannot be assigned to navigational category
    if record.category.navigational?
      error "Produkt lze přidat pouze do kategorie se stejnou šablonou parametrů, jako má jeho hlavní kategorie"
    end

    # Product cannot be assigned to a category when it is already assigned to it's ancestor
    if assigned_to_ancestors_of_category?
      error "Produkt je již přiřazen některé nadřazené kategorii"
    end
  end


  private

  def product_has_preferred_category_in_shop?
    record.categorizations_from_same_shop.where(categorizations: {preferred: true}).exists?
  end

  def sample_preferred_categorization
    @sample_preferred_categorization ||= Categorization.where(product_id: record.product_id, preferred: true).first
  end

  def category_has_the_same_param_template_as_preferred?
    if sample_preferred_categorization
      record.category.assigned_param_template_id == sample_preferred_categorization.category.assigned_param_template_id
    else
      # There are no preferred categories - we can choose whichever we want
      true
    end
  end

  def assigned_to_ancestors_of_category?
    record.category.ancestors.joins(:categorizations).where(categorizations: {product_id: record.product_id}).exists?
  end
end