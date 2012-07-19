module CustomMatchers
  include RSpec::Rails::Matchers

  def validate_inclusion_of(field)
    #should allow_value("navigational").for(field.to_sym)
  end
end