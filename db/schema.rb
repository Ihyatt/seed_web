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

ActiveRecord::Schema.define(version: 20161115013940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string   "read_key",   null: false
    t.string   "write_key",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id",    null: false
    t.index ["read_key"], name: "index_api_keys_on_read_key", unique: true, using: :btree
    t.index ["user_id"], name: "index_api_keys_on_user_id", using: :btree
    t.index ["write_key"], name: "index_api_keys_on_write_key", unique: true, using: :btree
  end

  create_table "attachments", force: :cascade do |t|
    t.integer  "incident_id",  null: false
    t.string   "asset_uid"
    t.string   "asset_name"
    t.integer  "asset_width"
    t.integer  "asset_height"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["incident_id"], name: "index_attachments_on_incident_id", using: :btree
  end

  create_table "conversations", force: :cascade do |t|
    t.string   "slug",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "customer_id", null: false
    t.index ["customer_id"], name: "index_conversations_on_customer_id", unique: true, using: :btree
    t.index ["slug"], name: "index_conversations_on_slug", unique: true, using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "genders", force: :cascade do |t|
    t.string   "name",                   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "position",   default: 0, null: false
  end

  create_table "incidents", force: :cascade do |t|
    t.integer  "user_id",                     null: false
    t.string   "slug",                        null: false
    t.text     "description"
    t.datetime "start_time"
    t.string   "location"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "rating"
    t.string   "reactions",   default: [],                 array: true
    t.boolean  "completed",   default: false, null: false
    t.index ["completed"], name: "index_incidents_on_completed", using: :btree
    t.index ["reactions"], name: "index_incidents_on_reactions", using: :gin
    t.index ["slug"], name: "index_incidents_on_slug", unique: true, using: :btree
    t.index ["user_id"], name: "index_incidents_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "conversation_id", null: false
    t.integer  "user_id",         null: false
    t.text     "text"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "platform",        null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "places", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "slug",       null: false
    t.string   "short"
    t.string   "level",      null: false
    t.integer  "parent_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level"], name: "index_places_on_level", using: :btree
    t.index ["parent_id"], name: "index_places_on_parent_id", using: :btree
    t.index ["slug"], name: "index_places_on_slug", unique: true, using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title",                  null: false
    t.integer  "survey_id",              null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "position",   default: 0, null: false
    t.index ["position"], name: "index_questions_on_position", using: :btree
    t.index ["survey_id"], name: "index_questions_on_survey_id", using: :btree
  end

  create_table "races", force: :cascade do |t|
    t.string   "name",                   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "position",   default: 0, null: false
  end

  create_table "reactions", force: :cascade do |t|
    t.string   "name",                      null: false
    t.boolean  "positive",   default: true, null: false
    t.integer  "position",   default: 0,    null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["name"], name: "index_reactions_on_name", unique: true, using: :btree
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "question_id",             null: false
    t.string   "kind",                    null: false
    t.string   "value"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "position",    default: 0, null: false
    t.string   "placeholder"
    t.index ["position"], name: "index_responses_on_position", using: :btree
    t.index ["question_id"], name: "index_responses_on_question_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "surveys", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_surveys_on_user_id", using: :btree
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "uid",                                 null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "locale"
    t.string   "timezone"
    t.integer  "race_id"
    t.integer  "gender_id"
    t.date     "birthday"
    t.string   "facebook_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["facebook_id"], name: "index_users_on_facebook_id", unique: true, using: :btree
    t.index ["gender_id"], name: "index_users_on_gender_id", using: :btree
    t.index ["race_id"], name: "index_users_on_race_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid"], name: "index_users_on_uid", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  add_foreign_key "api_keys", "users"
  add_foreign_key "attachments", "incidents"
  add_foreign_key "incidents", "users"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "questions", "surveys"
  add_foreign_key "responses", "questions"
  add_foreign_key "surveys", "users"
  add_foreign_key "users", "genders"
  add_foreign_key "users", "races"
end
