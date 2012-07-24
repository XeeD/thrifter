class RemoveBelongsToParamTemplates < ActiveRecord::Migration
  def up
    remove_index :param_templates, column: :category_id
    remove_column :param_templates, :category_id
  end

  def down
    add_column :param_templates, :category_id, :integer
    add_index :param_templates, :category_id, unique: true
  end
end