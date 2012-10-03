class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods, force: true do |t|
      t.string :name, limit: 100, null: false

      t.text   :short_description, null: false
      t.text   :description, null: false
    end
  end
end
