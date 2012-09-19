class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders, force: true do |t|
      t.string  :number, limit: 20,    null: true
      t.string  :token, limit: 60,     null: true
      t.integer :total, limit: 3,      null: true
      t.integer :item_total, limit: 3, null: true
      t.boolean :email_confirmation, default: false
      t.string :state, limit: 15, default: "in_progress"

      t.text :admin_note,              null: true
      t.text :customer_note,           null: true

      t.belongs_to :customer

      t.datetime :completed_at,        null: true
      t.timestamps
    end

    add_index :orders, :number, unique: true
    add_index :orders, :token,  unique: true
    add_index :orders, :state
  end
end
