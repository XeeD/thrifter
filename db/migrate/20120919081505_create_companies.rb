class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, limit: 80, null: false
      t.string :ico, limit: 20,  null: false
      t.string :dic, limit: 20,  null: false
      t.belongs_to :customer
    end

    add_index :companies, :customer_id
  end
end
