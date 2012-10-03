class AddRequiredColumnsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :weight, :integer, limit: 1
  end
end
