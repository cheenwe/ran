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

ActiveRecord::Schema.define(version: 20151126090349) do

  create_table "login_failures", force: :cascade do |t|
    t.string   "name"
    t.string   "ip"
    t.string   "user_agent"
    t.datetime "created_at"
  end

  create_table "queries", force: :cascade do |t|
    t.string   "name"
    t.text     "filters"
    t.integer  "user_id"
    t.string   "type"
    t.boolean  "open"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_queries_on_user_id"
  end

  create_table "users", id: :binary, limit: 16, force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "password_salt"
    t.string   "encrypted_password"
    t.string   "remember_token"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "register_token"
    t.datetime "register_token_sent_at"
    t.integer  "sign_in_count"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "verified",               default: false, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["id"], name: "index_users_on_id"
    t.index ["id"], name: "sqlite_autoindex_users_1", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["phone"], name: "index_users_on_phone"
  end

end
