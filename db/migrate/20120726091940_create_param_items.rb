class CreateParamItems < ActiveRecord::Migration
  def change
    create_table :param_items, force: true do |t|
      t.string :name, limit: 100
      t.string :value_type, limit: 10
      t.string :choice_type, limit: 15
      t.string :unit, limit: 30, null: true
      t.string :importance, limit: 15

      # Associations
      t.belongs_to :param_template
      t.belongs_to :param_group, null: true
    end

    add_index :param_items, :param_template_id
    add_index :param_items, :param_group_id
    add_index :param_items, :importance
  end
end