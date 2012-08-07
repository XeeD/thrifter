# encoding: UTF-8

def fill_in_new_value_input(value)
  field = find(:css, "input[class='new_value_input']")
  field.click()
  field.set(value.to_s)
end

# Given statements
Pokud /^parametr "(.*?)" je přiřazen produktu$/ do |param_item_name|
  @param_item = ParamItem.find_by_name(param_item_name)
  raise "param item #{param_item_name} not found" if @param_item.blank?
  @product.param_template.param_items.should include(@param_item)
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
    fill_in_new_value_input(value.to_s)
  end
end

Když /^přidám nové pole "(.*?)" na řádku k vlastnosti "(.*?)"$/ do |value, line_text|
  row = find_table_row_with_text(line_text)
  within(row) do
    new_fields_wrapper = first(".new_value_wrapper")
    within(new_fields_wrapper) do
      fill_in_new_value_input(value.to_s)
    end
  end
end

Když /^přidám další nové pole "(.*?)" na řádku k vlastnosti "(.*?)"$/ do |value, line_text|
  row = find_table_row_with_text(line_text)
  within(row) do
    find("span[class='add_new_field_link']").click()
    new_fields_wrapper = find(".new_value_wrapper:last-child")
    within(new_fields_wrapper) do
      fill_in_new_value_input(value.to_s)
    end
  end
end

# Then statements
Pak /^(hodnota|jedna z hodnot) parametru "(.*?)" by měla být "(.*?)"$/ do |multiplicity, param_item_name, value|
  param_values = param_values_for_product(param_item_name, @product)
  if multiplicity == "hodnota"
    param_values.length.should == 1
    param_values.first.should == value if param_values.length == 1
  else
    param_values.should include(value)
  end
end

Pak /^(hodnota|jedna z hodnot) parametru "(.*?)" by neměla být "(.*?)"$/ do |multiplicity, param_item_name, value|
  param_values = param_values_for_product(param_item_name, @product)
  if multiplicity == "hodnota"
    param_values.length.should <= 1
    param_values.first.should_not == value if param_values.length == 1
  else
    param_values.should_not include(value)
  end
end