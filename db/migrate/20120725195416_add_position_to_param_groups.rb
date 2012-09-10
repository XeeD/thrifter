class AddPositionToParamGroups < ActiveRecord::Migration
  def change
    add_column :param_groups, :position, :integer, limit: 2
    add_index :param_groups, [:param_template_id, :position]
  end
end
