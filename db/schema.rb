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

ActiveRecord::Schema.define(version: 20130808130547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: true do |t|
    t.string   "name"
    t.integer  "institute_id"
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "departments", ["institute_id"], name: "index_departments_on_institute_id", using: :btree

  create_table "institutes", force: true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alternate_name"
    t.string   "country"
    t.integer  "rank"
    t.boolean  "gmaps"
  end

  create_table "labs", force: true do |t|
    t.integer  "department_id"
    t.integer  "institute_id"
    t.string   "group_leader"
    t.string   "group_leader_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "labs", ["department_id"], name: "index_labs_on_department_id", using: :btree
  add_index "labs", ["institute_id"], name: "index_labs_on_institute_id", using: :btree

end
