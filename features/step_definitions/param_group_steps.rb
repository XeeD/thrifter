# encoding: UTF-8

# Given statements
Pokud /^skupina parametrů "(.*?)" existuje$/ do |name|
  fail "param group #{name} doesn't exists" if ParamGroup.find_by_name(name).nil?
end

Pokud /^skupina parametrů "(.*?)" existuje a je (\d+)\. v pořadí$/ do |group_name, position|
  group = ParamGroup.find_by_name(group_name)
  group.should_not be_nil
  group.position.should == position.to_i
end

# When statements
Když /^přesunu řádek "(.*?)" o (\d+) pozic(?:i|e)? (nahoru|dolů)$/ do |name_source, distance, direction|
  simulate_drag_sortable(ParamGroup.find_by_name(name_source), distance, direction)
end

# Then statements
Pak /^skupina parametrů "(.*?)" by měla být (?:vytvořena|upravena)$/ do |param_group_name|
  find("#param_groups").should have_content("#{param_group_name}")
end

Pak /^skupina parametrů "(.*?)" by měla být smazána$/ do |param_group_name|
  begin
    find("#param_groups").should_not have_content("#{param_group_name}")
  rescue Capybara::ElementNotFound
    page.should have_selector(".empty_set")
  end
end

Pak /^bych měl vidět v tabulce Skupiny parametrů řádek "(.*?)"$/ do |text|
  page.should have_css("#param_groups", text: text)
end

Pak /^skupina "(.*?)" by měla být (\d+)\. v pořadí$/ do |group_name, position|
  ParamGroup.find_by_name(group_name).position.should == position.to_i
end