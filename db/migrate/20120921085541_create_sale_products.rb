class CreateSaleProducts < ActiveRecord::Migration
  def change
    create_table :sale_products do |t|
      t.integer :evidence_number, limit: 3, null: false
      t.text    :reason_for_discount,       null: false
      t.string  :current_state, limit: 150, null: false
      t.text    :technician_review,         null: false
      t.integer :discount, limit: 3,        null: false
      t.integer :minimal_price, limit: 3
      t.boolean :sold, default: false
      t.timestamps

      t.belongs_to :product
    end
  end
end
