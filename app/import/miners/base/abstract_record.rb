#module Miners
#  class Base
#    class AbstractRecord
#      class Definition
#        #attr_reader :record_class, :xls_sheet
#
#        def initialize(record_class, xls_sheet) #&value_fetcher
#          @record_class, @xls_sheet = record_class, xls_sheet#, value_fetcher
#        end
#
#        def self.transformation(name, &transform)
#          define_method name do |definition|
#            #      column    = definition.keys.first
#            #      attribute = definition.values.first
#            #      value_fetcher = @value_fetcher
#            #
#            #      record_class.define_simple_setter(attribute)
#            #
#            #      record_class.register_extractor(xls_sheet) do |record_xls|
#            #        value = instance_exec value_fetcher.call(record_xls, column), &transform
#            #        send("#{attribute}=", value)
#            #      end
#          end
#        end
#      end
#
#      class << self
#
#
#        #def connected_resource(resource, &connector)
#        #  connected_resources << {
#        #      resource: resource,
#        #      connector: connector
#        #  }
#        #end
#        #
#        #def connected_resources
#        #  @connected_xls_sheets ||= []
#        #end
#        #
#        #def extractors
#        #  @extractors ||= []
#        #end
#        #
#        #def define_simple_setter(attribute)
#        #  setter_method = "#{attribute}="
#        #  unless self.public_instance_methods.include?(setter_method.to_sym)
#        #    define_method setter_method do |value|
#        #      self[attribute] = value
#        #    end
#        #  end
#        #end
#        #
#        #def register_extractor(file_name=:base, &block)
#        #  extractors << [file_name, block]
#        #end
#
#        def extract_columns(resource_name=:base, &definition)
#          defin = Definition.new(self, resource_name)
#          defin.instance_exec(&definition)
#        end
#
#        #def transformation(name, &transform)
#        #  define_method name do |definition|
#        #    column    = definition.keys.first
#        #          attribute = definition.values.first
#        #          value_fetcher = @value_fetcher
#        #
#        #          record_class.define_simple_setter(attribute)
#        #
#        #          record_class.register_extractor(xls_sheet) do |record_xls|
#        #            value = instance_exec value_fetcher.call(record_xls, column), &transform
#        #            send("#{attribute}=", value)
#        #          end
#        #  end
#        #end
#      end
#
#      def initialize(base_resource, additional_resources={})
#        self.resources[:base] = base_resource
#
#        #self.class.connected_resources.each do |connection|
#        #  resource = additional_resources[connection[:resource]]
#        #  resources[connection[:resource]] = connection[:connector].call(resource, self)
#        #end
#
#        #run_extractors
#      end
#
#      def run_extractors
#        self.class.extractors.each do |extractor|
#          resource_name, block = extractor
#          self.instance_exec(resources[resource_name], &block)
#        end
#      end
#
#      def resources
#        @resources ||= {}
#      end
#
#      def data
#        @data ||= {}
#      end
#
#      def []=(attribute, value)
#        data[attribute] = value
#      end
#
#      def [](attribute)
#        data[attribute]
#      end
#    end
#  end
#end