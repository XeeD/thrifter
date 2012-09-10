class CreatePurchasePrices < ActiveRecord::Migration
  def change
    create_table :purchase_prices, force: true do |t|
      t.string :supplier_id
      t.string :supplier, limit: 25
      t.integer :price, limit: 3
      t.belongs_to :product
    end
  end
end
