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

ActiveRecord::Schema.define(version: 20140411134854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "badges_sashes", force: true do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id", using: :btree
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id", using: :btree
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id", using: :btree

  create_table "bookings", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "device_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "all_day"
  end

  add_index "bookings", ["device_id"], name: "index_bookings_on_device_id", using: :btree
  add_index "bookings", ["end_time"], name: "index_bookings_on_end_time", using: :btree
  add_index "bookings", ["start_time"], name: "index_bookings_on_start_time", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "collaborations", force: true do |t|
    t.integer  "lab_id"
    t.integer  "collaborator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collaborations", ["lab_id", "collaborator_id"], name: "index_collaborations_on_lab_id_and_collaborator_id", unique: true, using: :btree

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "departments", force: true do |t|
    t.string   "name",                          null: false
    t.integer  "institute_id"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "room"
    t.integer  "users_count",       default: 0
    t.integer  "labs_count",        default: 0
    t.string   "email"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.boolean  "icon_processing"
    t.string   "linkedin_url"
    t.string   "twitter_url"
    t.string   "xing_url"
    t.string   "facebook_url"
    t.string   "google_plus_url"
    t.integer  "sash_id"
    t.integer  "level",             default: 0
    t.integer  "daily_points",      default: 0
  end

  add_index "departments", ["email"], name: "index_departments_on_email", unique: true, using: :btree
  add_index "departments", ["institute_id"], name: "index_departments_on_institute_id", using: :btree
  add_index "departments", ["name", "institute_id"], name: "index_departments_on_name_and_institute_id", unique: true, using: :btree

  create_table "devices", force: true do |t|
    t.string   "name",                                                      null: false
    t.string   "location"
    t.string   "serial"
    t.integer  "lab_id"
    t.string   "product_url"
    t.string   "uid"
    t.text     "description"
    t.decimal  "price",             precision: 9, scale: 2, default: 0.0,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status",                                    default: true
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.tsvector "tsv_body"
    t.string   "purchasing_url"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.boolean  "icon_processing"
    t.string   "currency",                                  default: "$"
    t.boolean  "shared",                                    default: false, null: false
    t.string   "state"
    t.integer  "bookings_count",                            default: 0
    t.integer  "users_count",                               default: 0
  end

  add_index "devices", ["lab_id", "name", "uid"], name: "index_devices_on_lab_id_and_name_and_uid", unique: true, using: :btree
  add_index "devices", ["lab_id"], name: "index_devices_on_lab_id", using: :btree
  add_index "devices", ["tsv_body"], name: "index_devices_on_tsv_body", using: :gin

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "institutes", force: true do |t|
    t.string   "name",                          null: false
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alternate_name"
    t.string   "url"
    t.string   "acronym"
    t.string   "slug"
    t.integer  "users_count",       default: 0
    t.integer  "labs_count",        default: 0
    t.string   "email"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.boolean  "icon_processing"
    t.string   "linkedin_url"
    t.string   "twitter_url"
    t.string   "xing_url"
    t.string   "facebook_url"
    t.string   "google_plus_url"
    t.integer  "sash_id"
    t.integer  "level",             default: 0
    t.integer  "daily_points",      default: 0
    t.string   "time_zone"
  end

  add_index "institutes", ["email"], name: "index_institutes_on_email", unique: true, using: :btree
  add_index "institutes", ["name", "address"], name: "index_institutes_on_name_and_address", unique: true, using: :btree
  add_index "institutes", ["slug"], name: "index_institutes_on_slug", unique: true, using: :btree

  create_table "labs", force: true do |t|
    t.integer  "department_id"
    t.integer  "institute_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "room"
    t.string   "url"
    t.string   "slug"
    t.string   "email"
    t.integer  "users_count",       default: 0
    t.integer  "reagents_count",    default: 0
    t.integer  "devices_count",     default: 0
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.boolean  "icon_processing"
    t.string   "linkedin_url"
    t.string   "twitter_url"
    t.string   "xing_url"
    t.string   "facebook_url"
    t.string   "google_plus_url"
    t.integer  "sash_id"
    t.integer  "level",             default: 0
    t.integer  "daily_points",      default: 0
    t.string   "state"
  end

  add_index "labs", ["department_id"], name: "index_labs_on_department_id", using: :btree
  add_index "labs", ["email"], name: "index_labs_on_email", using: :btree
  add_index "labs", ["institute_id"], name: "index_labs_on_institute_id", using: :btree

  create_table "merit_actions", force: true do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    default: false
    t.string   "target_model"
    t.integer  "target_id"
    t.boolean  "processed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: true do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: true do |t|
    t.integer  "score_id"
    t.integer  "num_points", default: 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", force: true do |t|
    t.integer "sash_id"
    t.string  "category", default: "default"
  end

  create_table "ownerships", force: true do |t|
    t.integer  "user_id"
    t.integer  "reagent_id"
    t.integer  "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ownerships", ["user_id", "device_id"], name: "index_ownerships_on_user_id_and_device_id", unique: true, using: :btree
  add_index "ownerships", ["user_id", "reagent_id"], name: "index_ownerships_on_user_id_and_reagent_id", unique: true, using: :btree

  create_table "reagents", force: true do |t|
    t.string   "name",                                                      null: false
    t.string   "location"
    t.decimal  "price",             precision: 9, scale: 2, default: 0.0,   null: false
    t.string   "serial"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lab_id"
    t.string   "product_url"
    t.date     "expiration"
    t.integer  "remaining",                                 default: 100,   null: false
    t.string   "uid"
    t.string   "lot_number"
    t.string   "quantity"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.tsvector "tsv_body"
    t.string   "purchasing_url"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.boolean  "icon_processing"
    t.string   "currency",                                  default: "$"
    t.boolean  "shared",                                    default: false, null: false
    t.text     "description"
    t.integer  "users_count",                               default: 0
  end

  add_index "reagents", ["expiration"], name: "index_reagents_on_expiration", using: :btree
  add_index "reagents", ["lab_id", "name", "uid", "description"], name: "index_reagents_on_lab_id_and_name_and_uid_and_description", unique: true, using: :btree
  add_index "reagents", ["lab_id"], name: "index_reagents_on_lab_id", using: :btree
  add_index "reagents", ["tsv_body"], name: "index_reagents_on_tsv_body", using: :gin

  create_table "sashes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

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
    t.boolean  "approved",               default: false, null: false
    t.datetime "joined"
    t.string   "slug"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "sash_id"
    t.integer  "level",                  default: 0
    t.integer  "reagents_count",         default: 0
    t.integer  "devices_count",          default: 0
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.string   "twitter_url"
    t.string   "facebook_url"
    t.string   "google_plus_url"
    t.string   "linkedin_url"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.boolean  "icon_processing"
    t.string   "xing_url"
    t.integer  "daily_points",           default: 0
    t.integer  "bookings_count",         default: 0
    t.string   "state"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["department_id"], name: "index_users_on_department_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["institute_id"], name: "index_users_on_institute_id", using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["lab_id"], name: "index_users_on_lab_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

end
