def param_values_for_product(param_item_name, product)
  param_item = product.defined_param_items.find_by_name(param_item_name)
  product.param_values_for(param_item.id)
end