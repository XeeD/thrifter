module Miners
  class Base
    class CSVRecord < BasicRecord
      class << self
        class Definition
          attr_reader :record_class, :csv_file

          def initialize(record_class, csv_file)
            @record_class, @csv_file = record_class, csv_file
          end

          def self.transformation(name, &transform)
            define_method name do |definition|
              column    = definition.keys.first
              attribute = definition.values.first

              if column.is_a?(String)
                column = ("a".."z").to_a.index(column.downcase)
              end

              record_class.define_simple_setter(attribute)

              record_class.register_extractor(csv_file) do |record_csv|
                value = instance_exec record_csv[column], &transform
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

        def extract_columns(csv_file=:base, &definition)
          Definition.new(self, csv_file).instance_exec(&definition)
        end

        def connect_csv_file(csv_file, &connector)
          connected_csv_files << {
              csv_file: csv_file,
              connector: connector
          }
        end

        def connected_csv_files
          @connected_csv_files ||= []
        end
      end

      def initialize(base_csv, additional_csv_files={})
        self.csv_files[:base] = base_csv

        self.class.connected_csv_files.each do |connection|
          csv = additional_csv_files[connection[:csv_file]]
          csv_files[connection[:csv_file]] = connection[:connector].call(csv, self)
        end

        run_extractors
      end

      def run_extractors
        self.class.extractors.each do |extractor|
          csv_file, block = extractor
          self.instance_exec(csv_files[csv_file], &block)
        end
      end

      def csv_files
        @csv_files ||= {}
      end
    end
  end
end