class RemoveProductIdFromParamValues < ActiveRecord::Migration
  def up
    remove_column :param_values, :product_id
  end

  def down
    add_column :param_values, :product_id, :integer
    add_index :param_value, :product_id
  end
end
