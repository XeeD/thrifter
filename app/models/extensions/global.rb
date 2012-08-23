module Extensions
  module Global
    extend ActiveSupport::Concern

    module ClassMethods
      def transliterate_permalink(attribute)
        setter = "#{attribute}=".to_sym

        to_url = ->(value) {
          unless value.nil?
            value.gsub(/_/, "").parameterize
          end
        }

        define_method setter do |value|
          self[attribute] = to_url.call(value)
        end

        validates attribute, format: {with: /[a-z-]/}
      end
    end
  end
end
