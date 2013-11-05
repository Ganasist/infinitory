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

ActiveRecord::Schema.define(version: 20131105134406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

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
    t.string   "room"
    t.integer  "users_count",  default: 0
    t.integer  "labs_count",   default: 0
  end

  add_index "departments", ["institute_id"], name: "index_departments_on_institute_id", using: :btree
  add_index "departments", ["latitude", "longitude"], name: "index_departments_on_latitude_and_longitude", using: :btree
  add_index "departments", ["name", "institute_id"], name: "index_departments_on_name_and_institute_id", unique: true, using: :btree

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
    t.boolean  "icon_processing"
    t.integer  "users_count",     default: 0
    t.integer  "labs_count",      default: 0
  end

  add_index "institutes", ["latitude", "longitude"], name: "index_institutes_on_latitude_and_longitude", using: :btree
  add_index "institutes", ["slug"], name: "index_institutes_on_slug", unique: true, using: :btree

  create_table "labs", force: true do |t|
    t.integer  "department_id"
    t.integer  "institute_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "room"
    t.string   "url"
    t.string   "icon"
    t.string   "slug"
    t.string   "name"
    t.string   "email"
    t.integer  "users_count",   default: 0
  end

  add_index "labs", ["department_id"], name: "index_labs_on_department_id", using: :btree
  add_index "labs", ["email"], name: "index_labs_on_email", using: :btree
  add_index "labs", ["institute_id"], name: "index_labs_on_institute_id", using: :btree
  add_index "labs", ["slug"], name: "index_labs_on_slug", unique: true, using: :btree

  create_table "reagents", force: true do |t|
    t.string   "name",                               null: false
    t.string   "category",                           null: false
    t.string   "owner",                              null: false
    t.string   "location"
    t.decimal  "price",      precision: 9, scale: 2
    t.string   "serial"
    t.decimal  "quantity",   precision: 3, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "properties"
    t.integer  "lab_id"
  end

  add_index "reagents", ["lab_id"], name: "index_reagents_on_lab_id", using: :btree
  add_index "reagents", ["properties"], name: "reagents_properties", using: :gin

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
    t.integer  "lab_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role"
    t.integer  "institute_id"
    t.integer  "department_id"
    t.boolean  "superuser",              default: false
    t.boolean  "approved",               default: false, null: false
    t.string   "icon"
    t.datetime "joined"
    t.string   "slug"
    t.boolean  "icon_processing"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["department_id"], name: "index_users_on_department_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["institute_id"], name: "index_users_on_institute_id", using: :btree
  add_index "users", ["lab_id"], name: "index_users_on_lab_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
