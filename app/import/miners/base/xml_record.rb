module Miners
  class Base
    class XMLRecord
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
              xpath = definition.keys.first
              attribute = definition.values.first

              record_class.define_simple_setter(attribute)

              record_class.register_extractor do |record_xml|
                # Execute transformation in context of Record instance
                value = instance_exec record_xml.xpath(xpath).text.strip, &transform
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

          transformation :money do |value|
            value.gsub(/,/, '.').to_f.round
          end

          # VAT must be extracted before using this transformation
          # or it must be set during initialization - self[:vat] = NN
          transformation :money_plus_vat do |value|
            value.gsub(/,/, '.').to_f.round * (100 + self[:vat].to_i) / 100
          end
        end

        def extract_xpaths(&definition)
          Definition.new(self).instance_exec(&definition)
        end

        def register_extractor(&block)
          extractors << block
        end
      end

      def initialize(record_xml)
        self.class.extractors.each do |extractor|
          self.instance_exec(record_xml, &extractor)
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
