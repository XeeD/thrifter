class CreateShippingMethods < ActiveRecord::Migration
  def change
    create_table :shipping_methods, force: true do |t|

    end
  end
end
