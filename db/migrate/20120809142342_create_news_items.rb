class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items, force: true do |t|
      t.string :title, limit: 100
      t.text :content
      t.string :link, limit: 250, null: true
      t.timestamps
      t.belongs_to :shop
    end

    add_index :news_items, :shop_id
  end
end
