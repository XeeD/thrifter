class CreateDocumentsTable < ActiveRecord::Migration
  def change
    create_table :documents, force: true do |t|
      t.string :title, limit: 250
      t.string :name, limit: 70
      t.string :url, limit: 70
      t.text   :content
      t.boolean :menu_item, default: false
      t.boolean :contact_link, default: false
      t.timestamps
    end

    add_index :documents, :name, unique: true
    add_index :documents, :url,  unique: true
  end
end
