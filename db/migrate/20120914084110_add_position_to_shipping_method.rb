class AddPositionToShippingMethod < ActiveRecord::Migration
  def change
    add_column :shipping_methods, :position, :integer, limit: 1
  end
end
