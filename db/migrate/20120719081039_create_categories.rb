class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories, force: true do |t|
      t.string :short_name,    limit: 80
      t.string :url,           limit: 120
      t.string :plural_name,   limit: 120
      t.string :singular_name, limit: 120, null: true
      t.string :category_type, limit: 20

      # awesome_nested_set
      t.integer :lft,          limit: 3
      t.integer :rgt,          limit: 3
      t.integer :parent_id,    limit: 2
      t.integer :depth,        limit: 1

      # Associations
      t.belongs_to :shop
    end

    add_index :categories, :url, unique: true

    %w(lft rgt parent_id depth).each do |column|
      add_index :categories, column.to_sym
    end
  end
end
