# encoding: UTF-8
require 'spec_helper'

describe ProductParamItemsProcessor do
  fixtures(:products)
  fixtures(:param_values)

  let(:product) { products(:samsung_tv) }
  let(:processor) { ProductParamItemsProcessor.new(product.id) }
  let(:param_value) { param_values(:width_100) }

  def valid_product_param_items_attributes
    {
        1 => "100",
        2 => %w(BioShield BigBox)
    }
  end

  it "removes all assigned parameters to product" do
    Parametrization.should_receive(:delete_all).with(product_id: product.id)
    processor.save_params({})
  end

  it "processes nested parameters" do
    processor.should_receive(:save_param).with(1, "100")
    processor.should_receive(:save_param).with(2, "BioShield")
    processor.should_receive(:save_param).with(2, "BigBox")

    processor.save_params(valid_product_param_items_attributes)
  end

  it "saves parameter value" do
    ParamValue.stub(:find_or_create_by_value_and_param_item_id).and_return(mock_model(ParamValue))

    ParamValue.should_receive(
        :find_or_create_by_value_and_param_item_id
    ).exactly(3).times

    Parametrization.should_receive(:create).with({product_id: product.id, param_item_id: anything(), param_value_id: anything()}).exactly(3).times.and_return(true)

    processor.save_params(valid_product_param_items_attributes)
  end
end