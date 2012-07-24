class AddBelongsToCategories < ActiveRecord::Migration
  def up
    add_column :categories, :param_template_id, :integer
    add_index :categories, :param_template_id
  end

  def down
    remove_index :categories, column: :param_template_id
    remove_column :categories, :param_template_id
  end
end
