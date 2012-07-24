class CreateParamGroups < ActiveRecord::Migration
  def change
    create_table :param_groups do |t|
      t.string :name, limit: 40
      t.belongs_to :param_template

      t.timestamps
    end
  end
end
