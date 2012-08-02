class ChangeDefaultForPreferredOnCategorizations < ActiveRecord::Migration
  def up
    change_column :categorizations, :preferred, :boolean, null: false, default: false
  end

  def down
    change_column :categorizations, :preferred, :boolean, null: true, default: nil
  end
end
