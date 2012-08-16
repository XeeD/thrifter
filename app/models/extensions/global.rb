module Extensions
  module Global
    extend ActiveSupport::Concern

    module ClassMethods
      def transliterate_permalink(attribute)
        setter = "#{attribute}=".to_sym

        define_method setter do |value|
          self[attribute] = value.parameterize
        end

        validates attribute, format: {with: /[a-z-]/}
      end
    end
  end
end

ActiveRecord::Base.send(:include, Extensions::Global)