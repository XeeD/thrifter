# encoding: UTF-8

module Admin
  class ProductParamItemsController < AdminController
    def index
    end

    def create
      @processor = ProductParamItemsProcessor.new(params[:product_id])
      @processor.save_params(params[:param_items])

      redirect_to :back
    end

    private

    def assigned_param_values
      @assigned_param_values ||= Product.joins("INNER JOIN parametrizations p ON p.product_id = products.id")
                                        .joins("INNER JOIN param_values pv ON pv.id = p.param_value_id")
                                        .select(%w(p.param_item_id pv.value))

      @assigned_param_values.inject({}) do |hash, h|
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

    helper_method :assigned_param_values

    def product
      @product ||= Product.includes([param_template: {param_items: [:param_values, :param_group]}])
                          .order("param_groups.position")
                          .find(params[:product_id])
    end

    helper_method :product
  end
end