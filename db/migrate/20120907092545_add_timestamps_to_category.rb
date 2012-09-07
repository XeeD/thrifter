class AddTimestampsToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :updated_at, :datetime, null: false
  end
end
