class CreatePackageSizes < ActiveRecord::Migration
  def change
    create_table :package_sizes, force: true do |t|
      t.integer :weight_min, limit: 2
      t.integer :weight_max, limit: 2

      t.integer :price, limit: 2

      t.belongs_to :shipping_method
    end

    add_index :package_sizes, :shipping_method_id
  end
end
