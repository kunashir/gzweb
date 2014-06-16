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

  create_table "dvsys_carddefs", id: false, force: true do |t|
    t.string   "CardTypeID",  limit: nil,             null: false
    t.string   "Alias",       limit: 64
    t.integer  "Version"
    t.integer  "SysVersion"
    t.string   "LibraryID",   limit: nil
    t.string   "ControlInfo", limit: 256
    t.integer  "Options",                 default: 0
    t.integer  "FetchMode"
    t.text     "XMLSchema"
    t.text     "XSDSchema"
    t.text     "Icon"
    t.string   "SDID",        limit: nil
    t.datetime "Timestamp"
  end

  create_table "dvsys_instances", id: false, force: true do |t|
    t.string   "InstanceID",   limit: nil,                                                  null: false
    t.string   "CardTypeID",   limit: nil
    t.datetime "Timestamp"
    t.string   "Description",  limit: 512
    t.string   "SDID",         limit: nil
    t.boolean  "Deleted"
    t.boolean  "Template",                 default: false
    t.string   "TopicID",      limit: nil
    t.integer  "TopicIndex",               default: 0,                                      null: false
    t.string   "ParentID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "Order",                    default: 0,                                      null: false
    t.integer  "ArchiveState", limit: 1
  end

  create_table "dvsys_instances_date", id: false, force: true do |t|
    t.string   "InstanceID",       limit: nil, null: false
    t.datetime "Timestamp"
    t.datetime "CreationDateTime"
    t.datetime "ChangeDateTime"
  end

  create_table "dvsys_security", id: false, force: true do |t|
    t.string  "ID",           limit: nil, null: false
    t.integer "Hash"
    t.text    "SecurityDesc"
  end

  create_table "dvsys_topics", id: false, force: true do |t|
    t.string   "ID",          limit: nil, null: false
    t.datetime "Timestamp"
    t.string   "Description", limit: 512, null: false
  end

  create_table "dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                   null: false
    t.datetime "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "SDID",                 limit: nil
    t.string   "Name"
    t.integer  "Type"
    t.string   "Manager",              limit: nil
    t.string   "ContactPerson",        limit: nil
    t.string   "Phone",                limit: 64
    t.string   "Fax",                  limit: 64
    t.string   "Email",                limit: 64
    t.string   "Telex",                limit: 32
    t.string   "Account",              limit: 64
    t.string   "CorrespondentAccount", limit: 64
    t.string   "BankName",             limit: 64
    t.string   "BIK",                  limit: 128
    t.string   "INN",                  limit: 128
    t.string   "KPP",                  limit: 32
    t.string   "OKPO",                 limit: 128
    t.string   "OKONH",                limit: 128
    t.string   "RootFolder",           limit: nil
    t.string   "TaskFolder",           limit: nil
    t.string   "IncomingFolder",       limit: nil
    t.string   "OutgoingFolder",       limit: nil
    t.string   "ResolutionFolder",     limit: nil
    t.text     "Comments"
    t.string   "CalendarID",           limit: nil
    t.string   "FullName",             limit: 1024
    t.string   "SyncTag",              limit: 256
    t.boolean  "NotAvailable"
    t.string   "ADsPath",              limit: 1024
    t.string   "ADsID",                limit: 64
    t.boolean  "ADsNotSynchronize"
    t.string   "Code",                 limit: 16
  end

  create_table "dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}", id: false, force: true do |t|
    t.string   "RowID",             limit: nil,                                                   null: false
    t.datetime "SysRowTimestamp"
    t.string   "InstanceID",        limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",       limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",   limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "SDID",              limit: nil
    t.string   "FirstName",         limit: 32
    t.string   "MiddleName",        limit: 32
    t.string   "LastName",          limit: 32
    t.string   "Position",          limit: nil
    t.string   "AccountName",       limit: 128
    t.string   "Manager",           limit: nil
    t.string   "RoomNumber",        limit: 64
    t.string   "Phone",             limit: 64
    t.string   "MobilePhone",       limit: 64
    t.string   "HomePhone",         limit: 64
    t.string   "IPPhone",           limit: 64
    t.string   "Fax",               limit: 64
    t.string   "Email",             limit: 64
    t.string   "PersonalFolder",    limit: nil
    t.integer  "RoutingType"
    t.string   "IDNumber",          limit: 32
    t.string   "IDIssuedBy",        limit: 256
    t.datetime "BirthDate"
    t.string   "Comments",          limit: 1024
    t.string   "CalendarID",        limit: nil
    t.integer  "Status"
    t.boolean  "NotAvailable"
    t.integer  "Gender"
    t.string   "SyncTag",           limit: 256
    t.string   "ActiveEmployee",    limit: nil
    t.boolean  "ADsNotSynchronize"
    t.integer  "Importance"
    t.string   "AccountSID",        limit: 256
    t.string   "DisplayString",     limit: 256
    t.string   "ClockNumber",       limit: 128
    t.string   "IDCode",            limit: 128
    t.boolean  "IsDefault"
    t.boolean  "ShowAccountDialog"
    t.datetime "LockedFrom"
    t.datetime "LockedTo"
    t.string   "DuplicateID",       limit: 256
    t.integer  "UniqueEmpl"
  end

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
