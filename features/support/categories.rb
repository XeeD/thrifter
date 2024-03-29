def category_from_path_in_shop(path, shop)
  short_names = path.split(" -> ")
  category = shop.categories.roots.find_by_short_name(short_names.shift)
  while short_name = short_names.shift
    category = category.children.find_by_short_name(short_name)
  end
  raise "category '#{path}' not found" if category.nil?
  category
end