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
    t.string   "name",                :limit => 300
    t.string   "model_name",          :limit => 150
    t.string   "url",                 :limit => 300
    t.integer  "external_id",         :limit => 8
    t.string   "ean_code",            :limit => 13,                                                              :null => false
    t.text     "short_description"
    t.text     "description"
    t.integer  "default_price",       :limit => 8
    t.integer  "recommended_price",   :limit => 8
    t.integer  "purchase_price",      :limit => 8
    t.integer  "recycling_fee"
    t.integer  "waranty",             :limit => 3
    t.decimal  "vat_rate",                           :precision => 3, :scale => 1
    t.string   "state",                                                            :default => "new"
    t.text     "admin_comment"
    t.string   "initial_data_source",                                              :default => "manually_added"
    t.boolean  "grey_import",                                                      :default => false
    t.boolean  "top_product",                                                      :default => false
    t.datetime "created_at",                                                                                     :null => false
    t.datetime "updated_at",                                                                                     :null => false
    t.integer  "brand_id"
  end

end
