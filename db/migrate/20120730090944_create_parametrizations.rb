class CreateParametrizations < ActiveRecord::Migration
  def change
    create_table :parametrizations, force: true do |t|
      t.belongs_to :product
      t.belongs_to :param_item
      t.belongs_to :param_value
    end

    add_index :parametrizations, :product_id
    add_index :parametrizations, :param_value_id
    add_index :parametrizations, :param_item_id
  end
end
