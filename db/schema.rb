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

ActiveRecord::Schema.define(version: 20140608053954) do

  create_table "admins", force: true do |t|
    t.string   "login"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "task_files", force: true do |t|
    t.string  "file_id"
    t.string  "filename"
    t.integer "task_info_id"
  end

  create_table "task_infos", force: true do |t|
    t.string   "task_id"
    t.string   "author_id"
    t.string   "author_name"
    t.string   "author_position"
    t.string   "controler_id"
    t.string   "controler_name"
    t.string   "controler_position"
    t.string   "delegated_to"
    t.string   "subject"
    t.string   "content"
    t.datetime "deadline"
    t.datetime "date"
    t.integer  "task_state"
    t.integer  "state"
    t.integer  "task_type"
    t.string   "parent_document_id"
    t.string   "parent_document"
    t.string   "folder"
    t.integer  "user_id"
  end

  add_index "task_infos", ["user_id"], name: "index_task_infos_on_user_id"

  create_table "tasks_info", force: true do |t|
    t.integer "performing"
    t.integer "performing_new"
    t.integer "to_accept"
    t.integer "to_accept_new"
    t.integer "long_tasks"
    t.integer "long_tasks_new"
    t.integer "to_approve"
    t.integer "to_approve_new"
    t.integer "to_sign"
    t.integer "to_sign_new"
    t.integer "informational"
    t.integer "informational_new"
    t.integer "issued"
    t.integer "issued_new"
    t.integer "long_issued"
    t.integer "long_issued_new"
    t.integer "delegated"
    t.integer "delegated_new"
    t.integer "overdue"
    t.integer "upcoming"
    t.integer "controlled"
    t.integer "user_id"
  end

  add_index "tasks_info", ["user_id"], name: "index_tasks_info_on_user_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "display_name"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "middle_name"
    t.string   "employee_id"
    t.string   "account_name"
  end

end
