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

ActiveRecord::Schema.define(version: 20150224161845) do

  create_table "access_tokens", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "essential"
  end

  add_index "access_tokens", ["user_id"], name: "index_access_tokens_on_user_id"

  create_table "bots", force: true do |t|
    t.integer  "user_id"
    t.string   "access_token"
    t.string   "bot_name"
    t.string   "screen_name"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bots", ["user_id"], name: "index_bots_on_user_id"

  create_table "memberships", force: true do |t|
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "authority"
    t.integer  "memberable_id"
    t.string   "memberable_type"
  end

  add_index "memberships", ["memberable_id", "memberable_type"], name: "index_memberships_on_memberable_id_and_memberable_type"
  add_index "memberships", ["memberable_id"], name: "index_memberships_on_memberable_id"
  add_index "memberships", ["room_id"], name: "index_memberships_on_room_id"

  create_table "messages", force: true do |t|
    t.integer  "room_id"
    t.integer  "publisher_id"
    t.string   "publisher_type"
    t.text     "content"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["publisher_id", "publisher_type"], name: "index_messages_on_publisher_id_and_publisher_type"
  add_index "messages", ["room_id"], name: "index_messages_on_room_id"

  create_table "notifications", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "message"
    t.boolean  "read",         default: false
    t.string   "redirect_url"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "oauth_access_grants", force: true do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true

  create_table "oauth_access_tokens", force: true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true

  create_table "oauth_applications", force: true do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.string   "owner_type"
  end

  add_index "oauth_applications", ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type"
  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true

  create_table "rooms", force: true do |t|
    t.string   "room_name"
    t.string   "screen_name"
    t.boolean  "private"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "screen_name"
    t.string   "user_name"
    t.string   "avatar_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
