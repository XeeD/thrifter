module Miners
  class Base
    class XMLRecord < SimpleRecord
      class << self
        class Definition < ::Miners::Base::AbstractRecord::Definition
          transformation :money do |value|
            value.gsub(/,/, '.').to_f.round
          end

          # VAT must be extracted before using this transformation
          # or it must be set during initialization - self[:vat] = NN
          transformation :money_plus_vat do |value|
            value.gsub(/,/, '.').to_f.round * (100 + self[:vat].to_i) / 100
          end
        end

        def extract_records(resource_name=:base, &definition)
          value_fetcher = ->(record, xpath) {
            record.xpath(xpath).text.strip
          }

          #super(resource_name, value_fetcher, &definition)
          Definition.new(self, resource_name, value_fetcher).instance_exec(&definition)
        end
      end
    end
  end
end
