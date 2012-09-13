class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods, force: true do |t|
      t.string :name, limit: 100

      t.text   :short_description
      t.text   :description
    end
  end
end
