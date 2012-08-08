module Admin::ProductCategorizationsHelper
  def assigned_shops
    shop_ids = product.categorizations.joins(:category).pluck(:shop_id).uniq
    Shop.where(id: shop_ids)
  end

  def preferred_category_in_shop(shop)
    product.categorizations.preferred.in_shop(shop).first.category
  end

  def alternative_categories_in_shop(shop)
    product.alternative_categories.where(shop_id: shop.id)
  end

  def shops
    Shop.all
  end

  def disabled_categories_for_product_in_shop(shop)
    descendants_of_assigned_categories =
        product.categories.map { |category| category.descendants.pluck(:id) }

    preferred_category =
        product.categorizations.preferred.in_shop(shop).pluck(:category_id)

    categories_with_other_param_template =
        Category.in_shop(shop).
            where(category_type: :product_list).
            where("param_template_id != ? || param_template_id IS NULL", product.param_template.id).map do |category|
          category.self_and_descendants.pluck(:id)
        end

    (descendants_of_assigned_categories + preferred_category + categories_with_other_param_template).flatten.uniq
  end
end
