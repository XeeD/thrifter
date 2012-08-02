module Admin::ParamTemplatesHelper
  def category_roots_for_shop(shop)
    Category.roots.where(shop_id: shop.id)
  end
end