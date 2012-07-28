class CreateParamValues < ActiveRecord::Migration
  def change
    create_table :param_values, force: true do |t|
      t.string :value, limit: 200

      t.belongs_to :product
      t.belongs_to :param_item
    end

    add_index :param_values, :product_id
    add_index :param_values, :param_item_id
  end
end
