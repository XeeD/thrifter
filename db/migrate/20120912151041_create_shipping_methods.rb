class CreateShippingMethods < ActiveRecord::Migration
  def change
    create_table :shipping_methods, force: true do |t|
      t.string :name, limit: 100

      t.text :short_description
      t.text :description
    end
  end
end
