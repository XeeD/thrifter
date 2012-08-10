module Admin
  module NewsItemsHelper
    def shop_news_item_path_for_form(shop, news_item)
      if news_item.new_record?
        admin_shop_news_items_path(shop)
      else
        admin_shop_news_item_path(shop, news_item)
      end
    end

    def semantic_form_for_shop_news_item(shop, news_item, &block)
      path = shop_news_item_path_for_form(shop, news_item)
      semantic_form_for([:admin, shop, news_item], url: path, &block)
    end
  end
end