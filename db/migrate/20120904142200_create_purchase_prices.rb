class CreatePurchasePrices < ActiveRecord::Migration
  def change
    create_table :purchase_prices, force: true do |t|
      t.string :supplier_id
      t.string :supplier
      t.integer :price
      t.belongs_to :product
    end
  end
end
