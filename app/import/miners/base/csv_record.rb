module Miners
  class Base
    class CSVRecord < SimpleRecord
      class << self
        class Definition < ::Miners::Base::AbstractRecord::Definition
          transformation :integer do |value|
            value.to_i
          end

          transformation :string do |value|
            value
          end

          transformation :money do |value|
            value.to_i
          end
        end

        def extract_records(resource_name=:base, &definition)
          value_fetcher = ->(record, column) {
            unless column.is_a?(Fixnum)
              column = ("a" .. "z").to_a.index(column.to_s.downcase)
            end
            record[column]
          }

          #super(resource_name, value_fetcher, &definition)
          Definition.new(self, resource_name, value_fetcher).instance_exec(&definition)
        end
      end
    end
  end
end