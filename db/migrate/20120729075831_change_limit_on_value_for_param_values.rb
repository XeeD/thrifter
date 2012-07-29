class ChangeLimitOnValueForParamValues < ActiveRecord::Migration
  def up
    change_column :param_values, :value, :string, limit: 40
  end

  def down
    change_column :param_values, :value, :string, limit: 200
  end
end
