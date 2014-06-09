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

ActiveRecord::Schema.define(version: 20140608104718) do

  create_table "case_comments", force: true do |t|
    t.integer  "case_id",                   null: false
    t.string   "who",                       null: false
    t.integer  "docter_id"
    t.text     "message"
    t.string   "image"
    t.string   "audio"
    t.boolean  "is_new",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cases", force: true do |t|
    t.integer  "patient_id", null: false
    t.integer  "docter_id"
    t.string   "name",       null: false
    t.integer  "age",        null: false
    t.string   "gender",     null: false
    t.float    "lat"
    t.float    "lag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doctors", force: true do |t|
    t.string   "name",                                null: false
    t.string   "qualifications"
    t.string   "specialisations"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "doctors", ["email"], name: "index_doctors_on_email", unique: true
  add_index "doctors", ["reset_password_token"], name: "index_doctors_on_reset_password_token", unique: true

  create_table "patient_social_accounts", force: true do |t|
    t.integer  "patient_id", null: false
    t.string   "uuid",       null: false
    t.string   "provider",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "patient_social_accounts", ["uuid", "provider"], name: "index_patient_social_accounts_on_uuid_and_provider", unique: true

  create_table "patients", force: true do |t|
    t.string   "name",                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "patients", ["email"], name: "index_patients_on_email", unique: true
  add_index "patients", ["reset_password_token"], name: "index_patients_on_reset_password_token", unique: true

end
