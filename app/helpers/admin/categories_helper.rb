module Admin
  module CategoriesHelper
    def shop_category_path_for_form(shop, category)
      if category.new_record?
        admin_shop_categories_path(shop)
      else
        admin_shop_category_path(shop, category)
      end
    end

    def semantic_form_for_shop_category(shop, category, &block)
      path = shop_category_path_for_form(shop, category)
      semantic_form_for([:admin, shop, category], url: path, &block)
    end
  end
end