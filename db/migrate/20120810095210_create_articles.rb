class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles, force: true do |t|
      t.string :name, limit: 100
      t.string :title, limit: 250
      t.string :url, limit: 100
      t.text :summary
      t.text :content
      t.timestamps
    end

    add_index :articles, :name
  end
end
