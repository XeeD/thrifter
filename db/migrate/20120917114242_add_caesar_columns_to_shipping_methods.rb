class AddCaesarColumnsToShippingMethods < ActiveRecord::Migration
  def change
    add_column :shipping_methods, :caesar_type_id, :string, limit: 1
    add_column :shipping_methods, :caesar_type_names, :string, limit: 30
  end
end
