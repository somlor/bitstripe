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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140311044534) do

  create_table "bitcoin_addresses", force: true do |t|
    t.string   "address"
    t.integer  "user_id"
    t.integer  "destination_address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", force: true do |t|
    t.integer  "satoshi_cost"
    t.integer  "user_id"
    t.integer  "destination_address_id"
    t.integer  "forwarding_address_id"
    t.string   "auth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "callback_url"
  end

  create_table "payments", force: true do |t|
    t.integer  "satoshi_paid"
    t.integer  "invoice_id"
    t.integer  "destination_address_id"
    t.string   "destination_transaction_hash"
    t.integer  "forwarding_address_id"
    t.string   "forwarding_transaction_hash"
    t.integer  "confirmations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "session_key"
  end

end
