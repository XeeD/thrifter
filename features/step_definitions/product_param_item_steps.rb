# encoding: UTF-8

# Given statements
Pokud /^parametr "(.*?)" je přiřazen produktu$/ do |param_item_name|
  @param_item = ParamItem.find_by_name(param_item_name)
  raise "param item #{param_item_name} not found" if @param_item.blank?
  @product.param_items.should include(@param_item)
end

# When statements
Když /^zaškrtnu přepínač "(.*?)" na řádku pro vlastnost "(.*?)"$/ do |value, line_text|
  row = find_table_row_with_text(line_text)
  row.choose value.to_s
end

Když /^zaškrtnu pole "(.*?)" na řádku pro vlastnost "(.*?)"$/ do |value, line_text|
  row = find_table_row_with_text(line_text)
  row.check value.to_s
end

Když /^přidám nový přepínač "(.*?)" na řádku k vlastnosti "(.*?)"$/ do |value, line_text|
  row = find_table_row_with_text(line_text)
  within(row) do
    field = find_field "new_value"
    field.click()
    fill_in "new_value", :with => value.to_s
  end
end

# Then statements
Pak /^(?:hodnota|jedna z hodnot) parametru "(.*?)" by měla být "(.*?)"$/ do |param_item_name, value|
  raise "product's parameter #{param_item_name} has not value #{value}" unless
      @product.has_param_value?(param_item_name, value)
end

Pak /^(?:hodnota|jedna z hodnot) parametru "(.*?)" by neměla být "(.*?)"$/ do |param_item_name, value|
  raise "product's parameter #{param_item_name} has value #{value}" if
      @product.has_param_value?(param_item_name, value)
end