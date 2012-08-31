module Miners
  class Base
    class XLSRecord
      def self.define_simple_setter(attribute)
        setter_method = "#{attribute}="
        unless self.public_instance_methods.include?(setter_method.to_sym)
          define_method setter_method do |value|
            self[attribute] = value
          end
        end
      end

      class << self
        def extractors
          @extractors ||= []
        end

        class Definition
          attr_reader :record_class

          def initialize(record_class)
            @record_class = record_class
          end

          def self.transformation(name, &transform)
            define_method name do |definition|
              column    = definition.keys.first.to_i
              attribute = definition.values.first

              record_class.define_simple_setter(attribute)

              record_class.register_extractor do |record_xls|
                value = instance_exec record_xls.at(column).strip, &transform
                send("#{attribute}=", value)
              end
            end
          end

          transformation :integer do |value|
            value.to_i
          end

          transformation :string do |value|
            value
          end
        end

        def extract_columns(&definition)
          Definition.new(self).instance_exec(&definition)
        end

        def register_extractor(&block)
          extractors << [block]
        end
      end

      #def initialize(base_xls)
        #self.xls_sheets[:base] = base_xls
      #end

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