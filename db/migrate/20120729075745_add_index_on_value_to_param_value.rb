class AddIndexOnValueToParamValue < ActiveRecord::Migration
  def change
    add_index :param_values, :value
  end
end
