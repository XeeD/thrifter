class CreateShopDocuments < ActiveRecord::Migration
  def change
    create_table :shop_documents, force: true do |t|
      t.belongs_to :shop
      t.belongs_to :document
    end

    add_index :shop_documents, [:shop_id, :document_id]
    add_index :shop_documents, [:document_id, :shop_id]
  end
end
