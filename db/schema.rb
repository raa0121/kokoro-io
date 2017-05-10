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

ActiveRecord::Schema.define(version: 20170510154436) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "essential"
    t.index ["user_id"], name: "index_access_tokens_on_user_id", using: :btree
  end

  create_table "bots", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.string   "access_token", null: false
    t.integer  "status",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_bots_on_user_id", using: :btree
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "authority"
    t.integer  "memberable_id"
    t.string   "memberable_type"
    t.index ["memberable_id", "memberable_type"], name: "index_memberships_on_memberable_id_and_memberable_type", using: :btree
    t.index ["memberable_id"], name: "index_memberships_on_memberable_id", using: :btree
    t.index ["room_id"], name: "index_memberships_on_room_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "room_id"
    t.integer  "profile_id"
    t.text     "content"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["room_id"], name: "index_messages_on_room_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "message"
    t.boolean  "read",         default: false
    t.string   "redirect_url"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "publisher_type"
    t.integer  "publisher_id"
    t.string   "display_name"
    t.string   "screen_name"
    t.string   "avatar_id"
    t.boolean  "archived",       default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["publisher_type", "publisher_id"], name: "index_profiles_on_publisher_type_and_publisher_id", using: :btree
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "display_name", limit: 64,                  null: false
    t.string   "screen_name",  limit: 255,                 null: false
    t.boolean  "private",                  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description",                              null: false
    t.index ["display_name"], name: "index_rooms_on_display_name", unique: true, using: :btree
    t.index ["screen_name"], name: "index_rooms_on_screen_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
