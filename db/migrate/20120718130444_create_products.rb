class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products, :force => true do |t|
      t.string :name, limit: 301
      t.string :model_name, limit: 150
      t.string :url, limit: 300

      t.integer :external_id, limit: 6
      t.string :ean_code, limit: 13, null: false

      t.text :short_description
      t.text :description

      t.integer :default_price, limit: 6
      t.integer :recommended_price, limit: 6
      t.integer :purchase_price, limit: 6
      t.integer :recycling_fee, limit: 4
      t.integer :warranty, limit: 3
      t.decimal :vat_rate, :scale => 1, :precision => 3

      t.string :state, default: :new
      t.text :admin_comment
      t.string :initial_data_source, default: :manually_added

      t.boolean :grey_import, default: false
      t.boolean :top_product, default: false

      t.timestamps

      # Associations
      t.belongs_to :brand
    end

    add_index :products, :url, unique: true

    %w(name model_name url external_id initial_data_source top_product brand_id).each do |index|
      add_index :products, index.to_sym
    end
  end
end
