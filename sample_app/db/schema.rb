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

ActiveRecord::Schema.define(version: 20160618215451) do

  create_table "friendships", force: :cascade do |t|
    t.integer  "friendable_id"
    t.string   "friendable_type"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "blocker_id"
    t.integer  "status"
  end

  create_table "microposts", force: :cascade do |t|
    t.text     "caption"
    t.integer  "user_id"
    t.boolean  "ispublic"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "postpicture"
  end

  add_index "microposts", ["caption"], name: "index_microposts_on_caption"
  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
  add_index "microposts", ["user_id"], name: "index_microposts_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "firstname",       null: false
    t.string   "lastname",        null: false
    t.string   "email",           null: false
    t.string   "gender",          null: false
    t.date     "birthdate",       null: false
    t.string   "phone"
    t.string   "hometown"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "maritalstatus"
    t.text     "bio"
    t.string   "profilepicture"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["firstname"], name: "index_users_on_firstname"
  add_index "users", ["hometown"], name: "index_users_on_hometown"
  add_index "users", ["lastname"], name: "index_users_on_lastname"
  add_index "users", ["phone"], name: "index_users_on_phone", unique: true

end
