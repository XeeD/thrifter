class ChangeStateToNotNullInProducts < ActiveRecord::Migration
  def up
    change_column :products, :state, :string, :null => false
  end

  def down
    change_column :products, :state, :string, :null => true
  end
end
