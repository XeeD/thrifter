class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles, force: true do |t|
      t.string :title, limit: 150
      t.string :url, limit: 150
      t.string :state, limit: 10
      t.text :content
      t.text :summary
      t.timestamps
    end

    add_index :articles, :url
    add_index :articles, :state
  end
end
