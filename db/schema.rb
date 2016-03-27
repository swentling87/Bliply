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

ActiveRecord::Schema.define(version: 20160327204204) do

  create_table "interests", force: :cascade do |t|
    t.string   "topic"
    t.integer  "user_able_id"
    t.string   "user_able_type"
    t.integer  "location_able_id"
    t.string   "location_able_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "interests", ["location_able_type", "location_able_id"], name: "index_interests_on_location_able_type_and_location_able_id"
  add_index "interests", ["user_able_type", "user_able_id"], name: "index_interests_on_user_able_type_and_user_able_id"

  create_table "locations", force: :cascade do |t|
    t.integer  "zip_code"
    t.integer  "user_able_id"
    t.string   "user_able_type"
    t.integer  "interest_able_id"
    t.string   "interest_able_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "locations", ["interest_able_type", "interest_able_id"], name: "index_locations_on_interest_able_type_and_interest_able_id"
  add_index "locations", ["user_able_type", "user_able_id"], name: "index_locations_on_user_able_type_and_user_able_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "interest_id"
    t.integer  "location_id"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["interest_id"], name: "index_users_on_interest_id"
  add_index "users", ["location_id"], name: "index_users_on_location_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
