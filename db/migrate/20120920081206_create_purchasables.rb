class CreatePurchasables < ActiveRecord::Migration
  def change
    create_table :purchasables do |t|
      t.string     :goods_type, null: false
      t.belongs_to :goods,      null: false
    end

    add_index :purchasables, [:goods_type, :goods_id], unique: true
  end
end
