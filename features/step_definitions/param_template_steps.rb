# encoding: UTF-8

Pokud /^šablona parametrů "(.*?)" existuje$/ do |name|
  raise "param template #{name} doesn't exist" if ParamTemplate.find_by_name(name).nil?
end