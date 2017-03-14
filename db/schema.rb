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

ActiveRecord::Schema.define(version: 20170314022400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batch_requests", force: :cascade do |t|
    t.integer  "batch_id"
    t.integer  "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_id"], name: "index_batch_requests_on_batch_id", using: :btree
    t.index ["request_id"], name: "index_batch_requests_on_request_id", using: :btree
  end

  create_table "batches", force: :cascade do |t|
    t.string   "slug"
    t.integer  "team_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.json     "cloudinary_json"
  end

  create_table "receipts", force: :cascade do |t|
    t.integer  "request_item_id"
    t.string   "image"
    t.json     "cloudinary_json"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "request_items", force: :cascade do |t|
    t.integer  "request_id"
    t.string   "description"
    t.string   "category"
    t.integer  "amount"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "receipt_id"
    t.date     "paid_at"
    t.index ["request_id"], name: "index_request_items_on_request_id", using: :btree
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
    t.datetime "submitted_at"
    t.string   "token"
    t.datetime "delivered_at"
    t.index ["user_id"], name: "index_requests_on_user_id", using: :btree
  end

  create_table "signups", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.json     "oauth_response"
    t.string   "team_name"
    t.string   "team_id"
    t.string   "access_token"
    t.string   "bot_access_token"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slack_id"
    t.string   "email"
    t.string   "slack_name"
    t.integer  "team_id"
  end

  add_foreign_key "batch_requests", "batches"
  add_foreign_key "batch_requests", "requests"
  add_foreign_key "request_items", "requests"
  add_foreign_key "requests", "users"
end
