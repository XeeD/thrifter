module Miners
  class Base
    class BasicRecord
      class << self
        def extractors
          @extractors ||= []
        end

        def define_simple_setter(attribute)
          setter_method = "#{attribute}="
          unless self.public_instance_methods.include?(setter_method.to_sym)
            define_method setter_method do |value|
              self[attribute] = value
            end
          end
        end

        def register_extractor(file_name=:base, &block)
          extractors << [file_name, block]
        end
      end

      def data
        @data ||= {}
      end

      def []=(attribute, value)
        data[attribute] = value
      end

      def [](attribute)
        data[attribute]
      end
    end
  end
end