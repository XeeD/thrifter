class ChangeUniqueIndexOnCategories < ActiveRecord::Migration
  def up
    remove_index :categories, :url
    add_index :categories, [:shop_id, :url], unique: true
  end

  def down
    add_index :categories, :url, unique: true
    remove_index :categories, [:shop_id, :url]
  end
end
