class CreateParamTemplates < ActiveRecord::Migration
  def change
    create_table :param_templates, force: true do |t|
      t.string :name, limit: 40, null: false
    end

    add_index :param_templates, :name, unique: true
  end
end
