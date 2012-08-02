# encoding: UTF-8

module Admin
  class ProductParamItemsController < AdminController
    def index
    end

    def create
      processor = ProductParamItemsProcessor.new(params[:product_id])
      if processor.save_params(params[:param_items])
        flash[:notice] = "Parametry produktu #{product.name} byly uloženy"
      end

      redirect_to :back
    end

    private

    def select_assigned_param_values
      param_values = Product.joins(:parametrization_param_values).select("parametrizations.param_item_id, param_values.value")

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

    def assigned_param_values
      @assigned_param_values ||= select_assigned_param_values
    end

    helper_method :assigned_param_values

    def product
      @product ||= Product.find(params[:product_id])
    end

    helper_method :product
  end
end