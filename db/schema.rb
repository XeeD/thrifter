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

ActiveRecord::Schema.define(:version => 20120718130444) do

  create_table "brands", :force => true do |t|
    t.string "name",        :limit => 100
    t.string "url",         :limit => 100
    t.text   "description"
  end

  create_table "products", :force => true do |t|
    t.string   "name",                :limit => 301
    t.string   "model_name",          :limit => 150
    t.string   "url",                 :limit => 301,                                                             :null => false
    t.integer  "external_id",         :limit => 8
    t.string   "ean_code",            :limit => 13
    t.text     "short_description"
    t.text     "description"
    t.integer  "default_price",       :limit => 8
    t.integer  "recommended_price",   :limit => 8
    t.integer  "purchase_price",      :limit => 8
    t.integer  "recycling_fee"
    t.integer  "warranty",            :limit => 3
    t.decimal  "vat_rate",                           :precision => 3, :scale => 1
    t.string   "state",                                                            :default => "new"
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
  add_index "products", ["name"], :name => "index_products_on_name", :length => {"name"=>255}
  add_index "products", ["top_product"], :name => "index_products_on_top_product"
  add_index "products", ["url"], :name => "index_products_on_url", :unique => true

end
