class CreateDocumentsTable < ActiveRecord::Migration
  def change
    create_table :documents, force: true do |t|
      t.string :name, limit: 150
      t.string :url, limit: 150
      t.text   :content
      t.string :state, limit: 10, default: "visible"
      t.timestamps
    end

    add_index :documents, :name, unique: true
    add_index :documents, :url, unique: true
    add_index :documents, :state
  end
end
