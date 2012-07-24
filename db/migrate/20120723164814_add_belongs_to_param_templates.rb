class AddBelongsToParamTemplates < ActiveRecord::Migration
  def up
    add_column :param_templates, :category_id, :integer
    add_index :param_templates, :category_id
  end

  def down
    remove_index :param_templates, column: :category_id
    remove_column :param_templates, :category_id
  end
end
