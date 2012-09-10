# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120907092545) do

  create_table "articles", :force => true do |t|
    t.string   "name",       :limit => 100
    t.string   "title",      :limit => 250
    t.string   "url",        :limit => 100
    t.text     "summary"
    t.text     "content"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "articles", ["name"], :name => "index_articles_on_name"

  create_table "brands", :force => true do |t|
    t.string "name",        :limit => 30
    t.string "url",         :limit => 30
    t.text   "description"
  end

  create_table "categories", :force => true do |t|
    t.string   "short_name",        :limit => 80
    t.string   "url",               :limit => 120
    t.string   "plural_name",       :limit => 120
    t.string   "singular_name",     :limit => 120
    t.string   "category_type",     :limit => 20
    t.integer  "lft",               :limit => 3
    t.integer  "rgt",               :limit => 3
    t.integer  "parent_id",         :limit => 2
    t.integer  "depth",             :limit => 1
    t.integer  "shop_id"
    t.integer  "param_template_id"
    t.datetime "updated_at",                       :null => false
  end

  add_index "categories", ["depth"], :name => "index_categories_on_depth"
  add_index "categories", ["lft"], :name => "index_categories_on_lft"
  add_index "categories", ["param_template_id"], :name => "index_categories_on_param_template_id"
  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"
  add_index "categories", ["rgt"], :name => "index_categories_on_rgt"
  add_index "categories", ["shop_id", "url"], :name => "index_categories_on_shop_id_and_url", :unique => true

  create_table "categorizations", :force => true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "preferred",   :default => false, :null => false
  end

  add_index "categorizations", ["category_id", "product_id"], :name => "index_categorizations_on_category_id_and_product_id", :unique => true
  add_index "categorizations", ["category_id"], :name => "index_categorizations_on_category_id"
  add_index "categorizations", ["product_id", "category_id"], :name => "index_categorizations_on_product_id_and_category_id", :unique => true
  add_index "categorizations", ["product_id"], :name => "index_categorizations_on_product_id"

  create_table "category_articles", :id => false, :force => true do |t|
    t.integer "article_id"
    t.integer "category_id"
  end

  add_index "category_articles", ["article_id", "category_id"], :name => "index_category_articles_on_article_id_and_category_id"
  add_index "category_articles", ["category_id", "article_id"], :name => "index_category_articles_on_category_id_and_article_id"

  create_table "documents", :force => true do |t|
    t.string   "title",        :limit => 250
    t.string   "name",         :limit => 70
    t.string   "url",          :limit => 70
    t.text     "content"
    t.boolean  "menu_item",                   :default => false
    t.boolean  "contact_link",                :default => false
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "documents", ["name"], :name => "index_documents_on_name", :unique => true
  add_index "documents", ["url"], :name => "index_documents_on_url", :unique => true

  create_table "news_items", :force => true do |t|
    t.string   "title",      :limit => 100
    t.text     "content"
    t.string   "link",       :limit => 250
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "shop_id"
  end

  add_index "news_items", ["shop_id"], :name => "index_news_items_on_shop_id"

  create_table "param_groups", :force => true do |t|
    t.string   "name",              :limit => 40
    t.integer  "param_template_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "position",          :limit => 2
  end

  add_index "param_groups", ["param_template_id", "position"], :name => "index_param_groups_on_param_template_id_and_position"

  create_table "param_items", :force => true do |t|
    t.string  "name",              :limit => 65
    t.string  "value_type",        :limit => 10
    t.string  "choice_type",       :limit => 15
    t.string  "unit",              :limit => 30
    t.string  "importance",        :limit => 15
    t.integer "param_template_id"
    t.integer "param_group_id"
  end

  add_index "param_items", ["importance"], :name => "index_param_items_on_importance"
  add_index "param_items", ["param_group_id"], :name => "index_param_items_on_param_group_id"
  add_index "param_items", ["param_template_id"], :name => "index_param_items_on_param_template_id"

  create_table "param_templates", :force => true do |t|
    t.string "name", :limit => 40, :null => false
  end

  add_index "param_templates", ["name"], :name => "index_param_templates_on_name", :unique => true

  create_table "param_values", :force => true do |t|
    t.string  "value",         :limit => 40
    t.integer "param_item_id"
  end

  add_index "param_values", ["param_item_id"], :name => "index_param_values_on_param_item_id"
  add_index "param_values", ["value"], :name => "index_param_values_on_value"

  create_table "parametrizations", :force => true do |t|
    t.integer "product_id"
    t.integer "param_item_id"
    t.integer "param_value_id"
  end

  add_index "parametrizations", ["param_item_id"], :name => "index_parametrizations_on_param_item_id"
  add_index "parametrizations", ["param_value_id"], :name => "index_parametrizations_on_param_value_id"
  add_index "parametrizations", ["product_id"], :name => "index_parametrizations_on_product_id"

  create_table "product_photos", :force => true do |t|
    t.string   "title",      :limit => 100
    t.string   "image"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "product_id"
    t.boolean  "main_photo",                :default => false
    t.integer  "position",   :limit => 2
  end

  add_index "product_photos", ["main_photo"], :name => "index_product_photos_on_main_photo"
  add_index "product_photos", ["product_id", "position"], :name => "index_product_photos_on_product_id_and_position"
  add_index "product_photos", ["product_id"], :name => "index_product_photos_on_product_id"

  create_table "product_replacements", :force => true do |t|
    t.integer "product_id"
    t.integer "replaced_by_id"
  end

  add_index "product_replacements", ["product_id", "replaced_by_id"], :name => "index_product_replacements_on_product_id_and_replaced_by_id"

  create_table "product_supplier_ids", :id => false, :force => true do |t|
    t.integer "product_id",                                   :null => false
    t.string  "supplier",    :limit => 20,                    :null => false
    t.string  "supplier_id", :limit => 20,                    :null => false
    t.boolean "current",                   :default => false
  end

  add_index "product_supplier_ids", ["product_id"], :name => "index_product_supplier_ids_on_product_id"
  add_index "product_supplier_ids", ["supplier_id", "supplier"], :name => "index_product_supplier_ids_on_supplier_id_and_supplier", :unique => true

  create_table "products", :force => true do |t|
    t.string   "name",                :limit => 171
    t.string   "model_name",          :limit => 140
    t.string   "url",                 :limit => 171
    t.integer  "external_id",         :limit => 3
    t.integer  "ean_code",            :limit => 8
    t.text     "short_description"
    t.text     "description"
    t.integer  "default_price",       :limit => 3
    t.integer  "recommended_price",   :limit => 3
    t.integer  "purchase_price",      :limit => 3
    t.integer  "recycling_fee",       :limit => 2
    t.integer  "warranty",            :limit => 2
    t.decimal  "vat_rate",                           :precision => 3, :scale => 1
    t.string   "state",                                                            :default => "new",            :null => false
    t.text     "admin_comment"
    t.string   "initial_data_source",                                              :default => "manually_added"
    t.boolean  "gray_import",                                                      :default => false
    t.boolean  "top_product",                                                      :default => false
    t.datetime "created_at",                                                                                     :null => false
    t.datetime "updated_at",                                                                                     :null => false
    t.integer  "brand_id"
  end

  add_index "products", ["brand_id"], :name => "index_products_on_brand_id"
  add_index "products", ["external_id"], :name => "index_products_on_external_id"
  add_index "products", ["initial_data_source"], :name => "index_products_on_initial_data_source"
  add_index "products", ["model_name"], :name => "index_products_on_model_name"
  add_index "products", ["name"], :name => "index_products_on_name"
  add_index "products", ["top_product"], :name => "index_products_on_top_product"
  add_index "products", ["url"], :name => "index_products_on_url", :unique => true

  create_table "purchase_prices", :force => true do |t|
    t.string  "supplier_id"
    t.string  "supplier",    :limit => 25
    t.integer "price",       :limit => 3
    t.integer "product_id"
  end

  create_table "shop_documents", :id => false, :force => true do |t|
    t.integer "shop_id"
    t.integer "document_id"
  end

  add_index "shop_documents", ["document_id", "shop_id"], :name => "index_shop_documents_on_document_id_and_shop_id"
  add_index "shop_documents", ["shop_id", "document_id"], :name => "index_shop_documents_on_shop_id_and_document_id"

  create_table "shops", :force => true do |t|
    t.string   "host",       :limit => 20
    t.string   "short_name", :limit => 20
    t.string   "name",       :limit => 20
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "shops", ["host"], :name => "index_shops_on_host", :unique => true
  add_index "shops", ["name"], :name => "index_shops_on_name", :unique => true

  create_table "stock_availabilities", :force => true do |t|
    t.integer  "product_id",           :null => false
    t.string   "supplier",             :null => false
    t.integer  "in_stock_count",       :null => false
    t.string   "in_stock_description", :null => false
    t.datetime "created_at",           :null => false
  end

  add_index "stock_availabilities", ["product_id"], :name => "index_stock_availabilities_on_product_id"
  add_index "stock_availabilities", ["supplier"], :name => "index_stock_availabilities_on_supplier"

  create_table "supplier_items", :force => true do |t|
    t.string "supplier_id",       :limit => 20, :null => false
    t.string "product_name",      :limit => 50, :null => false
    t.text   "record_attributes",               :null => false
    t.string "supplier",          :limit => 20, :null => false
  end

  add_index "supplier_items", ["product_name"], :name => "index_supplier_items_on_product_name"
  add_index "supplier_items", ["supplier_id", "supplier"], :name => "index_supplier_items_on_supplier_id_and_supplier", :unique => true
  add_index "supplier_items", ["supplier_id"], :name => "index_supplier_items_on_supplier_id"

end
