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

ActiveRecord::Schema.define(version: 20151105092326) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "game_version_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.string   "account",         limit: 255
    t.string   "password",        limit: 255
    t.integer  "status",          limit: 4
    t.integer  "is_valid",        limit: 4
    t.decimal  "deposit",                     precision: 10, scale: 1
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  add_index "accounts", ["game_version_id"], name: "index_accounts_on_game_version_id", using: :btree
  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "game_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "is_valid",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "game_versions", force: :cascade do |t|
    t.integer  "game_id",    limit: 4
    t.string   "version",    limit: 255
    t.string   "language",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "game_versions", ["game_id"], name: "index_game_versions_on_game_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "isHot"
    t.string   "gameType",   limit: 255
    t.string   "nickName",   limit: 255
    t.string   "developer",  limit: 255
    t.integer  "minplayer",  limit: 4
    t.integer  "maxplayer",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "lease_orders", force: :cascade do |t|
    t.integer  "game_id",         limit: 4
    t.integer  "game_version_id", limit: 4
    t.integer  "third_party_id",  limit: 4
    t.decimal  "loan_price",                  precision: 9, scale: 2
    t.datetime "loan_time"
    t.integer  "is_valid",        limit: 4
    t.integer  "pay_type",        limit: 4
    t.integer  "status",          limit: 4
    t.integer  "code",            limit: 4
    t.string   "account",         limit: 255
    t.string   "password",        limit: 255
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  add_index "lease_orders", ["game_id"], name: "index_lease_orders_on_game_id", using: :btree
  add_index "lease_orders", ["game_version_id"], name: "index_lease_orders_on_game_version_id", using: :btree
  add_index "lease_orders", ["third_party_id"], name: "index_lease_orders_on_third_party_id", using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", limit: 4,     null: false
    t.integer  "application_id",    limit: 4,     null: false
    t.string   "token",             limit: 255,   null: false
    t.integer  "expires_in",        limit: 4,     null: false
    t.text     "redirect_uri",      limit: 65535, null: false
    t.datetime "created_at",                      null: false
    t.datetime "revoked_at"
    t.string   "scopes",            limit: 255
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id", limit: 4
    t.integer  "application_id",    limit: 4
    t.string   "token",             limit: 255, null: false
    t.string   "refresh_token",     limit: 255
    t.integer  "expires_in",        limit: 4
    t.datetime "revoked_at"
    t.datetime "created_at",                    null: false
    t.string   "scopes",            limit: 255
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",         limit: 255,                null: false
    t.string   "uid",          limit: 255,                null: false
    t.string   "secret",       limit: 255,                null: false
    t.text     "redirect_uri", limit: 65535,              null: false
    t.string   "scopes",       limit: 255,   default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "refund_orders", force: :cascade do |t|
    t.integer  "third_party_id",  limit: 4
    t.string   "payment_account", limit: 255
    t.string   "mobile",          limit: 255
    t.string   "customer_name",   limit: 255
    t.string   "why",             limit: 255
    t.integer  "status",          limit: 4
    t.integer  "is_valid",        limit: 4
    t.decimal  "price",                       precision: 10, scale: 2
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  add_index "refund_orders", ["third_party_id"], name: "index_refund_orders_on_third_party_id", using: :btree

  create_table "third_parties", force: :cascade do |t|
    t.string   "party_id",   limit: 255
    t.integer  "type",       limit: 4
    t.string   "mobile",     limit: 255
    t.string   "name",       limit: 255
    t.integer  "is_valid",   limit: 4
    t.decimal  "deposit",                precision: 10, scale: 2
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "use_explains", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "detail",     limit: 255
    t.integer  "type",       limit: 4
    t.integer  "sort",       limit: 4
    t.integer  "is_valid",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: ""
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.integer  "current_sign_in_ip",     limit: 4
    t.integer  "last_sign_in_ip",        limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "username",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "accounts", "game_versions"
  add_foreign_key "accounts", "users"
  add_foreign_key "game_versions", "games"
  add_foreign_key "lease_orders", "game_versions"
  add_foreign_key "lease_orders", "games"
  add_foreign_key "lease_orders", "third_parties"
  add_foreign_key "refund_orders", "third_parties"
end
