class AddPreferredCategoryToCategorizations < ActiveRecord::Migration
  def change
    add_column :categorizations, :preferred, :boolean
  end
end
