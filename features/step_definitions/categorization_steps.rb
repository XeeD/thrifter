# encoding: UTF-8

Pokud /^je produkt zařazen v (hlavní|alternativní) kategorii "(.*?)" v obchodu "(.*?)"$/ do |preferrence, category_path, shop_name|
  shop = Shop.find_by_name(shop_name)
  raise "shop '#{shop_name}' not found" if shop.nil?

  category = category_from_path_in_shop(category_path, shop)
  raise "category '#{category_path}' not found" if category.nil?

  categorization = Categorization.where(product_id: @product.id, category_id: category.id).first
  raise "product #{@product.name} is not in category '#{category_path}'" if categorization.nil?

  if preferrence == "hlavní"
    categorization.should be_preferred
  else
    categorization.should_not be_preferred
  end
end