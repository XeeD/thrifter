class CreatePackageSizes < ActiveRecord::Migration
  def change
    create_table :package_sizes, force: true do |t|
      t.integer :weight_min, limit: 2, default: 0
      t.integer :weight_max, limit: 2, null: false

      t.integer :price, limit: 2, null: false

      t.belongs_to :shipping_method, null: false
    end

    add_index :package_sizes, :shipping_method_id
  end
end
