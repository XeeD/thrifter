class ProductParamItemsProcessor

  def initialize(product_id)
    @product_id = product_id
  end

  def save_params(param_items)
    @param_items = param_items

    process_params_hash

    # Start db transaction
    ActiveRecord::Base.transaction do
      # Remove all old param connections
      Parametrization.delete_all(product_id: @product_id)

      process_params
    end
  end

  def process_params
    # Recreate new param connections
    @param_items.each do |param_id, value|
        # Single value from inputs and radio buttons
        # Array from check boxes
        [*value].each do |val|
          save_param(param_id, val)
        end
    end
  end

  def save_param(param_id, value)
    param_value = ParamValue.find_or_create_by_value_and_param_item_id(value, param_id)

    Parametrization.create(
        {
            product_id: @product_id,
            param_item_id: param_id,
            param_value_id: param_value.id
        }
    )
  end

  def process_params_hash
    # Remove blank values
    @param_items.delete_if {|key, val| val.blank? }
  end
end