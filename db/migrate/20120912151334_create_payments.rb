class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments, force: true do |t|
      t.belongs_to :order
      t.belongs_to :payment_method
    end

    add_index :payments, [:order_id, :payment_method_id]
  end
end
