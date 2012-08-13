class CreateCategoryArticles < ActiveRecord::Migration
  def change
    create_table :category_articles, force: true, id: false do |t|
      t.belongs_to :article
      t.belongs_to :category
    end

    add_index :category_articles, [:article_id, :category_id]
    add_index :category_articles, [:category_id, :article_id]
  end
end
