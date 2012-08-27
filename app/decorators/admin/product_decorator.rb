# encoding: UTF-8

module Admin
  class ProductDecorator < Draper::Base
    decorates :product

    def assigned_param_values
      param_values = Product.joins(:defined_param_values).select("parametrizations.param_item_id, param_values.value")

      param_values.inject({}) do |hash, h|
        if hash.has_key?(h.param_item_id)
          unless hash[h.param_item_id].kind_of?(Array)
            hash[h.param_item_id] = [hash[h.param_item_id]]
          end
          hash[h.param_item_id] << h.value
        else
          hash[h.param_item_id] = h.value
        end

        hash
      end
    end

    def param_template
      ParamTemplateDecorator.new(model.param_template)
    end

    def available_replacements
      param_template.products.visible - [model] - model.replacements
    end

    def category_inclusions
      unless categories.empty?
        categories.collect(&:short_name).to_sentence
      else
        "nezařazen"
      end
    end
  end
end
