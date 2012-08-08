module Admin::ProductCategorizationsHelper
  def assigned_shops
    shop_ids = product.categorizations.joins(:category).pluck(:shop_id).uniq
    Shop.where(id: shop_ids)
  end

  def preferred_category_in_shop(shop)
    preferred_categorization_in_shop(shop).category
  end

  def preferred_categorization_in_shop(shop)
    product.categorizations.preferred.in_shop(shop).first
  end

  def alternative_categories_in_shop(shop)
    product.alternative_categories.where(shop_id: shop.id)
  end

  def shops
    Shop.all
  end

  def disabled_categories_for_product_in_shop(shop)
    (descendants_of_assigned_categories +
        preferred_category(shop) +
        categories_with_other_param_template(shop)).flatten.uniq
  end

  def disabled_categories_preferred_categorization(categorization)
    shop = categorization.category.shop
    (descendants_of_assigned_categories + categories_with_other_param_template(shop)).flatten.uniq
  end

  def descendants_of_assigned_categories
    product.categories.map { |category| category.descendants.pluck(:id) }
  end

  def preferred_category(shop)
    product.categorizations.preferred.in_shop(shop).pluck(:category_id)
  end

  def categories_with_other_param_template(shop)
    Category.in_shop(shop).
        where(category_type: :product_list).
        where("param_template_id != ? || param_template_id IS NULL", product.param_template.id).map do |category|
      category.self_and_descendants.pluck(:id)
    end
  end
end
