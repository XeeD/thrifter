# encoding: UTF-8

def dehumanize_state(model_name, state)
  Product.state_machine.states.each do |known_state|
    if I18n.t("activerecord.attributes.#{model_name}.states.#{known_state.name.to_s}").to_s == state.to_s
      return known_state.name.to_s
    end
  end

  raise "undefined state name '#{state}'"
end