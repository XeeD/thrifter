class ChangeProductEanCode < ActiveRecord::Migration
  def up
    change_column :products, :ean_code, :integer, :null => true, limit: 8
  end

  def down
    change_column :products, :ean_code, :string, :null => true
  end
end
