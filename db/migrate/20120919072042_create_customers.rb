class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers, force: true do |t|
      t.string :first_name, null: false, limit: 40
      t.string :last_name, null: false, limit: 60
      t.string :email, null: false, limit: 60
      t.string :phone, null: false, limit: 20
    end
  end
end
