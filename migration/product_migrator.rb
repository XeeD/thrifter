class ProductMigrator
  class << self
    def direct_mapping(*attributes)
      attributes.each do |attribute|
        map attribute, attribute
      end
    end

    def default_values(defaults)
      @defaults = defaults
    end

    def defaults
      @defaults ||= {}
    end

    def mapping(mapping)
      mapping.each_pair do |new_attribute, legacy_attribute|
        map new_attribute, legacy_attribute
      end
    end

    def map(new_attribute, legacy_attribute)
      @mappings ||= {}

      if legacy_attribute.is_a?(Array)
        legacy_attribute_name = legacy_attribute[0]
        conversion = legacy_attribute[1]
      else
        legacy_attribute_name = legacy_attribute
        conversion = nil
      end

      @mappings[new_attribute] = {
          legacy_name: legacy_attribute_name,
          conversion: conversion
      }
    end

    attr_accessor :source_model
    attr_accessor :target_model
    attr_accessor :mappings
    attr_reader :legacy_attributes_fetched

    def source_model=(model)
      @legacy_attributes_fetched = legacy_fetched = []
      model.class_eval do
        define_method :fetch_legacy do |method, *attr|
          legacy_fetched << method unless legacy_fetched.include?(method)
          self.send(method, *attrs)
        end
      end
    end

    def not_migrated_attributes
      target_model.attribute_names - legacy_attributes_fetched
    end
  end

  [:source_model, :target_model, :defaults, :mappings].each do |class_method|
    define_method class_method do
      self.class.send(class_method)
    end
  end

  def migrate_each
    legacy_records = source_model.migration
    setup_progress_bar(name, legacy_records.length)
    legacy_records.each do |legacy_record|
      attributes = defaults.dup
      mappings.each_pair do |new_attribute, legacy_attribute|
        value = legacy_record.send(legacy_attribute[:legacy_name]) # get attribute
        if legacy_attribute[:conversion]
          value = value.send(legacy_attribute[:conversion]) # call conversion method on attribute
        end
        attributes[new_attribute] = value
      end
      attributes = additional_mapping(attributes, legacy_record)
      create_record(attributes)
      progress
    end
    @progressbar.finish
  end

  def remove_all!
    target_model.delete_all
  end

  def setup_progress_bar(title, size)
    @progressbar = ProgressBar.create(title: name, total: size, format: "|%b>>%i| %p%% %t")
  end

  def progress
    @progressbar.increment
  end

  def log_error(error, attributes)
    @logger ||= Logger.new("log/migration.log")
    @logger.error "#{self.class.name} '#{attributes[:name]}' was not migrated"
    @logger.error "#{error.message} (#{error.class.name}):"
    @logger.error attributes.inspect
    @logger.error ""
  end

  def create_record(attributes)
    target_model.create!(attributes)
  rescue
    log_error($!, attributes)
  end

  direct_mapping(
      :name,
      :warranty,
      :url
  )

  default_values(
      :vat_rate => 20
  )

  mapping(
      :brand_id => :id,
      :short_description => :summary,
      :description => :descr,
      :default_price => :base_price,
      :purchase_price => [:purchase_price, :to_i],
      :recycling_fee => :waste,
      :external_id => :external_uid
  )

  self.source_model = LegacyModels::Product
  self.target_model = Product

  def additional_mapping(attributes, product)
    brand_name = product.fetch_legacy(brand).name
    model_name = product.name.gsub(/^#{Regexp.escape(brand_name)} /, "")
    brand = Brand.where(name: brand_name).first_or_create(
        description: product.brand.descr,
        url: product.brand.url
    )

    attributes.merge(
        brand_id: brand.id,
        model_name: model_name,
        recommended_price: product.recommended_price.value
    )
  end

  def name
    self.class.name
  end
end
