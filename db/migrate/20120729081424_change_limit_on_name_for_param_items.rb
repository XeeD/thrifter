class ChangeLimitOnNameForParamItems < ActiveRecord::Migration
  def up
    change_column :param_items, :name, :string, limit: 65
  end

  def down
    change_column :param_items, :name, :string, limit: 100
  end
end
