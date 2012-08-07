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
end
