# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_23_110452) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "keywords", force: :cascade do |t|
    t.string "key_string"
    t.bigint "website_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "lastSearch"
    t.index ["website_id"], name: "index_keywords_on_website_id"
  end

  create_table "searches", force: :cascade do |t|
    t.date "date"
    t.integer "rank"
    t.string "engine"
    t.bigint "keyword_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["keyword_id"], name: "index_searches_on_keyword_id"
  end

  create_table "user_website_shares", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "website_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_website_shares_on_user_id"
    t.index ["website_id"], name: "index_user_website_shares_on_website_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "websites", force: :cascade do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_websites_on_user_id"
  end

  add_foreign_key "keywords", "websites"
  add_foreign_key "searches", "keywords"
  add_foreign_key "user_website_shares", "users"
  add_foreign_key "user_website_shares", "websites"
  add_foreign_key "websites", "users"
end
