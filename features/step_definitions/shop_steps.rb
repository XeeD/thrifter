Pokud /^obchod "(.*?)" existuje$/ do |name|
  Shop.find_by_name(name)
end