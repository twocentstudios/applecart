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

ActiveRecord::Schema.define(:version => 20120916211248) do

  create_table "items", :force => true do |t|
    t.string  "name",                            :null => false
    t.string  "description"
    t.decimal "price",          :default => 0.0, :null => false
    t.decimal "cost",           :default => 0.0, :null => false
    t.string  "item_photo_uid"
    t.string  "photo_url"
  end

  create_table "order_items", :force => true do |t|
    t.integer "order_id"
    t.integer "item_id"
    t.integer "quantity", :default => 0, :null => false
  end

  add_index "order_items", ["item_id"], :name => "index_order_items_on_item_id"
  add_index "order_items", ["order_id"], :name => "index_order_items_on_order_id"

  create_table "orders", :force => true do |t|
    t.integer "user_id",                    :null => false
    t.string  "state"
    t.boolean "paid",    :default => false, :null => false
  end

  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "settings", :force => true do |t|
    t.string   "var",                       :null => false
    t.text     "value"
    t.integer  "target_id"
    t.string   "target_type", :limit => 30
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "settings", ["target_type", "target_id", "var"], :name => "index_settings_on_target_type_and_target_id_and_var", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",       :null => false
    t.string   "encrypted_password",     :default => "",       :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "name"
    t.string   "roles",                  :default => "--- []"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
