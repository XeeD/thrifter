module Miners
  class Base
    class XLSRecord < BasicRecord
      class << self
        class Definition
          attr_reader :record_class, :xls_sheet

          def initialize(record_class, xls_sheet)
            @record_class, @xls_sheet = record_class, xls_sheet
          end

          def self.transformation(name, &transform)
            define_method name do |definition|
              column    = definition.keys.first
              attribute = definition.values.first

              if column.is_a?(String)
                column = ("a".."z").to_a.index(column.downcase)
              end

              record_class.define_simple_setter(attribute)

              record_class.register_extractor(xls_sheet) do |record_xls|
                value = instance_exec record_xls.at(column), &transform
                send("#{attribute}=", value)
              end
            end
          end

          transformation :integer do |value|
            value.to_i
          end

          transformation :string do |value|
            value.to_s('UTF-8')
          end

          transformation :date do |value|
            value.date
          end
        end

        def extract_columns(xls_sheet=:base, &definition)
          Definition.new(self, xls_sheet).instance_exec(&definition)
        end

        def connect_xls_sheet(xls_sheet, &connector)
          connected_xls_sheets << {
              xls_sheet: xls_sheet,
              connector: connector
          }
        end

        def connected_xls_sheets
          @connected_xls_sheets ||= []
        end
      end

      def initialize(base_xls, additional_xml_sheets={})
        self.xls_sheets[:base] = base_xls

        self.class.connected_xls_sheets.each do |connection|
          xls = additional_xml_sheets[connection[:xls_sheet]]
          xls_sheets[connection[:xls_sheet]] = connection[:connector].call(xls, self)
        end

        run_extractors
      end

      def run_extractors
        self.class.extractors.each do |extractor|
          xls_sheet, block = extractor
          self.instance_exec(xls_sheets[xls_sheet], &block)
        end
      end

      def xls_sheets
        @xls_sheets ||= {}
      end
    end
  end
end