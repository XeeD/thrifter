module Miners
  class Base
    class AbstractRecord
      class Definition
        attr_reader :record_class, :resource_name

        def initialize(record_class, resource_name, value_fetcher=nil)
          @record_class, @resource_name, @value_fetcher = record_class, resource_name, value_fetcher
        end

        def self.transformation(name, &transform)
          define_method name do |definition|
            column    = definition.keys.first
            attribute = definition.values.first

            record_class.define_simple_setter(attribute)

            fetcher = @value_fetcher

            record_class.register_extractor(resource_name) do |record|
              value = instance_exec fetcher.call(record, column), &transform
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

        #def extract_records(resource_name=:base, value_fetcher, &definition)
        #  Definition.new(self, resource_name, value_fetcher).instance_exec(&definition)
        #end

        def connect_resource(resource_name, &connector)
          connected_resources << {
              resource: resource_name,
              connector: connector
          }
        end

        def connected_resources
          @connected_resources ||= []
        end
      end

      def initialize(base_resource, additional_resources={})
        self.resources[:base] = base_resource

        run_extractors(:only_base)

        self.class.connected_resources.each do |connection|
          resource = additional_resources[connection[:resource]]
          resources[connection[:resource]] = connection[:connector].call(resource, self)
        end

        run_extractors
      end

      def run_extractors(only_base=false)
        self.class.extractors.send(only_base ? :select : :reject) { |extractor|
          extractor[0] == :base
        }.each do |extractor|
          resource_name, block = extractor
          # What to do, when associated resource's record is not found?
          next unless resources[resource_name].present?
          self.instance_exec(resources[resource_name], &block)
        end
      end

      def resources
        @resources ||= {}
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