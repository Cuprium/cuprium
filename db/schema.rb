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

ActiveRecord::Schema.define(:version => 20120327134315) do

  create_table "accounts", :id => false, :force => true do |t|
    t.string   "number",                                     :null => false
    t.string   "owner",                                      :null => false
    t.string   "type",                                       :null => false
    t.decimal  "balance",     :precision => 14, :scale => 2, :null => false
    t.decimal  "debit_limit", :precision => 14, :scale => 2, :null => false
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "accounts", ["number"], :name => "index_accounts_on_number", :unique => true

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
    t.integer  "direction"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "entries", ["name"], :name => "index_entries_on_name", :unique => true

  create_table "ledger_entries", :force => true do |t|
    t.decimal  "amount",     :precision => 14, :scale => 2, :null => false
    t.string   "account_id",                                :null => false
    t.string   "entry_id",                                  :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

end
