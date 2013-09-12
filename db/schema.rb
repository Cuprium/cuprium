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

ActiveRecord::Schema.define(:version => 20130912151210) do

  create_table "accounts", :id => false, :force => true do |t|
    t.string   "number",                                       :null => false
    t.string   "owner",                                        :null => false
    t.string   "type",                                         :null => false
    t.decimal  "balance",       :precision => 14, :scale => 2, :null => false
    t.decimal  "debit_limit",   :precision => 14, :scale => 2, :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "currency_code"
    t.integer  "client_id"
  end

  add_index "accounts", ["number"], :name => "index_accounts_on_number", :unique => true

  create_table "clients", :force => true do |t|
    t.integer  "title_id",      :null => false
    t.string   "first_name",    :null => false
    t.string   "last_name",     :null => false
    t.string   "address1",      :null => false
    t.string   "address2"
    t.string   "address3"
    t.string   "town",          :null => false
    t.string   "postcode",      :null => false
    t.string   "email"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.date     "date_of_birth"
    t.string   "phone"
    t.string   "alt_phone"
  end

  create_table "currencies", :id => false, :force => true do |t|
    t.string   "code",           :null => false
    t.string   "iso_number",     :null => false
    t.string   "name",           :null => false
    t.integer  "decimal_places", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "html_code"
  end

  add_index "currencies", ["code"], :name => "index_currencies_on_code", :unique => true

  create_table "currency_conversions", :force => true do |t|
    t.string   "currency_code",                                :null => false
    t.date     "valid_from",                                   :null => false
    t.decimal  "factor",        :precision => 14, :scale => 4, :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "currency_conversions", ["currency_code", "valid_from"], :name => "index_currency_conversions_on_currency_code_and_valid_from", :unique => true

  create_table "data_managers", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "title_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "data_managers", ["email"], :name => "index_data_managers_on_email", :unique => true
  add_index "data_managers", ["reset_password_token"], :name => "index_data_managers_on_reset_password_token", :unique => true

  create_table "entries", :id => false, :force => true do |t|
    t.integer  "direction",  :null => false
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "entries", ["name"], :name => "index_entries_on_name", :unique => true

  create_table "ledger_entries", :force => true do |t|
    t.decimal  "amount",         :precision => 14, :scale => 2, :null => false
    t.string   "account_id",                                    :null => false
    t.string   "entry_id",                                      :null => false
    t.integer  "transaction_id"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "loan_products", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.integer  "loan_product_id"
    t.integer  "page"
    t.text     "text"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "display_order"
  end

  create_table "transactions", :force => true do |t|
    t.string   "activity",           :null => false
    t.integer  "from_conversion_id"
    t.integer  "to_conversion_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

end
