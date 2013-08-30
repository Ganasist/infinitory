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

ActiveRecord::Schema.define(version: 20130830184048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: true do |t|
    t.string   "name"
    t.integer  "institute_id"
    t.text     "address"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.boolean  "gmaps"
    t.string   "city"
    t.string   "country"
  end

  add_index "departments", ["institute_id"], name: "index_departments_on_institute_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "group_leaders", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "institute_id"
    t.integer  "department_id"
  end

  add_index "group_leaders", ["confirmation_token"], name: "index_group_leaders_on_confirmation_token", unique: true, using: :btree
  add_index "group_leaders", ["department_id"], name: "index_group_leaders_on_department_id", using: :btree
  add_index "group_leaders", ["email"], name: "index_group_leaders_on_email", unique: true, using: :btree
  add_index "group_leaders", ["institute_id"], name: "index_group_leaders_on_institute_id", using: :btree
  add_index "group_leaders", ["reset_password_token"], name: "index_group_leaders_on_reset_password_token", unique: true, using: :btree
  add_index "group_leaders", ["unlock_token"], name: "index_group_leaders_on_unlock_token", unique: true, using: :btree

  create_table "institutes", force: true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alternate_name"
    t.string   "country"
    t.integer  "rank"
    t.boolean  "gmaps"
    t.string   "url"
    t.string   "acronym"
    t.string   "slug"
    t.string   "icon"
  end

  add_index "institutes", ["latitude"], name: "index_institutes_on_latitude", using: :btree
  add_index "institutes", ["longitude"], name: "index_institutes_on_longitude", using: :btree
  add_index "institutes", ["slug"], name: "index_institutes_on_slug", unique: true, using: :btree

  create_table "labs", force: true do |t|
    t.integer  "department_id"
    t.integer  "institute_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "room"
    t.string   "email"
    t.integer  "group_leader_id"
  end

  add_index "labs", ["department_id"], name: "index_labs_on_department_id", using: :btree
  add_index "labs", ["email"], name: "index_labs_on_email", unique: true, using: :btree
  add_index "labs", ["group_leader_id"], name: "index_labs_on_group_leader_id", using: :btree
  add_index "labs", ["institute_id"], name: "index_labs_on_institute_id", using: :btree

  create_table "search_suggestions", force: true do |t|
    t.string   "term"
    t.integer  "popularity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "lab_id"
    t.boolean  "approved"
    t.boolean  "lab_manager",            default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["lab_id"], name: "index_users_on_lab_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
