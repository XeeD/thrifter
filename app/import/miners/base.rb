module Miners
  class Base

    # class methods
    class << self
      def extracts_data(*available_data)
        puts "Extractor supports: #{available_data.to_sentence}"
      end

      def upload_path(filename)
        File.join(Rails.root, "tmp/import/uploads", filename)
      end
    end

    # instance methods
    def initialize
      load_resource
    end

    def mine_data
      each do |record|
        p record.data
      end
    end

    class XMLRecord
      def self.define_simple_setter(attribute)
        define_method "#{attribute}=" do |value|
          self[attribute] = value
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

              p record_class
              record_class.define_simple_setter(attribute)

              record_class.register_extractor do |record_xml|
                value = transform.call(record_xml.xpath(xpath).text.strip)
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
            value.gsub(/,/, '.').to_f.ceil
          end

          transformation :money_plus_vat do |value|
            value.gsub(/,/, '.').to_f.ceil
          end
        end

        def extract_xpaths(&definition)
          Definition.new(self).instance_exec(&definition)
          p self.instance_methods
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
