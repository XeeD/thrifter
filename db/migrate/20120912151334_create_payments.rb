class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments, force: true do |t|
      t.string :name, limit: 100, null: false
      t.text :short_description, null: false
      t.text :description, null: false
      t.belongs_to :order, null: false
      t.belongs_to :payment_method, null: false
    end

    add_index :payments, [:order_id, :payment_method_id]
  end
end
