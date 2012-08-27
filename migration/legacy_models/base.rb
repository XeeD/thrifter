module LegacyModels
  class Base < ActiveRecord::Base
    establish_connection :legacy_database

    self.abstract_class = true
    self.inheritance_column = "rails_sti_not_enabled"
  end
end
