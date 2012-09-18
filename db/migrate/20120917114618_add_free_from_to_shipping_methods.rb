class AddFreeFromToShippingMethods < ActiveRecord::Migration
  def change
    add_column :shipping_methods, :free_from, :integer, limit: 2
  end
end
