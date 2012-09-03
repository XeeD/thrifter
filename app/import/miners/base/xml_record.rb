module Miners
  class Base
    class XMLRecord < BasicRecord
      class << self
        class Definition
          attr_reader :record_class, :xml_name

          def initialize(record_class, xml_name)
            @record_class, @xml_name = record_class, xml_name
          end

          def self.transformation(name, &transform)
            define_method name do |definition|
              xpath = definition.keys.first
              attribute = definition.values.first

              record_class.define_simple_setter(attribute)

              record_class.register_extractor(xml_name) do |record_xml|
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

        def extract_xpaths(xml_name=:base, &definition)
          Definition.new(self, xml_name).instance_exec(&definition)
        end

        def connect_xml(xml_name, &connector)
          connected_xmls << {
              xml_name: xml_name,
              connector: connector
          }
        end

        def connected_xmls
          @connected_xmls ||= []
        end
      end

      def initialize(base_xml, additional_xmls={})
        self.xmls[:base] = base_xml

        run_extractors(:only_base)

        self.class.connected_xmls.each do |connection|
          xml = additional_xmls[connection[:xml_name]]
          xmls[connection[:xml_name]] = connection[:connector].call(xml, self)
        end

        run_extractors
      end

      def run_extractors(only_base=false)
        self.class.extractors.send(only_base ? :select : :reject) { |extractor|
          extractor[0] == :base
        }.each do |extractor|
          xml_name, block = extractor
          # What to do, when associated record is not found?
          next unless xmls[xml_name].present?
          self.instance_exec(xmls[xml_name], &block)
        end
      end

      def xmls
        @xmls ||= {}
      end
    end
  end
end
