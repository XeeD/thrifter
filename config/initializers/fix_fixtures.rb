require "active_record/fixtures"
module ActiveRecord
  class Fixture
    def find
      if model_class
        model_class.unscoped.find(fixture[model_class.primary_key])
      else
        raise FixtureClassNotFound, "No class attached to find."
      end
    end
  end
end
