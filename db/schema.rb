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

ActiveRecord::Schema.define(version: 20140704043802) do

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

  create_table "dvrep_accounts", id: false, force: true do |t|
    t.string "Account", limit: 64, null: false
    t.string "Member",  limit: 64, null: false
  end

  create_table "dvrep_aces", id: false, force: true do |t|
    t.string  "SDID",           limit: nil, null: false
    t.string  "Account",        limit: 64,  null: false
    t.integer "PermissionType", limit: 1,   null: false
    t.integer "Mask",                       null: false
  end

  create_table "dvrep_card_rights", id: false, force: true do |t|
    t.string "CardID",   limit: nil, null: false
    t.string "CardName", limit: 256, null: false
    t.string "Account",  limit: 64,  null: false
    t.string "Read",     limit: 16,  null: false
    t.string "Write",    limit: 16,  null: false
    t.string "Delete",   limit: 16,  null: false
    t.string "Control",  limit: 16,  null: false
  end

  create_table "dvrep_folder_rights", id: false, force: true do |t|
    t.string "FolderID",   limit: nil, null: false
    t.string "FolderName", limit: 256, null: false
    t.string "Account",    limit: 64,  null: false
    t.string "Read",       limit: 16,  null: false
    t.string "Write",      limit: 16,  null: false
    t.string "Delete",     limit: 16,  null: false
    t.string "Control",    limit: 16,  null: false
  end

  create_table "dvrep_report_folders", id: false, force: true do |t|
    t.string "FolderID", limit: nil, null: false
  end

  create_table "dvrep_report_folders_cards", primary_key: "Number", force: true do |t|
    t.string "FolderID", limit: nil, null: false
    t.string "CardID",   limit: nil, null: false
  end

  create_table "dvrep_security_report", id: false, force: true do |t|
    t.string  "ReportID", limit: nil, null: false
    t.string  "SDID",     limit: nil, null: false
    t.integer "Read",     limit: 1,   null: false
    t.integer "Write",    limit: 1,   null: false
    t.integer "Delete",   limit: 1,   null: false
    t.integer "Control",  limit: 1,   null: false
  end

  create_table "dvrep_security_report_data", primary_key: "ID", force: true do |t|
    t.string  "ReportID",       limit: nil, null: false
    t.string  "SDID",           limit: nil, null: false
    t.integer "PermissionType", limit: 1,   null: false
    t.integer "Mask",                       null: false
  end

  create_table "dvsys_binaries", id: false, force: true do |t|
    t.string "ID",                limit: nil,                  null: false
    t.binary "FullTextTimeStamp",                              null: false
    t.string "Type",              limit: 10,                   null: false
    t.binary "Data",                          default: "0x00"
    t.binary "StreamData"
  end

  create_table "dvsys_binaries_archive", id: false, force: true do |t|
    t.string "ID",                limit: nil,                  null: false
    t.binary "FullTextTimeStamp",                              null: false
    t.string "Type",              limit: 10,                   null: false
    t.binary "Data",                          default: "0x00"
    t.binary "StreamData"
  end

  create_table "dvsys_card_group", id: false, force: true do |t|
    t.string  "GroupID",       limit: nil,             null: false
    t.string  "InstanceID",    limit: nil,             null: false
    t.string  "SourceCardID",  limit: nil,             null: false
    t.string  "NewInstanceID", limit: nil
    t.string  "CardTypeID",    limit: nil
    t.integer "Err",                       default: 0, null: false
  end

  create_table "dvsys_carddefs", id: false, force: true do |t|
    t.string  "CardTypeID",  limit: nil,             null: false
    t.string  "Alias",       limit: 64
    t.integer "Version"
    t.integer "SysVersion"
    t.string  "LibraryID",   limit: nil
    t.string  "ControlInfo", limit: 256
    t.integer "Options",                 default: 0
    t.integer "FetchMode"
    t.text    "XMLSchema"
    t.text    "XSDSchema"
    t.text    "Icon"
    t.string  "SDID",        limit: nil
    t.binary  "Timestamp",                           null: false
  end

  create_table "dvsys_crypto", id: false, force: true do |t|
    t.string   "CryptoID",        limit: nil, null: false
    t.binary   "Timestamp",                   null: false
    t.string   "ID",              limit: nil, null: false
    t.string   "UserID",          limit: nil, null: false
    t.string   "RepresentUserID", limit: nil
    t.datetime "CreationDate"
    t.integer  "DataType",        limit: 1,   null: false
    t.string   "CertThumbprint",  limit: 64
    t.binary   "Data"
    t.string   "Description",     limit: 256
  end

  add_index "dvsys_crypto", ["ID", "UserID", "RepresentUserID", "DataType", "CertThumbprint"], name: "dvsys_crypto_uni_id_userid_representuserid_datatype_certthumbprint", unique: true

  create_table "dvsys_fielddefs", id: false, force: true do |t|
    t.string  "FieldID",       limit: nil, null: false
    t.string  "Alias",         limit: 64
    t.string  "SectionTypeID", limit: nil, null: false
    t.integer "LinkType",      limit: 1
  end

  add_index "dvsys_fielddefs", ["LinkType"], name: "dvsys_fielddefs_idx_linktype"

  create_table "dvsys_file_group", id: false, force: true do |t|
    t.string  "GroupID", limit: nil,             null: false
    t.string  "FileID",  limit: nil,             null: false
    t.integer "Err",                 default: 0, null: false
  end

  create_table "dvsys_files", id: false, force: true do |t|
    t.string   "FileID",          limit: nil, null: false
    t.binary   "Timestamp",                   null: false
    t.string   "OwnerCardID",     limit: nil
    t.string   "Name",            limit: 256
    t.datetime "DateTime"
    t.datetime "LastChanged"
    t.integer  "StandardAttribs"
    t.integer  "ExtendedAttribs"
    t.string   "BinaryID",        limit: nil
    t.string   "SDID",            limit: nil
    t.boolean  "Deleted"
    t.integer  "OfflineState",    limit: 1
    t.integer  "ArchiveState",    limit: 1
    t.integer  "StorageState",    limit: 1,   null: false
  end

  add_index "dvsys_files", ["BinaryID"], name: "dvsys_files_idx_binaryid"
  add_index "dvsys_files", ["OwnerCardID"], name: "dvsys_files_idx_ownercardid"

  create_table "dvsys_files_archive", id: false, force: true do |t|
    t.string   "FileID",          limit: nil, null: false
    t.binary   "Timestamp",                   null: false
    t.string   "OwnerCardID",     limit: nil
    t.string   "Name",            limit: 256
    t.datetime "DateTime"
    t.datetime "LastChanged"
    t.integer  "StandardAttribs"
    t.integer  "ExtendedAttribs"
    t.string   "BinaryID",        limit: nil
    t.string   "SDID",            limit: nil
    t.boolean  "Deleted"
    t.integer  "OfflineState",    limit: 1
    t.integer  "ArchiveState",    limit: 1
    t.integer  "StorageState",    limit: 1,   null: false
  end

  add_index "dvsys_files_archive", ["BinaryID"], name: "dvsys_files_archive_idx_binaryid"
  add_index "dvsys_files_archive", ["OwnerCardID"], name: "dvsys_files_archive_idx_ownercardid"

  create_table "dvsys_globalinfo", primary_key: "ID", force: true do |t|
    t.text     "SecuritySchema"
    t.integer  "LCID"
    t.boolean  "FullTextEnabled",               default: false
    t.integer  "Version"
    t.integer  "LogStrategy"
    t.integer  "ClearLogStrategy"
    t.integer  "ClearLogCutCount"
    t.integer  "ClearLogCutDays"
    t.integer  "LogBackupFileNumber"
    t.string   "LogBackupDir"
    t.boolean  "Disabled"
    t.string   "OfflineFilesDir"
    t.integer  "ArchiveState",        limit: 1,                 null: false
    t.integer  "PurgeDeleted"
    t.integer  "ReplState",           limit: 1,                 null: false
    t.datetime "UpdateDate"
    t.integer  "SessionTTL",                                    null: false
    t.integer  "FileStorage",         limit: 1,                 null: false
    t.integer  "MinStreamSize",                                 null: false
    t.string   "StreamFileTypes",                               null: false
    t.boolean  "ReadOnly",                                      null: false
  end

  create_table "dvsys_installers", id: false, force: true do |t|
    t.string  "ID",               limit: nil, null: false
    t.string  "LibraryID",        limit: nil
    t.string  "MsiProductCode",   limit: nil
    t.string  "MsiPackageName",   limit: 64
    t.string  "MsiPatchCode",     limit: nil
    t.string  "MsiPatchName",     limit: 64
    t.string  "MsiTransformName", limit: 64
    t.boolean "AllUsers"
    t.integer "Flags"
    t.string  "AccessID",         limit: nil
  end

  create_table "dvsys_instances", id: false, force: true do |t|
    t.string  "InstanceID",   limit: nil,                                                  null: false
    t.binary  "Timestamp",                                                                 null: false
    t.string  "CardTypeID",   limit: nil
    t.string  "Description",  limit: 512
    t.string  "SDID",         limit: nil
    t.boolean "Deleted"
    t.boolean "Template",                 default: false
    t.string  "TopicID",      limit: nil
    t.integer "TopicIndex",               default: 0,                                      null: false
    t.string  "ParentID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order",                    default: 0,                                      null: false
    t.integer "ArchiveState", limit: 1
  end

  add_index "dvsys_instances", ["CardTypeID"], name: "dvsys_instances_idx_cardtypeid"
  add_index "dvsys_instances", ["ParentID", "Order"], name: "dvsys_instances_idx_parentid_order"
  add_index "dvsys_instances", ["TopicID"], name: "dvsys_instances_idx_topicid"

  create_table "dvsys_instances_archive", id: false, force: true do |t|
    t.string  "InstanceID",   limit: nil,                                                  null: false
    t.binary  "Timestamp",                                                                 null: false
    t.string  "CardTypeID",   limit: nil
    t.string  "Description",  limit: 512
    t.string  "SDID",         limit: nil
    t.boolean "Deleted"
    t.boolean "Template",                 default: false
    t.string  "TopicID",      limit: nil
    t.integer "TopicIndex",               default: 0,                                      null: false
    t.string  "ParentID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order",                    default: 0,                                      null: false
    t.integer "ArchiveState", limit: 1,                                                    null: false
  end

  add_index "dvsys_instances_archive", ["CardTypeID"], name: "dvsys_instances_archive_idx_cardtypeid"
  add_index "dvsys_instances_archive", ["ParentID", "Order"], name: "dvsys_instances_archive_idx_parentid_order"
  add_index "dvsys_instances_archive", ["TopicID"], name: "dvsys_instances_archive_idx_topicid"

  create_table "dvsys_instances_date", id: false, force: true do |t|
    t.string   "InstanceID",       limit: nil, null: false
    t.binary   "Timestamp",                    null: false
    t.datetime "CreationDateTime"
    t.datetime "ChangeDateTime"
  end

  add_index "dvsys_instances_date", ["CreationDateTime"], name: "dvsys_instances_date_idx_creationdatetime"

  create_table "dvsys_instances_read", id: false, force: true do |t|
    t.string "InstanceID", limit: nil, null: false
    t.string "UserID",     limit: nil, null: false
  end

  create_table "dvsys_keys", id: false, force: true do |t|
    t.string "ID", limit: nil, null: false
  end

  create_table "dvsys_keyset_cursor_info", id: false, force: true do |t|
    t.string  "CursorID",        limit: nil, null: false
    t.string  "SessionID",       limit: nil, null: false
    t.string  "ProcName",        limit: 128, null: false
    t.string  "KeysetTableName", limit: 128, null: false
    t.integer "PageSize"
    t.boolean "UseRank"
    t.string  "DeleteProcName",  limit: 128, null: false
  end

  create_table "dvsys_keyset_sortings", primary_key: "ID", force: true do |t|
    t.string "ViewID",        limit: nil,  null: false
    t.string "SortingName",   limit: 2000, null: false
    t.text   "SortingXML",                 null: false
    t.string "SortingViewID", limit: nil,  null: false
  end

  add_index "dvsys_keyset_sortings", ["SortingViewID"], name: "dvsys_keyset_sortings_idx_sortingviewid"
  add_index "dvsys_keyset_sortings", ["ViewID", "SortingName"], name: "dvsys_keyset_sortings_idx_viewid_sortingname"

  create_table "dvsys_libraries", id: false, force: true do |t|
    t.string  "ID",               limit: nil, null: false
    t.string  "Alias",            limit: 64
    t.integer "Version"
    t.integer "SysVersion"
    t.string  "ControlInfo",      limit: 256
    t.text    "Definition"
    t.text    "Icon"
    t.string  "MsiProductCode",   limit: nil
    t.string  "MsiPackageName",   limit: 64
    t.string  "MsiPatchCode",     limit: nil
    t.string  "MsiPatchName",     limit: 64
    t.string  "MsiTransformName", limit: 64
  end

  create_table "dvsys_links", id: false, force: true do |t|
    t.string  "RowID",             limit: nil, null: false
    t.string  "FieldID",           limit: nil, null: false
    t.string  "RowGuid",           limit: nil, null: false
    t.binary  "Timestamp",                     null: false
    t.string  "SourceCardID",      limit: nil, null: false
    t.string  "DestinationCardID", limit: nil, null: false
    t.integer "Type",              limit: 1,   null: false
  end

  add_index "dvsys_links", ["DestinationCardID", "Type"], name: "dvsys_links_idx_destinationcardid_type"
  add_index "dvsys_links", ["SourceCardID", "Type"], name: "dvsys_links_idx_sourcecardid_type"

  create_table "dvsys_locks", id: false, force: true do |t|
    t.string  "ResourceID",    limit: nil, null: false
    t.string  "LockOwnerID",   limit: nil, null: false
    t.boolean "LockType",                  null: false
    t.integer "ResourceType",  limit: 1,   null: false
    t.string  "SessionID",     limit: nil
    t.string  "SectionTypeID", limit: nil
    t.string  "InstanceID",    limit: nil
  end

  add_index "dvsys_locks", ["InstanceID", "LockOwnerID"], name: "dvsys_locks_idx_instanceid_lockownerid"

  create_table "dvsys_log", primary_key: "ID", force: true do |t|
    t.string   "UserID",          limit: nil,  null: false
    t.string   "EmployeeID",      limit: nil
    t.string   "ComputerName",    limit: 32
    t.string   "ComputerAddress", limit: 15
    t.datetime "Date",                         null: false
    t.integer  "Type",                         null: false
    t.string   "OperationID",     limit: nil,  null: false
    t.integer  "Code",                         null: false
    t.string   "TypeID",          limit: nil
    t.string   "ResourceID",      limit: nil
    t.string   "ParentID",        limit: nil
    t.string   "NewResourceID",   limit: nil
    t.string   "ResourceName",    limit: 1024
    t.text     "Data"
  end

  add_index "dvsys_log", ["Date"], name: "dvsys_log_idx_date"

  create_table "dvsys_log_application", primary_key: "ID", force: true do |t|
    t.string   "UserID",          limit: nil,  null: false
    t.string   "EmployeeID",      limit: nil
    t.string   "ComputerName",    limit: 32
    t.string   "ComputerAddress", limit: 15
    t.datetime "Date",                         null: false
    t.integer  "Type",                         null: false
    t.string   "OperationID",     limit: nil,  null: false
    t.integer  "Code",                         null: false
    t.string   "TypeID",          limit: nil
    t.string   "ResourceID",      limit: nil
    t.string   "ParentID",        limit: nil
    t.string   "NewResourceID",   limit: nil
    t.string   "ResourceName",    limit: 1024
    t.text     "Data"
  end

  add_index "dvsys_log_application", ["Date"], name: "dvsys_log_application_idx_date"

  create_table "dvsys_log_application_backup", primary_key: "ID", force: true do |t|
    t.string   "UserID",          limit: nil,  null: false
    t.string   "EmployeeID",      limit: nil
    t.string   "ComputerName",    limit: 32
    t.string   "ComputerAddress", limit: 15
    t.datetime "Date",                         null: false
    t.integer  "Type",                         null: false
    t.string   "OperationID",     limit: nil,  null: false
    t.integer  "Code",                         null: false
    t.string   "TypeID",          limit: nil
    t.string   "ResourceID",      limit: nil
    t.string   "ParentID",        limit: nil
    t.string   "NewResourceID",   limit: nil
    t.string   "ResourceName",    limit: 1024
    t.text     "Data"
  end

  add_index "dvsys_log_application_backup", ["Date"], name: "dvsys_log_application_backup_idx_date"

  create_table "dvsys_log_backup", primary_key: "ID", force: true do |t|
    t.string   "UserID",          limit: nil,  null: false
    t.string   "EmployeeID",      limit: nil
    t.string   "ComputerName",    limit: 32
    t.string   "ComputerAddress", limit: 15
    t.datetime "Date",                         null: false
    t.integer  "Type",                         null: false
    t.string   "OperationID",     limit: nil,  null: false
    t.integer  "Code",                         null: false
    t.string   "TypeID",          limit: nil
    t.string   "ResourceID",      limit: nil
    t.string   "ParentID",        limit: nil
    t.string   "NewResourceID",   limit: nil
    t.string   "ResourceName",    limit: 1024
    t.text     "Data"
  end

  add_index "dvsys_log_backup", ["Date"], name: "dvsys_log_backup_idx_date"

  create_table "dvsys_log_security", primary_key: "ID", force: true do |t|
    t.string   "UserID",          limit: nil
    t.string   "EmployeeID",      limit: nil
    t.string   "ComputerName",    limit: 32
    t.string   "ComputerAddress", limit: 15
    t.datetime "Date",                        null: false
    t.string   "OperationID",     limit: nil, null: false
    t.integer  "Status",          limit: 1,   null: false
    t.integer  "DesiredAccess",               null: false
    t.integer  "ObjectType",      limit: 1,   null: false
    t.string   "ObjectID",        limit: nil, null: false
    t.string   "LocationID",      limit: nil
    t.string   "PropertyID",      limit: nil
    t.text     "Data"
  end

  add_index "dvsys_log_security", ["Date"], name: "dvsys_log_security_idx_date"

  create_table "dvsys_log_security_backup", primary_key: "ID", force: true do |t|
    t.string   "UserID",          limit: nil
    t.string   "EmployeeID",      limit: nil
    t.string   "ComputerName",    limit: 32
    t.string   "ComputerAddress", limit: 15
    t.datetime "Date",                        null: false
    t.string   "OperationID",     limit: nil, null: false
    t.integer  "Status",          limit: 1,   null: false
    t.integer  "DesiredAccess",               null: false
    t.integer  "ObjectType",      limit: 1,   null: false
    t.string   "ObjectID",        limit: nil, null: false
    t.string   "LocationID",      limit: nil
    t.string   "PropertyID",      limit: nil
    t.text     "Data"
  end

  add_index "dvsys_log_security_backup", ["Date"], name: "dvsys_log_security_backup_idx_date"

  create_table "dvsys_pending_operations", id: false, force: true do |t|
    t.string  "ID",         limit: nil, null: false
    t.string  "ResourceID", limit: nil, null: false
    t.integer "Operation",  limit: 1,   null: false
  end

  add_index "dvsys_pending_operations", ["ResourceID"], name: "dvsys_pending_operations_idx_resourceid", unique: true

  create_table "dvsys_privileged_users", id: false, force: true do |t|
    t.string "UserID", limit: nil, null: false
  end

  create_table "dvsys_reports", id: false, force: true do |t|
    t.string "ID",         limit: nil,  null: false
    t.string "Alias",      limit: 64
    t.string "Parameters", limit: 2048
    t.string "SDID",       limit: nil
  end

  create_table "dvsys_search_ft_cards", primary_key: "ID", force: true do |t|
    t.binary "Timestamp",              null: false
    t.text   "Text"
    t.string "InstanceID", limit: nil, null: false
  end

  add_index "dvsys_search_ft_cards", ["InstanceID"], name: "dvsys_search_ft_cards_idx_instanceid"
  add_index "dvsys_search_ft_cards", ["InstanceID"], name: "dvsys_search_ft_cards_uni_instanceid", unique: true

  create_table "dvsys_search_ft_rows", primary_key: "ID", force: true do |t|
    t.binary "Timestamp",              null: false
    t.text   "Text"
    t.string "InstanceID", limit: nil, null: false
    t.string "PrimaryKey", limit: nil, null: false
    t.string "FieldID",    limit: nil, null: false
  end

  add_index "dvsys_search_ft_rows", ["InstanceID"], name: "dvsys_search_ft_rows_idx_instanceid"

  create_table "dvsys_search_ft_sections", id: false, force: true do |t|
    t.string "SectionID", limit: nil, null: false
  end

  create_table "dvsys_search_ft_tables", primary_key: "ID", force: true do |t|
    t.integer "Type",             null: false
    t.string  "Name", limit: 128, null: false
    t.integer "LCID",             null: false
  end

  create_table "dvsys_search_results", primary_key: "ID", force: true do |t|
    t.string "ParentID",  limit: nil, null: false
    t.string "SessionID", limit: nil, null: false
  end

  add_index "dvsys_search_results", ["SessionID", "ParentID"], name: "dvsys_search_results_idx_sessionid_parentid"

  create_table "dvsys_search_results_data", id: false, force: true do |t|
    t.integer "ResultID",             null: false
    t.string  "CardID",   limit: nil, null: false
    t.integer "Rank",     limit: 2
  end

  add_index "dvsys_search_results_data", ["ResultID"], name: "dvsys_search_results_data_idx_resultid"

  create_table "dvsys_section_timestamp", id: false, force: true do |t|
    t.string  "ID",              limit: nil, null: false
    t.string  "SectionTypeID",   limit: nil, null: false
    t.string  "ParentRowID",     limit: nil, null: false
    t.string  "ParentTreeRowID", limit: nil, null: false
    t.string  "InstanceID",      limit: nil, null: false
    t.boolean "Dummy"
    t.binary  "SysRowTimestamp",             null: false
  end

  add_index "dvsys_section_timestamp", ["InstanceID"], name: "dvsys_section_timestamp_idx_instanceid"
  add_index "dvsys_section_timestamp", ["ParentRowID"], name: "dvsys_section_timestamp_idx_parentrowid"
  add_index "dvsys_section_timestamp", ["ParentTreeRowID"], name: "dvsys_section_timestamp_idx_parenttreerowid"

  create_table "dvsys_sectiondefs", id: false, force: true do |t|
    t.string  "SectionTypeID",   limit: nil,             null: false
    t.string  "Alias",           limit: 64
    t.string  "ParentSectionID", limit: nil,             null: false
    t.string  "CardTypeID",      limit: nil,             null: false
    t.integer "SecurityType",    limit: 1,   default: 1, null: false
    t.boolean "UserDependent"
    t.integer "NestLevel",       limit: 1
  end

  add_index "dvsys_sectiondefs", ["SectionTypeID", "ParentSectionID", "CardTypeID"], name: "dvsys_sectiondefs_uni_sectiontypeid_parentsectionid_cardtypeid", unique: true

  create_table "dvsys_security", id: false, force: true do |t|
    t.string  "ID",           limit: nil, null: false
    t.integer "Hash"
    t.text    "SecurityDesc"
  end

  add_index "dvsys_security", ["Hash"], name: "dvsys_security_idx_hash"

  create_table "dvsys_session_files", id: false, force: true do |t|
    t.string  "ObjID",    limit: nil,  null: false
    t.string  "FileID",   limit: nil,  null: false
    t.string  "BinaryID", limit: nil,  null: false
    t.integer "Length",   limit: 8,    null: false
    t.string  "Path",     limit: 3000
  end

  create_table "dvsys_session_objects", id: false, force: true do |t|
    t.string  "ID",        limit: nil, null: false
    t.integer "Type",                  null: false
    t.string  "SessionID", limit: nil, null: false
    t.integer "Flags",                 null: false
    t.integer "Misc",      limit: 8,   null: false
  end

  add_index "dvsys_session_objects", ["SessionID"], name: "dvsys_session_objects_idx_sessionid"

  create_table "dvsys_sessions", id: false, force: true do |t|
    t.string   "SessionID",       limit: nil, null: false
    t.string   "UserID",          limit: nil, null: false
    t.string   "AppID",           limit: nil, null: false
    t.integer  "LocaleID",                    null: false
    t.datetime "LoginTime",                   null: false
    t.datetime "LastAccessTime",              null: false
    t.string   "ComputerName",    limit: 32,  null: false
    t.string   "ComputerAddress", limit: 15,  null: false
    t.integer  "ClientVersion",               null: false
    t.string   "ServerName",      limit: 32,  null: false
  end

  create_table "dvsys_strings", id: false, force: true do |t|
    t.string  "ResourceID",     limit: nil,             null: false
    t.integer "LocaleID",                               null: false
    t.integer "ResourceNumber",             default: 0, null: false
    t.string  "ParentID",       limit: nil
    t.string  "String",         limit: 512
    t.string  "RowGuid",        limit: nil,             null: false
    t.binary  "Timestamp",                              null: false
  end

  create_table "dvsys_topics", id: false, force: true do |t|
    t.string "ID",          limit: nil, null: false
    t.binary "Timestamp",               null: false
    t.string "Description", limit: 512, null: false
  end

  create_table "dvsys_transforms", id: false, force: true do |t|
    t.string  "ID",            limit: nil, null: false
    t.string  "Alias",         limit: 64
    t.integer "TransformType"
    t.integer "ContentType"
    t.integer "LocaleID"
    t.boolean "Default"
    t.string  "CardTypeID",    limit: nil
    t.text    "Data"
  end

  create_table "dvsys_users", id: false, force: true do |t|
    t.string "UserID",      limit: nil, null: false
    t.binary "Timestamp",               null: false
    t.string "AccountName", limit: 64,  null: false
    t.string "UserRefID",   limit: nil
    t.string "SID",         limit: 128, null: false
  end

  add_index "dvsys_users", ["AccountName"], name: "dvsys_users_uni_accountname", unique: true

  create_table "dvsys_workflow_services", id: false, force: true do |t|
    t.string   "ServiceID",       limit: 50,  null: false
    t.integer  "WorkPart"
    t.integer  "State"
    t.datetime "LastAccessTime"
    t.string   "SessionID",       limit: nil
    t.integer  "ProcessedLBound"
    t.integer  "ProcessedUBound"
    t.integer  "AssignedLBound"
    t.integer  "AssignedUBound"
  end

  create_table "dvtable_view_{00000000-0000-0000-0000-000000000000}_keyset", id: false, force: true do |t|
    t.string  "CursorID",   limit: nil, null: false
    t.integer "Order",                  null: false
    t.boolean "IsSelected"
    t.string  "InstanceID", limit: nil, null: false
    t.string  "ShortcutID", limit: nil
    t.integer "Rank",       limit: 2
  end

  create_table "dvtable_view_{00000000-0000-0000-0000-000000000000}_keyset_selection", id: false, force: true do |t|
    t.string  "CursorID",   limit: nil, null: false
    t.integer "OldOrder",               null: false
    t.string  "InstanceID", limit: nil, null: false
  end

  create_table "dvtable_view_{042689e4-b1ba-408e-847b-13b3741467a1}_keyset", id: false, force: true do |t|
    t.string  "CursorID",   limit: nil, null: false
    t.integer "Order",                  null: false
    t.boolean "IsSelected"
    t.string  "InstanceID", limit: nil, null: false
    t.string  "ShortcutID", limit: nil
    t.integer "Rank",       limit: 2
  end

  create_table "dvtable_view_{042689e4-b1ba-408e-847b-13b3741467a1}_keyset_selection", id: false, force: true do |t|
    t.string  "CursorID",   limit: nil, null: false
    t.integer "OldOrder",               null: false
    t.string  "InstanceID", limit: nil, null: false
  end

  create_table "dvtable_view_{228e77c0-337d-4054-9f85-4220061b17bb}_keyset", id: false, force: true do |t|
    t.string   "CursorID",                         limit: nil, null: false
    t.integer  "Order",                                        null: false
    t.boolean  "IsSelected"
    t.string   "Main_RowID_0",                     limit: nil
    t.string   "Inst_InstanceID_0",                limit: nil
    t.string   "tInstRead_InstanceID_0",           limit: nil
    t.string   "tInstRead_UserID_0",               limit: nil
    t.string   "MainStateStr_ResourceID_0",        limit: nil
    t.integer  "MainStateStr_LocaleID_0"
    t.integer  "MainStateStr_ResourceNumber_0"
    t.string   "MainStateStrEng_ResourceID_0",     limit: nil
    t.integer  "MainStateStrEng_LocaleID_0"
    t.integer  "MainStateStrEng_ResourceNumber_0"
    t.string   "InstanceID",                       limit: nil
    t.string   "_SDID",                            limit: nil
    t.string   "_ShortcutID",                      limit: nil
    t.boolean  "_DeletedShortcut"
    t.boolean  "_HardLink"
    t.datetime "Column_1"
  end

  create_table "dvtable_view_{228e77c0-337d-4054-9f85-4220061b17bb}_keyset_selection", id: false, force: true do |t|
    t.string  "CursorID",                         limit: nil, null: false
    t.integer "OldOrder",                                     null: false
    t.string  "Main_RowID_0",                     limit: nil
    t.string  "Inst_InstanceID_0",                limit: nil
    t.string  "tInstRead_InstanceID_0",           limit: nil
    t.string  "tInstRead_UserID_0",               limit: nil
    t.string  "MainStateStr_ResourceID_0",        limit: nil
    t.integer "MainStateStr_LocaleID_0"
    t.integer "MainStateStr_ResourceNumber_0"
    t.string  "MainStateStrEng_ResourceID_0",     limit: nil
    t.integer "MainStateStrEng_LocaleID_0"
    t.integer "MainStateStrEng_ResourceNumber_0"
  end

  create_table "dvtable_view_{2f341d1e-7700-4850-870a-247fd936ecde}_keyset", id: false, force: true do |t|
    t.string  "CursorID",   limit: nil, null: false
    t.integer "Order",                  null: false
    t.boolean "IsSelected"
    t.string  "InstanceID", limit: nil, null: false
    t.string  "ShortcutID", limit: nil
    t.integer "Rank",       limit: 2
  end

  create_table "dvtable_view_{2f341d1e-7700-4850-870a-247fd936ecde}_keyset_selection", id: false, force: true do |t|
    t.string  "CursorID",   limit: nil, null: false
    t.integer "OldOrder",               null: false
    t.string  "InstanceID", limit: nil, null: false
  end

  create_table "dvtable_view_{44a6e879-c04e-4d29-bae5-c5bce6a42073}_keyset", id: false, force: true do |t|
    t.string  "CursorID",   limit: nil, null: false
    t.integer "Order",                  null: false
    t.boolean "IsSelected"
    t.string  "InstanceID", limit: nil, null: false
    t.string  "ShortcutID", limit: nil
    t.integer "Rank",       limit: 2
  end

  create_table "dvtable_view_{44a6e879-c04e-4d29-bae5-c5bce6a42073}_keyset_selection", id: false, force: true do |t|
    t.string  "CursorID",   limit: nil, null: false
    t.integer "OldOrder",               null: false
    t.string  "InstanceID", limit: nil, null: false
  end

  create_table "dvtable_view_{6be04a9f-cd20-41aa-9add-56546d649aaf}_keyset", id: false, force: true do |t|
    t.string  "CursorID",   limit: nil, null: false
    t.integer "Order",                  null: false
    t.boolean "IsSelected"
    t.string  "InstanceID", limit: nil, null: false
    t.string  "ShortcutID", limit: nil
    t.integer "Rank",       limit: 2
  end

  create_table "dvtable_view_{6be04a9f-cd20-41aa-9add-56546d649aaf}_keyset_selection", id: false, force: true do |t|
    t.string  "CursorID",   limit: nil, null: false
    t.integer "OldOrder",               null: false
    t.string  "InstanceID", limit: nil, null: false
  end

  create_table "dvtable_view_{6e8295d7-58af-4249-9041-6ae8b5fdf51a}_keyset", id: false, force: true do |t|
    t.string  "CursorID",   limit: nil, null: false
    t.integer "Order",                  null: false
    t.boolean "IsSelected"
    t.string  "InstanceID", limit: nil, null: false
    t.string  "ShortcutID", limit: nil
    t.integer "Rank",       limit: 2
  end

  create_table "dvtable_view_{6e8295d7-58af-4249-9041-6ae8b5fdf51a}_keyset_selection", id: false, force: true do |t|
    t.string  "CursorID",   limit: nil, null: false
    t.integer "OldOrder",               null: false
    t.string  "InstanceID", limit: nil, null: false
  end

  create_table "dvtable_view_{7abb29ff-41a1-49ee-ba77-169092794513}_keyset", id: false, force: true do |t|
    t.string  "CursorID",   limit: nil, null: false
    t.integer "Order",                  null: false
    t.boolean "IsSelected"
    t.string  "InstanceID", limit: nil, null: false
    t.string  "ShortcutID", limit: nil
    t.integer "Rank",       limit: 2
  end

  create_table "dvtable_view_{7abb29ff-41a1-49ee-ba77-169092794513}_keyset_selection", id: false, force: true do |t|
    t.string  "CursorID",   limit: nil, null: false
    t.integer "OldOrder",               null: false
    t.string  "InstanceID", limit: nil, null: false
  end

  create_table "dvtable_view_{9c349d0a-6482-44c8-8988-21a30cc65f6c}_keyset", id: false, force: true do |t|
    t.string  "CursorID",   limit: nil, null: false
    t.integer "Order",                  null: false
    t.boolean "IsSelected"
    t.string  "InstanceID", limit: nil, null: false
    t.string  "ShortcutID", limit: nil
    t.integer "Rank",       limit: 2
  end

  create_table "dvtable_view_{9c349d0a-6482-44c8-8988-21a30cc65f6c}_keyset_selection", id: false, force: true do |t|
    t.string  "CursorID",   limit: nil, null: false
    t.integer "OldOrder",               null: false
    t.string  "InstanceID", limit: nil, null: false
  end

  create_table "dvtable_view_{c697e988-5163-41d5-bd28-6c02edbcc332}_keyset", id: false, force: true do |t|
    t.string   "CursorID",                         limit: nil, null: false
    t.integer  "Order",                                        null: false
    t.boolean  "IsSelected"
    t.string   "Main_RowID_0",                     limit: nil
    t.string   "Inst_InstanceID_0",                limit: nil
    t.string   "tInstRead_InstanceID_0",           limit: nil
    t.string   "tInstRead_UserID_0",               limit: nil
    t.string   "MainStateStr_ResourceID_0",        limit: nil
    t.integer  "MainStateStr_LocaleID_0"
    t.integer  "MainStateStr_ResourceNumber_0"
    t.string   "MainStateStrEng_ResourceID_0",     limit: nil
    t.integer  "MainStateStrEng_LocaleID_0"
    t.integer  "MainStateStrEng_ResourceNumber_0"
    t.string   "InstanceID",                       limit: nil
    t.string   "_SDID",                            limit: nil
    t.string   "_ShortcutID",                      limit: nil
    t.boolean  "_DeletedShortcut"
    t.boolean  "_HardLink"
    t.datetime "Column_1"
  end

  create_table "dvtable_view_{c697e988-5163-41d5-bd28-6c02edbcc332}_keyset_selection", id: false, force: true do |t|
    t.string  "CursorID",                         limit: nil, null: false
    t.integer "OldOrder",                                     null: false
    t.string  "Main_RowID_0",                     limit: nil
    t.string  "Inst_InstanceID_0",                limit: nil
    t.string  "tInstRead_InstanceID_0",           limit: nil
    t.string  "tInstRead_UserID_0",               limit: nil
    t.string  "MainStateStr_ResourceID_0",        limit: nil
    t.integer "MainStateStr_LocaleID_0"
    t.integer "MainStateStr_ResourceNumber_0"
    t.string  "MainStateStrEng_ResourceID_0",     limit: nil
    t.integer "MainStateStrEng_LocaleID_0"
    t.integer "MainStateStrEng_ResourceNumber_0"
  end

  create_table "dvtable_{011d2e18-e8b6-495e-904f-e7dd545f3e91}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{011d2e18-e8b6-495e-904f-e7dd545f3e91}", ["ParentRowID"], name: "dvsys_refpartners_chenumvalues_section"

  create_table "dvtable_{01ae4b60-5174-4304-b7d6-3f5acae357e1}", id: false, force: true do |t|
    t.string  "RowID",             limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",        limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",       limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",   limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SelectionName",     limit: 128
    t.string  "SelectionNamePID",  limit: nil
    t.integer "ParamType"
    t.string  "ParamPID",          limit: nil
    t.string  "SelectedValue",     limit: 2000
    t.boolean "IsCollection"
    t.boolean "Required"
    t.boolean "ReadOnly"
    t.integer "LinkValueID"
    t.integer "Order"
    t.string  "Tag",               limit: 128
    t.string  "NoValueMessage",    limit: 256
    t.string  "NoValueMessagePID", limit: nil
    t.string  "GateID",            limit: nil
    t.integer "VarTypeID"
  end

  add_index "dvtable_{01ae4b60-5174-4304-b7d6-3f5acae357e1}", ["InstanceID", "ParentTreeRowID"], name: "dvsys_workflowtask_completionparams_section"

  create_table "dvtable_{01ae4b60-5174-4304-b7d6-3f5acae357e1}_archive", id: false, force: true do |t|
    t.string  "RowID",             limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",        limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",       limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",   limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SelectionName",     limit: 128
    t.string  "SelectionNamePID",  limit: nil
    t.integer "ParamType"
    t.string  "ParamPID",          limit: nil
    t.string  "SelectedValue",     limit: 2000
    t.boolean "IsCollection"
    t.boolean "Required"
    t.boolean "ReadOnly"
    t.integer "LinkValueID"
    t.integer "Order"
    t.string  "Tag",               limit: 128
    t.string  "NoValueMessage",    limit: 256
    t.string  "NoValueMessagePID", limit: nil
    t.string  "GateID",            limit: nil
    t.integer "VarTypeID"
  end

  add_index "dvtable_{01ae4b60-5174-4304-b7d6-3f5acae357e1}_archive", ["InstanceID", "ParentTreeRowID"], name: "dvsys_workflowtask_completionparams_archive_section"

  create_table "dvtable_{01ebd37c-1180-4cad-847d-237203d1582b}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.integer "ColIndex"
    t.boolean "IsGroup"
    t.boolean "SortDescending"
  end

  add_index "dvtable_{01ebd37c-1180-4cad-847d-237203d1582b}", ["ParentRowID"], name: "dvsys_refuniversal_sortsettings_section"

  create_table "dvtable_{0228e9d7-4250-458c-adad-8a1141a83453}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "Name",            limit: 256
    t.string "NameUID",         limit: nil
  end

  add_index "dvtable_{0228e9d7-4250-458c-adad-8a1141a83453}", ["Name", "ParentTreeRowID", "NameUID"], name: "dvsys_savedviewcard_groups_uc_tree_name", unique: true
  add_index "dvtable_{0228e9d7-4250-458c-adad-8a1141a83453}", ["ParentTreeRowID"], name: "dvsys_savedviewcard_groups_section"

# Could not dump table "dvtable_{031d280e-054c-4347-b5bc-3fe6cae3d162}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{039cb193-167a-44d7-89f3-8c749155088d}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{039cb193-167a-44d7-89f3-8c749155088d}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{049de6c2-5d14-4c4f-b982-95b87df532e4}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "HistoryKind"
    t.string   "Person",          limit: nil
    t.text     "Comments"
    t.datetime "Date"
    t.string   "TaskID",          limit: nil
  end

  add_index "dvtable_{049de6c2-5d14-4c4f-b982-95b87df532e4}", ["InstanceID"], name: "dvsys_universalapprovalcard_approvalhistory_section"

  create_table "dvtable_{049de6c2-5d14-4c4f-b982-95b87df532e4}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "HistoryKind"
    t.string   "Person",          limit: nil
    t.text     "Comments"
    t.datetime "Date"
    t.string   "TaskID",          limit: nil
  end

  add_index "dvtable_{049de6c2-5d14-4c4f-b982-95b87df532e4}_archive", ["InstanceID"], name: "dvsys_universalapprovalcard_approvalhistory_archive_section"

  create_table "dvtable_{04e571ae-856d-4aed-89f4-a8cf69876df5}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "Order"
    t.string  "Department"
    t.string  "Manager",         limit: nil
    t.string  "Officer",         limit: nil
    t.integer "ApprovingTime"
  end

  add_index "dvtable_{04e571ae-856d-4aed-89f4-a8cf69876df5}", ["ParentRowID"], name: "dvsys_refroutetemplates_route_section"

  create_table "dvtable_{050478fc-00c7-480a-984d-0eb9f4d26366}", id: false, force: true do |t|
    t.string "RowID",                  limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                   limit: nil
    t.string "DirectionTypeName",      limit: 256
    t.string "DirectionTypeNumerator", limit: nil
  end

  add_index "dvtable_{050478fc-00c7-480a-984d-0eb9f4d26366}", ["ParentRowID"], name: "dvsys_refdocsetup_directiontypesnumerators_section"

  create_table "dvtable_{06b9f041-d2bd-4f9d-b163-21db03aa1765}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{06b9f041-d2bd-4f9d-b163-21db03aa1765}", ["CategoryID", "ParentRowID", "CategoryIDUID"], name: "dvsys_refcategories_linkedcategories_uc_section_categoryid", unique: true
  add_index "dvtable_{06b9f041-d2bd-4f9d-b163-21db03aa1765}", ["ParentRowID"], name: "dvsys_refcategories_linkedcategories_section"

  create_table "dvtable_{076f7b28-2e5d-4a9e-835c-6a8d83b82168}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "Order"
    t.string   "Approver",        limit: nil
    t.datetime "StartDate"
    t.datetime "ApprovingDate"
    t.integer  "Decision"
    t.text     "Comment"
  end

  add_index "dvtable_{076f7b28-2e5d-4a9e-835c-6a8d83b82168}", ["InstanceID"], name: "dvsys_memorandumcard_approvals_section"

  create_table "dvtable_{076f7b28-2e5d-4a9e-835c-6a8d83b82168}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "Order"
    t.string   "Approver",        limit: nil
    t.datetime "StartDate"
    t.datetime "ApprovingDate"
    t.integer  "Decision"
    t.text     "Comment"
  end

  add_index "dvtable_{076f7b28-2e5d-4a9e-835c-6a8d83b82168}_archive", ["InstanceID"], name: "dvsys_memorandumcard_approvals_archive_section"

  create_table "dvtable_{086a474c-bdfd-472d-9a35-8ef9e9209a67}", id: false, force: true do |t|
    t.string   "RowID",                      limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "DirectiveProjectDate"
    t.integer  "State",                                  default: 1
    t.datetime "RegistrationDate"
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID",       limit: nil
    t.integer  "ListCount"
    t.string   "Executer",                   limit: nil
    t.string   "SignedBy",                   limit: nil
    t.text     "Subject"
    t.text     "Content"
    t.string   "CaseID",                     limit: nil
    t.string   "FileListId",                 limit: nil
    t.string   "Registrator",                limit: nil
    t.integer  "InAppendix"
    t.string   "LinksListId",                limit: nil
    t.string   "LegacySystemID",             limit: 256
    t.string   "BarcodeNumber",              limit: 40
    t.string   "BarcodeNumberID",            limit: nil
    t.string   "TransferLog",                limit: nil
    t.string   "Controller",                 limit: nil
    t.string   "SignedBy_AlternateDirector", limit: nil
    t.integer  "CopiesCount"
    t.boolean  "NoApproving"
    t.string   "ApprovalListID",             limit: nil
    t.string   "ProjectNumber"
    t.string   "ProjectNumberID",            limit: nil
    t.string   "CurrentDocTemplate",         limit: nil
    t.string   "DirectiveType",              limit: nil
    t.string   "DirectiveTypeText",          limit: 256
    t.string   "ExecutionProcessID",         limit: nil
  end

  add_index "dvtable_{086a474c-bdfd-472d-9a35-8ef9e9209a67}", ["InstanceID"], name: "dvsys_directivecard_maininfo_uc_struct", unique: true

  create_table "dvtable_{086a474c-bdfd-472d-9a35-8ef9e9209a67}_archive", id: false, force: true do |t|
    t.string   "RowID",                      limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "DirectiveProjectDate"
    t.integer  "State"
    t.datetime "RegistrationDate"
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID",       limit: nil
    t.integer  "ListCount"
    t.string   "Executer",                   limit: nil
    t.string   "SignedBy",                   limit: nil
    t.text     "Subject"
    t.text     "Content"
    t.string   "CaseID",                     limit: nil
    t.string   "FileListId",                 limit: nil
    t.string   "Registrator",                limit: nil
    t.integer  "InAppendix"
    t.string   "LinksListId",                limit: nil
    t.string   "LegacySystemID",             limit: 256
    t.string   "BarcodeNumber",              limit: 40
    t.string   "BarcodeNumberID",            limit: nil
    t.string   "TransferLog",                limit: nil
    t.string   "Controller",                 limit: nil
    t.string   "SignedBy_AlternateDirector", limit: nil
    t.integer  "CopiesCount"
    t.boolean  "NoApproving"
    t.string   "ApprovalListID",             limit: nil
    t.string   "ProjectNumber"
    t.string   "ProjectNumberID",            limit: nil
    t.string   "CurrentDocTemplate",         limit: nil
    t.string   "DirectiveType",              limit: nil
    t.string   "DirectiveTypeText",          limit: 256
    t.string   "ExecutionProcessID",         limit: nil
  end

  add_index "dvtable_{086a474c-bdfd-472d-9a35-8ef9e9209a67}_archive", ["InstanceID"], name: "dvsys_directivecard_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{08b88059-a33e-4e9e-9836-53af90f9a57d}", id: false, force: true do |t|
    t.string   "RowID",                      limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "DecisionsResponsiblePerson", limit: nil
    t.text     "DecisionsDecision"
    t.datetime "DecisionsDeadline"
    t.boolean  "DecisionsSpecialControl"
    t.string   "DecisionsControlledBy",      limit: nil
    t.string   "DecisionsAgenda",            limit: nil
    t.integer  "AssignmentKind"
    t.boolean  "DecisionsUrgent"
    t.boolean  "DecisionsIsNotification"
    t.integer  "DecisionsOrder"
  end

  add_index "dvtable_{08b88059-a33e-4e9e-9836-53af90f9a57d}", ["InstanceID"], name: "dvsys_protocolcard_decisions_section"

  create_table "dvtable_{08b88059-a33e-4e9e-9836-53af90f9a57d}_archive", id: false, force: true do |t|
    t.string   "RowID",                      limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "DecisionsResponsiblePerson", limit: nil
    t.text     "DecisionsDecision"
    t.datetime "DecisionsDeadline"
    t.boolean  "DecisionsSpecialControl"
    t.string   "DecisionsControlledBy",      limit: nil
    t.string   "DecisionsAgenda",            limit: nil
    t.integer  "AssignmentKind"
    t.boolean  "DecisionsUrgent"
    t.boolean  "DecisionsIsNotification"
    t.integer  "DecisionsOrder"
  end

  add_index "dvtable_{08b88059-a33e-4e9e-9836-53af90f9a57d}_archive", ["InstanceID"], name: "dvsys_protocolcard_decisions_archive_section"

  create_table "dvtable_{0a3b96e5-aad3-4969-bad4-bd50a58869dc}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "RefID",           limit: nil
    t.integer "RefType"
    t.boolean "ReadOnly"
  end

  add_index "dvtable_{0a3b96e5-aad3-4969-bad4-bd50a58869dc}", ["ParentRowID"], name: "dvsys_reftypes_cardrights_section"

# Could not dump table "dvtable_{0b83cabb-3280-4763-9b3e-28e468cd086f}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{0b953235-600e-40bf-b483-5de49d0120c7}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Department"
    t.string   "Approver",        limit: nil
    t.datetime "StartDate"
    t.datetime "ApprovingDate"
    t.integer  "Decision"
    t.integer  "Order"
    t.string   "Officer",         limit: nil
    t.integer  "ApprovingTime"
    t.text     "Comment"
    t.boolean  "IsFromTemplate"
  end

  add_index "dvtable_{0b953235-600e-40bf-b483-5de49d0120c7}", ["InstanceID", "ParentRowID"], name: "dvsys_directivecard_approvals_section"
  add_index "dvtable_{0b953235-600e-40bf-b483-5de49d0120c7}", ["ParentRowID"], name: "dvsys_directivecard_approvals_idx_parentrowid"

  create_table "dvtable_{0b953235-600e-40bf-b483-5de49d0120c7}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Department"
    t.string   "Approver",        limit: nil
    t.datetime "StartDate"
    t.datetime "ApprovingDate"
    t.integer  "Decision"
    t.integer  "Order"
    t.string   "Officer",         limit: nil
    t.integer  "ApprovingTime"
    t.text     "Comment"
    t.boolean  "IsFromTemplate"
  end

  add_index "dvtable_{0b953235-600e-40bf-b483-5de49d0120c7}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_directivecard_approvals_archive_section"
  add_index "dvtable_{0b953235-600e-40bf-b483-5de49d0120c7}_archive", ["ParentRowID"], name: "dvsys_directivecard_approvals_archive_idx_parentrowid"

  create_table "dvtable_{0ba98316-984a-4b77-9766-1d9dc3254ae8}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Resolution"
  end

  add_index "dvtable_{0ba98316-984a-4b77-9766-1d9dc3254ae8}", ["InstanceID"], name: "dvsys_refbarcodescan_maininfo_uc_struct", unique: true

  create_table "dvtable_{0c420de1-36b3-445c-b4f7-9a2a361c5254}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "Order"
    t.string  "FieldName",       limit: 128
    t.boolean "FirstLetterOnly"
  end

  add_index "dvtable_{0c420de1-36b3-445c-b4f7-9a2a361c5254}", ["ParentRowID"], name: "dvsys_refpartners_emplviewfields_section"

  create_table "dvtable_{0ce329fc-33e8-4d10-b717-562b7fc1208d}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Coperformer",     limit: nil
  end

  add_index "dvtable_{0ce329fc-33e8-4d10-b717-562b7fc1208d}", ["InstanceID", "ParentRowID"], name: "dvsys_assignment_coperformers_section"
  add_index "dvtable_{0ce329fc-33e8-4d10-b717-562b7fc1208d}", ["ParentRowID"], name: "dvsys_assignment_coperformers_idx_parentrowid"

  create_table "dvtable_{0ce329fc-33e8-4d10-b717-562b7fc1208d}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Coperformer",     limit: nil
  end

  add_index "dvtable_{0ce329fc-33e8-4d10-b717-562b7fc1208d}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_assignment_coperformers_archive_section"
  add_index "dvtable_{0ce329fc-33e8-4d10-b717-562b7fc1208d}_archive", ["ParentRowID"], name: "dvsys_assignment_coperformers_archive_idx_parentrowid"

  create_table "dvtable_{0cee90b8-bceb-4d90-9361-388e2ba103e9}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "Field1"
  end

  add_index "dvtable_{0cee90b8-bceb-4d90-9361-388e2ba103e9}", ["InstanceID"], name: "dvsys_navextevent_section1_uc_struct", unique: true

  create_table "dvtable_{0ed8f802-0371-41cd-bef6-817a6f9fcd7d}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Description"
    t.string "RefID",           limit: nil
  end

  add_index "dvtable_{0ed8f802-0371-41cd-bef6-817a6f9fcd7d}", ["InstanceID"], name: "dvsys_contract_cardreferences_section"

  create_table "dvtable_{0ed8f802-0371-41cd-bef6-817a6f9fcd7d}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Description"
    t.string "RefID",           limit: nil
  end

  add_index "dvtable_{0ed8f802-0371-41cd-bef6-817a6f9fcd7d}_archive", ["InstanceID"], name: "dvsys_contract_cardreferences_archive_section"

  create_table "dvtable_{0ef6bcca-7a09-4027-a3a2-d2eeeca1bf4d}", id: false, force: true do |t|
    t.string   "RowID",                     limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",               limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",           limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",                      limit: 512
    t.string   "Description",               limit: 2048
    t.integer  "State"
    t.boolean  "HasLayout"
    t.datetime "DateBegin"
    t.datetime "DateEnd"
    t.string   "InitialDoc",                limit: nil
    t.boolean  "SubProcess"
    t.string   "ParentProcess",             limit: nil
    t.boolean  "Async"
    t.string   "Calendar",                  limit: nil
    t.integer  "TemplateState"
    t.string   "AuthorCreated",             limit: 128
    t.string   "AuthorModified",            limit: 128
    t.datetime "DateCreated"
    t.datetime "DateModified"
    t.string   "Version",                   limit: 64,   default: "1"
    t.string   "Folder",                    limit: nil
    t.string   "InstanceName",              limit: 256
    t.integer  "LocaleID"
    t.boolean  "Prepared",                               default: false
    t.string   "InstanceAuthor",            limit: 128
    t.string   "InitialDocumentVariableID", limit: nil
    t.integer  "CurrentPriority"
    t.integer  "Priority",                               default: 5
    t.datetime "LastRunDate"
    t.integer  "NextRunDate"
    t.integer  "SynchronousSubprocess"
    t.boolean  "ReadyToRun"
    t.integer  "BuildNumber"
    t.integer  "LoggingLevel",                           default: 3
    t.integer  "LogLimit"
    t.integer  "AfterFinishBehavior"
    t.string   "Responsible",               limit: nil
    t.integer  "RefreshPeriod",                          default: 3
    t.string   "TemplateProcess",           limit: nil
    t.integer  "ClearLogStrategy"
    t.integer  "ClearLogDaysCount"
    t.datetime "NextLogClearTime"
    t.integer  "FunctionsCount"
    t.boolean  "Singleton"
    t.boolean  "EncryptScripts"
    t.string   "Info",                      limit: 256
    t.string   "Hash",                      limit: 256
    t.integer  "ExecutionMode",                          default: 0
  end

  add_index "dvtable_{0ef6bcca-7a09-4027-a3a2-d2eeeca1bf4d}", ["CurrentPriority"], name: "dvsys_process_maininfo_idx_currentpriority"
  add_index "dvtable_{0ef6bcca-7a09-4027-a3a2-d2eeeca1bf4d}", ["InstanceID"], name: "dvsys_process_maininfo_uc_struct", unique: true
  add_index "dvtable_{0ef6bcca-7a09-4027-a3a2-d2eeeca1bf4d}", ["Priority"], name: "dvsys_process_maininfo_idx_priority"
  add_index "dvtable_{0ef6bcca-7a09-4027-a3a2-d2eeeca1bf4d}", ["ReadyToRun"], name: "dvsys_process_maininfo_idx_readytorun"
  add_index "dvtable_{0ef6bcca-7a09-4027-a3a2-d2eeeca1bf4d}", ["State"], name: "dvsys_process_maininfo_idx_state"

  create_table "dvtable_{0ef6bcca-7a09-4027-a3a2-d2eeeca1bf4d}_archive", id: false, force: true do |t|
    t.string   "RowID",                     limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",               limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",           limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",                      limit: 512
    t.string   "Description",               limit: 2048
    t.integer  "State"
    t.boolean  "HasLayout"
    t.datetime "DateBegin"
    t.datetime "DateEnd"
    t.string   "InitialDoc",                limit: nil
    t.boolean  "SubProcess"
    t.string   "ParentProcess",             limit: nil
    t.boolean  "Async"
    t.string   "Calendar",                  limit: nil
    t.integer  "TemplateState"
    t.string   "AuthorCreated",             limit: 128
    t.string   "AuthorModified",            limit: 128
    t.datetime "DateCreated"
    t.datetime "DateModified"
    t.string   "Version",                   limit: 64
    t.string   "Folder",                    limit: nil
    t.string   "InstanceName",              limit: 256
    t.integer  "LocaleID"
    t.boolean  "Prepared"
    t.string   "InstanceAuthor",            limit: 128
    t.string   "InitialDocumentVariableID", limit: nil
    t.integer  "CurrentPriority"
    t.integer  "Priority"
    t.datetime "LastRunDate"
    t.integer  "NextRunDate"
    t.integer  "SynchronousSubprocess"
    t.boolean  "ReadyToRun"
    t.integer  "BuildNumber"
    t.integer  "LoggingLevel"
    t.integer  "LogLimit"
    t.integer  "AfterFinishBehavior"
    t.string   "Responsible",               limit: nil
    t.integer  "RefreshPeriod"
    t.string   "TemplateProcess",           limit: nil
    t.integer  "ClearLogStrategy"
    t.integer  "ClearLogDaysCount"
    t.datetime "NextLogClearTime"
    t.integer  "FunctionsCount"
    t.boolean  "Singleton"
    t.boolean  "EncryptScripts"
    t.string   "Info",                      limit: 256
    t.string   "Hash",                      limit: 256
    t.integer  "ExecutionMode"
  end

  add_index "dvtable_{0ef6bcca-7a09-4027-a3a2-d2eeeca1bf4d}_archive", ["InstanceID"], name: "dvsys_process_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{0f259b0e-f5a7-4b57-9856-57690bda5955}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "FileID",          limit: nil
    t.text   "Comment"
    t.string "AuthorID",        limit: nil
  end

  add_index "dvtable_{0f259b0e-f5a7-4b57-9856-57690bda5955}", ["InstanceID", "ParentRowID"], name: "dvsys_versionedfilecard_associatedfiles_section"
  add_index "dvtable_{0f259b0e-f5a7-4b57-9856-57690bda5955}", ["ParentRowID"], name: "dvsys_versionedfilecard_associatedfiles_idx_parentrowid"

  create_table "dvtable_{0f259b0e-f5a7-4b57-9856-57690bda5955}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "FileID",          limit: nil
    t.text   "Comment"
    t.string "AuthorID",        limit: nil
  end

  add_index "dvtable_{0f259b0e-f5a7-4b57-9856-57690bda5955}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_versionedfilecard_associatedfiles_archive_section"
  add_index "dvtable_{0f259b0e-f5a7-4b57-9856-57690bda5955}_archive", ["ParentRowID"], name: "dvsys_versionedfilecard_associatedfiles_archive_idx_parentrowid"

  create_table "dvtable_{0f6d2670-fec0-4385-bd7b-5fccb4a1ebe6}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.boolean "Reserved"
  end

  add_index "dvtable_{0f6d2670-fec0-4385-bd7b-5fccb4a1ebe6}", ["InstanceID"], name: "dvsys_refpartners_usersettings_uc_struct", unique: true

  create_table "dvtable_{0f6d2670-fec0-4385-bd7b-5fccb4a1ebe6}_userdependent", id: false, force: true do |t|
    t.string  "RowID",        limit: nil,                 null: false
    t.string  "UserID",       limit: nil,                 null: false
    t.boolean "IsSearchMode",             default: false
    t.integer "SearchFor",                default: 2
    t.integer "OpenMode"
  end

  create_table "dvtable_{10105dc1-8b61-4a76-b719-02d679662606}", id: false, force: true do |t|
    t.string   "RowID",               limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",          limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",         limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ID",                  limit: nil
    t.string   "TypeID",              limit: nil
    t.string   "Caption",             limit: 128
    t.string   "Description",         limit: 1024
    t.float    "XPos",                limit: 24
    t.float    "YPos",                limit: 24
    t.boolean  "ReuseStep"
    t.integer  "Width"
    t.integer  "Height"
    t.string   "CardID",              limit: nil
    t.string   "WeakCardID",          limit: nil
    t.integer  "PoolingInterval"
    t.text     "Data"
    t.boolean  "UseSparedData",                    default: false
    t.string   "ErrDescriptionVarID", limit: nil
    t.string   "ErrCodeVarID",        limit: nil
    t.boolean  "IsMilestone"
    t.integer  "MilestoneType"
    t.datetime "MilestoneNextDate"
    t.string   "MilestoneDateVarID",  limit: nil
    t.string   "MilestoneDelayVarID", limit: nil
    t.integer  "ExecutionCounter"
    t.float    "MinExecutionTime",    limit: 24
    t.float    "MaxExecutionTime",    limit: 24
    t.float    "AvgExecutionTime",    limit: 24
    t.float    "LastExecutionTime",   limit: 24
    t.integer  "MilestoneDelayType"
  end

  add_index "dvtable_{10105dc1-8b61-4a76-b719-02d679662606}", ["CardID"], name: "dvsys_process_functions_idx_cardid"
  add_index "dvtable_{10105dc1-8b61-4a76-b719-02d679662606}", ["InstanceID"], name: "dvsys_process_functions_section"
  add_index "dvtable_{10105dc1-8b61-4a76-b719-02d679662606}", ["WeakCardID"], name: "dvsys_process_functions_idx_weakcardid"

  create_table "dvtable_{10105dc1-8b61-4a76-b719-02d679662606}_archive", id: false, force: true do |t|
    t.string   "RowID",               limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",          limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",         limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ID",                  limit: nil
    t.string   "TypeID",              limit: nil
    t.string   "Caption",             limit: 128
    t.string   "Description",         limit: 1024
    t.float    "XPos",                limit: 24
    t.float    "YPos",                limit: 24
    t.boolean  "ReuseStep"
    t.integer  "Width"
    t.integer  "Height"
    t.string   "CardID",              limit: nil
    t.string   "WeakCardID",          limit: nil
    t.integer  "PoolingInterval"
    t.text     "Data"
    t.boolean  "UseSparedData"
    t.string   "ErrDescriptionVarID", limit: nil
    t.string   "ErrCodeVarID",        limit: nil
    t.boolean  "IsMilestone"
    t.integer  "MilestoneType"
    t.datetime "MilestoneNextDate"
    t.string   "MilestoneDateVarID",  limit: nil
    t.string   "MilestoneDelayVarID", limit: nil
    t.integer  "ExecutionCounter"
    t.float    "MinExecutionTime",    limit: 24
    t.float    "MaxExecutionTime",    limit: 24
    t.float    "AvgExecutionTime",    limit: 24
    t.float    "LastExecutionTime",   limit: 24
    t.integer  "MilestoneDelayType"
  end

  add_index "dvtable_{10105dc1-8b61-4a76-b719-02d679662606}_archive", ["InstanceID"], name: "dvsys_process_functions_archive_section"

# Could not dump table "dvtable_{1092a733-aca7-4134-8fb9-09a764f23fd9}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{1092a733-aca7-4134-8fb9-09a764f23fd9}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{11ffd2eb-a6e5-4303-a0f4-de23813c7b5c}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ToWhomPerson",    limit: nil
  end

  add_index "dvtable_{11ffd2eb-a6e5-4303-a0f4-de23813c7b5c}", ["InstanceID", "ParentRowID"], name: "dvsys_memorandumcard_towhom_section"
  add_index "dvtable_{11ffd2eb-a6e5-4303-a0f4-de23813c7b5c}", ["ParentRowID"], name: "dvsys_memorandumcard_towhom_idx_parentrowid"

  create_table "dvtable_{11ffd2eb-a6e5-4303-a0f4-de23813c7b5c}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ToWhomPerson",    limit: nil
  end

  add_index "dvtable_{11ffd2eb-a6e5-4303-a0f4-de23813c7b5c}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_memorandumcard_towhom_archive_section"
  add_index "dvtable_{11ffd2eb-a6e5-4303-a0f4-de23813c7b5c}_archive", ["ParentRowID"], name: "dvsys_memorandumcard_towhom_archive_idx_parentrowid"

  create_table "dvtable_{13641961-5b15-4eed-b911-c8aef2d5ad63}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "NRDDeveloper",    limit: nil
  end

  add_index "dvtable_{13641961-5b15-4eed-b911-c8aef2d5ad63}", ["ParentRowID"], name: "dvsys_refdocsetup_nrddevelopers_section"

# Could not dump table "dvtable_{13a6a514-dc45-4078-ad02-66a79f896e68}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{13a6a514-dc45-4078-ad02-66a79f896e68}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{14d184a3-c02f-405d-b9f9-decf14434591}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ProcessID",       limit: nil
    t.boolean "IsHardLink"
    t.string  "ProcessFolder",   limit: nil
    t.string  "HardProcessID",   limit: nil
  end

  add_index "dvtable_{14d184a3-c02f-405d-b9f9-decf14434591}", ["InstanceID"], name: "dvsys_cardout_processes_section"

  create_table "dvtable_{14d184a3-c02f-405d-b9f9-decf14434591}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ProcessID",       limit: nil
    t.boolean "IsHardLink"
    t.string  "ProcessFolder",   limit: nil
    t.string  "HardProcessID",   limit: nil
  end

  add_index "dvtable_{14d184a3-c02f-405d-b9f9-decf14434591}_archive", ["InstanceID"], name: "dvsys_cardout_processes_archive_section"

  create_table "dvtable_{153c9ddb-6ba3-4f9d-83df-d00e33aabe21}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "TaskID"
    t.integer  "ZoneFrom"
    t.integer  "ZoneTo"
    t.datetime "OpenDateTime"
    t.datetime "CloseDateTime"
    t.text     "Comment"
    t.integer  "Status",                      default: 2
    t.string   "UserAccount",     limit: 256
  end

  add_index "dvtable_{153c9ddb-6ba3-4f9d-83df-d00e33aabe21}", ["InstanceID"], name: "dvsys_replicationcard_replicationtasks_uc_struct", unique: true

  create_table "dvtable_{153c9ddb-6ba3-4f9d-83df-d00e33aabe21}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "TaskID"
    t.integer  "ZoneFrom"
    t.integer  "ZoneTo"
    t.datetime "OpenDateTime"
    t.datetime "CloseDateTime"
    t.text     "Comment"
    t.integer  "Status"
    t.string   "UserAccount",     limit: 256
  end

  add_index "dvtable_{153c9ddb-6ba3-4f9d-83df-d00e33aabe21}_archive", ["InstanceID"], name: "dvsys_replicationcard_replicationtasks_archive_uc_struct", unique: true

  create_table "dvtable_{156ce04e-a0a0-4003-b068-709992035fa7}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "Name",            limit: 128
    t.string "Value",           limit: 128
  end

  add_index "dvtable_{156ce04e-a0a0-4003-b068-709992035fa7}", ["ParentRowID"], name: "dvsys_refpartners_codes_section"

  create_table "dvtable_{15a8e7d1-f17c-4114-b9be-466f507a294d}", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "SendDate"
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID", limit: nil
    t.integer  "State",                            default: 1
    t.string   "Registrator",          limit: nil
    t.string   "Recipient",            limit: nil
    t.string   "BarcodeNumber",        limit: 40
    t.string   "BarcodeNumberID",      limit: nil
    t.string   "TransferLog",          limit: nil
    t.string   "SendingType",          limit: nil
  end

  add_index "dvtable_{15a8e7d1-f17c-4114-b9be-466f507a294d}", ["InstanceID"], name: "dvsys_registercard_maininfo_uc_struct", unique: true

  create_table "dvtable_{15a8e7d1-f17c-4114-b9be-466f507a294d}_archive", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "SendDate"
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID", limit: nil
    t.integer  "State"
    t.string   "Registrator",          limit: nil
    t.string   "Recipient",            limit: nil
    t.string   "BarcodeNumber",        limit: 40
    t.string   "BarcodeNumberID",      limit: nil
    t.string   "TransferLog",          limit: nil
    t.string   "SendingType",          limit: nil
  end

  add_index "dvtable_{15a8e7d1-f17c-4114-b9be-466f507a294d}_archive", ["InstanceID"], name: "dvsys_registercard_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{15ae16c0-b562-4311-94dd-2e14c6542f5a}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Coperformer",     limit: nil
  end

  add_index "dvtable_{15ae16c0-b562-4311-94dd-2e14c6542f5a}", ["InstanceID", "ParentRowID"], name: "dvsys_durableassignmentcard_coperformers_section"
  add_index "dvtable_{15ae16c0-b562-4311-94dd-2e14c6542f5a}", ["ParentRowID"], name: "dvsys_durableassignmentcard_coperformers_idx_parentrowid"

  create_table "dvtable_{15ae16c0-b562-4311-94dd-2e14c6542f5a}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Coperformer",     limit: nil
  end

  add_index "dvtable_{15ae16c0-b562-4311-94dd-2e14c6542f5a}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_durableassignmentcard_coperformers_archive_section"
  add_index "dvtable_{15ae16c0-b562-4311-94dd-2e14c6542f5a}_archive", ["ParentRowID"], name: "dvsys_durableassignmentcard_coperformers_archive_idx_parentrowid"

  create_table "dvtable_{166fbb9a-6222-4178-a0e6-d52dd177b8a1}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ProcessID",       limit: nil
    t.boolean "IsHardLink"
    t.string  "ProcessFolder",   limit: nil
    t.string  "HardProcessID",   limit: nil
  end

  add_index "dvtable_{166fbb9a-6222-4178-a0e6-d52dd177b8a1}", ["InstanceID"], name: "dvsys_cardinc_processes_section"

  create_table "dvtable_{166fbb9a-6222-4178-a0e6-d52dd177b8a1}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ProcessID",       limit: nil
    t.boolean "IsHardLink"
    t.string  "ProcessFolder",   limit: nil
    t.string  "HardProcessID",   limit: nil
  end

  add_index "dvtable_{166fbb9a-6222-4178-a0e6-d52dd177b8a1}_archive", ["InstanceID"], name: "dvsys_cardinc_processes_archive_section"

  create_table "dvtable_{1671e8be-92cb-4744-bb7f-6616c722e06e}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.string  "Name",            limit: 256
    t.string  "SyncTag",         limit: 256
    t.boolean "NotAvailable",                 default: false
    t.string  "Comment",         limit: 1024
    t.string  "Status",          limit: nil
    t.string  "NameUID",         limit: nil
  end

  add_index "dvtable_{1671e8be-92cb-4744-bb7f-6616c722e06e}", ["Name", "ParentRowID", "NameUID"], name: "dvsys_refcases_folders_uc_section_name", unique: true
  add_index "dvtable_{1671e8be-92cb-4744-bb7f-6616c722e06e}", ["ParentRowID"], name: "dvsys_refcases_folders_section"

  create_table "dvtable_{16f0fa47-38c0-45ff-9f90-eb324771824a}", id: false, force: true do |t|
    t.string "RowID",                limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                 limit: nil
    t.string "ContractCounteragent", limit: nil
  end

  add_index "dvtable_{16f0fa47-38c0-45ff-9f90-eb324771824a}", ["ParentRowID"], name: "dvsys_refdocsetup_contractcounteragents_section"

  create_table "dvtable_{17ab7c31-d4a1-4678-bdf1-985b14159892}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SignedBy",        limit: nil
  end

  add_index "dvtable_{17ab7c31-d4a1-4678-bdf1-985b14159892}", ["InstanceID", "ParentRowID"], name: "dvsys_registercard_signedby_section"
  add_index "dvtable_{17ab7c31-d4a1-4678-bdf1-985b14159892}", ["ParentRowID"], name: "dvsys_registercard_signedby_idx_parentrowid"

  create_table "dvtable_{17ab7c31-d4a1-4678-bdf1-985b14159892}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SignedBy",        limit: nil
  end

  add_index "dvtable_{17ab7c31-d4a1-4678-bdf1-985b14159892}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_registercard_signedby_archive_section"
  add_index "dvtable_{17ab7c31-d4a1-4678-bdf1-985b14159892}_archive", ["ParentRowID"], name: "dvsys_registercard_signedby_archive_idx_parentrowid"

  create_table "dvtable_{1883685f-ed8b-429e-85a6-e45fc944325d}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Template",        limit: nil
    t.integer "ApprovingType"
  end

  add_index "dvtable_{1883685f-ed8b-429e-85a6-e45fc944325d}", ["InstanceID"], name: "dvsys_ordercard_approvallist_uc_struct", unique: true

  create_table "dvtable_{1883685f-ed8b-429e-85a6-e45fc944325d}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Template",        limit: nil
    t.integer "ApprovingType"
  end

  add_index "dvtable_{1883685f-ed8b-429e-85a6-e45fc944325d}_archive", ["InstanceID"], name: "dvsys_ordercard_approvallist_archive_uc_struct", unique: true

# Could not dump table "dvtable_{1a223688-6c39-433f-bf75-8e200a48d919}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{1a46bf0f-2d02-4ac9-8866-5adf245921e8}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "SDID",            limit: nil
    t.string   "FirstName",       limit: 32
    t.string   "MiddleName",      limit: 32
    t.string   "LastName",        limit: 32
    t.string   "Position",        limit: nil
    t.string   "Phone",           limit: 64
    t.string   "Fax",             limit: 64
    t.string   "Email",           limit: 64
    t.string   "Comments",        limit: 1024
    t.string   "SyncTag",         limit: 256
    t.string   "ZipCode",         limit: 32
    t.string   "City",            limit: 128
    t.string   "Address",         limit: 1024
    t.boolean  "NotAvailable",                 default: false
    t.string   "Title",           limit: nil
    t.integer  "Gender",                       default: 0
    t.string   "MobilePhone",     limit: 64
    t.string   "AdditionalPhone", limit: 64
    t.string   "Country",         limit: 128
    t.datetime "BirthDate"
    t.integer  "DuplicateID"
    t.string   "UniqueEmpl",      limit: nil
  end

  add_index "dvtable_{1a46bf0f-2d02-4ac9-8866-5adf245921e8}", ["LastName"], name: "dvsys_refpartners_employees_idx_lastname"
  add_index "dvtable_{1a46bf0f-2d02-4ac9-8866-5adf245921e8}", ["ParentRowID"], name: "dvsys_refpartners_employees_section"

  create_table "dvtable_{1b4cdd13-862c-49df-8587-eb785b19315f}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ProcessID",       limit: nil
    t.boolean "IsHardLink"
    t.string  "ProcessFolder",   limit: nil
    t.string  "HardProcessID",   limit: nil
  end

  add_index "dvtable_{1b4cdd13-862c-49df-8587-eb785b19315f}", ["InstanceID"], name: "dvsys_carduni_processes_section"

  create_table "dvtable_{1b4cdd13-862c-49df-8587-eb785b19315f}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ProcessID",       limit: nil
    t.boolean "IsHardLink"
    t.string  "ProcessFolder",   limit: nil
    t.string  "HardProcessID",   limit: nil
  end

  add_index "dvtable_{1b4cdd13-862c-49df-8587-eb785b19315f}_archive", ["InstanceID"], name: "dvsys_carduni_processes_archive_section"

  create_table "dvtable_{1b96ce8c-b973-4682-9e83-aefa16110e46}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{1b96ce8c-b973-4682-9e83-aefa16110e46}", ["CategoryID", "InstanceID", "CategoryIDUID"], name: "dvsys_cardfile_categories_uc_card_categoryid", unique: true
  add_index "dvtable_{1b96ce8c-b973-4682-9e83-aefa16110e46}", ["InstanceID"], name: "dvsys_cardfile_categories_section"

  create_table "dvtable_{1b96ce8c-b973-4682-9e83-aefa16110e46}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{1b96ce8c-b973-4682-9e83-aefa16110e46}_archive", ["InstanceID"], name: "dvsys_cardfile_categories_archive_section"

  create_table "dvtable_{1ba7763e-186c-4d7b-af80-8e9e8cd7d0bd}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ApprovalID",      limit: nil
  end

  add_index "dvtable_{1ba7763e-186c-4d7b-af80-8e9e8cd7d0bd}", ["InstanceID"], name: "dvsys_cardord_approvals_section"

  create_table "dvtable_{1ba7763e-186c-4d7b-af80-8e9e8cd7d0bd}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ApprovalID",      limit: nil
  end

  add_index "dvtable_{1ba7763e-186c-4d7b-af80-8e9e8cd7d0bd}_archive", ["InstanceID"], name: "dvsys_cardord_approvals_archive_section"

  create_table "dvtable_{1c2ff3b3-532b-483a-b231-29a951ca56ca}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "DeputyID",        limit: nil
  end

  add_index "dvtable_{1c2ff3b3-532b-483a-b231-29a951ca56ca}", ["InstanceID", "ParentRowID"], name: "dvsys_cardapproval_deputies_section"
  add_index "dvtable_{1c2ff3b3-532b-483a-b231-29a951ca56ca}", ["ParentRowID"], name: "dvsys_cardapproval_deputies_idx_parentrowid"

  create_table "dvtable_{1c2ff3b3-532b-483a-b231-29a951ca56ca}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "DeputyID",        limit: nil
  end

  add_index "dvtable_{1c2ff3b3-532b-483a-b231-29a951ca56ca}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardapproval_deputies_archive_section"
  add_index "dvtable_{1c2ff3b3-532b-483a-b231-29a951ca56ca}_archive", ["ParentRowID"], name: "dvsys_cardapproval_deputies_archive_idx_parentrowid"

  create_table "dvtable_{1ce27c76-d72c-4f45-8ad7-42b03cd8def6}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{1ce27c76-d72c-4f45-8ad7-42b03cd8def6}", ["InstanceID", "ParentRowID"], name: "dvsys_cardresolution_enumvalues_section"
  add_index "dvtable_{1ce27c76-d72c-4f45-8ad7-42b03cd8def6}", ["ParentRowID"], name: "dvsys_cardresolution_enumvalues_idx_parentrowid"

  create_table "dvtable_{1ce27c76-d72c-4f45-8ad7-42b03cd8def6}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{1ce27c76-d72c-4f45-8ad7-42b03cd8def6}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardresolution_enumvalues_archive_section"
  add_index "dvtable_{1ce27c76-d72c-4f45-8ad7-42b03cd8def6}_archive", ["ParentRowID"], name: "dvsys_cardresolution_enumvalues_archive_idx_parentrowid"

  create_table "dvtable_{1d0cae14-66c7-49a7-a981-cc1d651af15a}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "RootFolderID",    limit: nil
  end

  add_index "dvtable_{1d0cae14-66c7-49a7-a981-cc1d651af15a}", ["InstanceID"], name: "dvsys_refcategories_main_uc_struct", unique: true

  create_table "dvtable_{1de3032f-1956-4c37-ae14-a29f8b47e0ac}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "AddressType"
    t.string  "ZipCode",         limit: 32
    t.string  "City",            limit: 128
    t.string  "Address",         limit: 1024
    t.string  "Country",         limit: 128
  end

  add_index "dvtable_{1de3032f-1956-4c37-ae14-a29f8b47e0ac}", ["ParentRowID"], name: "dvsys_refpartners_addresses_section"

  create_table "dvtable_{1e3ce215-62f4-4818-b860-e7c0eee68254}", id: false, force: true do |t|
    t.string  "RowID",                            limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",                      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",                  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ForAcquaintanceAssignee",          limit: nil
    t.string  "ForAcquaintanceTaskID",            limit: nil
    t.integer "ForAcquaintanceCompletionVariant"
  end

  add_index "dvtable_{1e3ce215-62f4-4818-b860-e7c0eee68254}", ["InstanceID", "ParentRowID"], name: "dvsys_assignment_foracquaintanceassignees_section"
  add_index "dvtable_{1e3ce215-62f4-4818-b860-e7c0eee68254}", ["ParentRowID"], name: "dvsys_assignment_foracquaintanceassignees_idx_parentrowid"

  create_table "dvtable_{1e3ce215-62f4-4818-b860-e7c0eee68254}_archive", id: false, force: true do |t|
    t.string  "RowID",                            limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",                      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",                  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ForAcquaintanceAssignee",          limit: nil
    t.string  "ForAcquaintanceTaskID",            limit: nil
    t.integer "ForAcquaintanceCompletionVariant"
  end

  add_index "dvtable_{1e3ce215-62f4-4818-b860-e7c0eee68254}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_assignment_foracquaintanceassignees_archive_section"
  add_index "dvtable_{1e3ce215-62f4-4818-b860-e7c0eee68254}_archive", ["ParentRowID"], name: "dvsys_assignment_foracquaintanceassignees_archive_idx_parentrowid"

  create_table "dvtable_{201bbfab-db9f-4113-b7d3-d61a06b8cade}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Name",            limit: 256
    t.text   "Value"
  end

  add_index "dvtable_{201bbfab-db9f-4113-b7d3-d61a06b8cade}", ["ParentRowID"], name: "dvsys_refreports_customoptions_section"

  create_table "dvtable_{20d0bd74-08cf-4564-8ae3-0598bd891f74}", id: false, force: true do |t|
    t.string "RowID",                limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                 limit: nil
    t.string "ContractLawyerPerson", limit: nil
  end

  add_index "dvtable_{20d0bd74-08cf-4564-8ae3-0598bd891f74}", ["ParentRowID"], name: "dvsys_refdocsetup_contractlawyerpersons_section"

  create_table "dvtable_{20ffd567-a851-4e10-8548-6dcca0fcb020}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Person",          limit: nil
    t.text     "Comments"
    t.datetime "Date"
    t.integer  "Resolution"
    t.string   "TaskID",          limit: nil
  end

  add_index "dvtable_{20ffd567-a851-4e10-8548-6dcca0fcb020}", ["InstanceID"], name: "dvsys_outdoc_approvalhistory_section"

  create_table "dvtable_{20ffd567-a851-4e10-8548-6dcca0fcb020}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Person",          limit: nil
    t.text     "Comments"
    t.datetime "Date"
    t.integer  "Resolution"
    t.string   "TaskID",          limit: nil
  end

  add_index "dvtable_{20ffd567-a851-4e10-8548-6dcca0fcb020}_archive", ["InstanceID"], name: "dvsys_outdoc_approvalhistory_archive_section"

  create_table "dvtable_{2137c17e-2b5d-4a51-8a96-0a973e35cd41}", id: false, force: true do |t|
    t.string   "RowID",               limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",                limit: 512
    t.string   "Type",                limit: nil
    t.string   "NumberRef",           limit: nil
    t.string   "FullNumber",          limit: 160
    t.boolean  "FixNumber"
    t.string   "Recipient",           limit: nil
    t.datetime "CreationDate"
    t.datetime "RegistrationDate"
    t.string   "RegisteredBy",        limit: nil
    t.text     "Digest"
    t.integer  "PageCount"
    t.integer  "AttachmentPageCount"
    t.string   "FiledInFolder",       limit: nil
    t.string   "FiledInCase",         limit: nil
    t.string   "FilesID",             limit: nil
    t.string   "DocState",            limit: nil
    t.string   "Responsible",         limit: nil
    t.string   "RecipientDep",        limit: nil
    t.string   "ParentCardID",        limit: nil
    t.boolean  "PropsAsForm"
    t.datetime "KeepFrom"
    t.datetime "KeepTo"
    t.boolean  "Confidential"
    t.string   "DocProperty",         limit: 128
    t.string   "BarcodeNumber",       limit: 32
  end

  add_index "dvtable_{2137c17e-2b5d-4a51-8a96-0a973e35cd41}", ["InstanceID"], name: "dvsys_cardarchive_maininfo_uc_struct", unique: true

  create_table "dvtable_{2137c17e-2b5d-4a51-8a96-0a973e35cd41}_archive", id: false, force: true do |t|
    t.string   "RowID",               limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",                limit: 512
    t.string   "Type",                limit: nil
    t.string   "NumberRef",           limit: nil
    t.string   "FullNumber",          limit: 160
    t.boolean  "FixNumber"
    t.string   "Recipient",           limit: nil
    t.datetime "CreationDate"
    t.datetime "RegistrationDate"
    t.string   "RegisteredBy",        limit: nil
    t.text     "Digest"
    t.integer  "PageCount"
    t.integer  "AttachmentPageCount"
    t.string   "FiledInFolder",       limit: nil
    t.string   "FiledInCase",         limit: nil
    t.string   "FilesID",             limit: nil
    t.string   "DocState",            limit: nil
    t.string   "Responsible",         limit: nil
    t.string   "RecipientDep",        limit: nil
    t.string   "ParentCardID",        limit: nil
    t.boolean  "PropsAsForm"
    t.datetime "KeepFrom"
    t.datetime "KeepTo"
    t.boolean  "Confidential"
    t.string   "DocProperty",         limit: 128
    t.string   "BarcodeNumber",       limit: 32
  end

  add_index "dvtable_{2137c17e-2b5d-4a51-8a96-0a973e35cd41}_archive", ["InstanceID"], name: "dvsys_cardarchive_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{21f4640a-9b6a-4874-a0d4-0b96bd3f7081}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Coperformer",     limit: nil
  end

  add_index "dvtable_{21f4640a-9b6a-4874-a0d4-0b96bd3f7081}", ["InstanceID", "ParentRowID"], name: "dvsys_protocolcard_coperformers_section"
  add_index "dvtable_{21f4640a-9b6a-4874-a0d4-0b96bd3f7081}", ["ParentRowID"], name: "dvsys_protocolcard_coperformers_idx_parentrowid"

  create_table "dvtable_{21f4640a-9b6a-4874-a0d4-0b96bd3f7081}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Coperformer",     limit: nil
  end

  add_index "dvtable_{21f4640a-9b6a-4874-a0d4-0b96bd3f7081}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_protocolcard_coperformers_archive_section"
  add_index "dvtable_{21f4640a-9b6a-4874-a0d4-0b96bd3f7081}_archive", ["ParentRowID"], name: "dvsys_protocolcard_coperformers_archive_idx_parentrowid"

  create_table "dvtable_{227a7ee1-c02f-45ac-a708-db77a6eb35ce}", id: false, force: true do |t|
    t.string "RowID",                                  limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",                             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",                            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",                        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "DistributionEmployeeId",                 limit: nil
    t.string "DistributionAttendeesPartnerEmployeeId", limit: nil
  end

  add_index "dvtable_{227a7ee1-c02f-45ac-a708-db77a6eb35ce}", ["InstanceID"], name: "dvsys_protocolcard_distributionlist_section"

  create_table "dvtable_{227a7ee1-c02f-45ac-a708-db77a6eb35ce}_archive", id: false, force: true do |t|
    t.string "RowID",                                  limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",                             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",                            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",                        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "DistributionEmployeeId",                 limit: nil
    t.string "DistributionAttendeesPartnerEmployeeId", limit: nil
  end

  add_index "dvtable_{227a7ee1-c02f-45ac-a708-db77a6eb35ce}_archive", ["InstanceID"], name: "dvsys_protocolcard_distributionlist_archive_section"

  create_table "dvtable_{2298ec75-0706-4316-b4be-51af4c01a29f}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Partner",         limit: nil
  end

  add_index "dvtable_{2298ec75-0706-4316-b4be-51af4c01a29f}", ["InstanceID", "ParentRowID"], name: "dvsys_warrantcard_onbehalfofpartner_section"
  add_index "dvtable_{2298ec75-0706-4316-b4be-51af4c01a29f}", ["ParentRowID"], name: "dvsys_warrantcard_onbehalfofpartner_idx_parentrowid"

  create_table "dvtable_{2298ec75-0706-4316-b4be-51af4c01a29f}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Partner",         limit: nil
  end

  add_index "dvtable_{2298ec75-0706-4316-b4be-51af4c01a29f}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_warrantcard_onbehalfofpartner_archive_section"
  add_index "dvtable_{2298ec75-0706-4316-b4be-51af4c01a29f}_archive", ["ParentRowID"], name: "dvsys_warrantcard_onbehalfofpartner_archive_idx_parentrowid"

  create_table "dvtable_{22af5254-b1b0-4db0-9df0-7fa7e199e693}", id: false, force: true do |t|
    t.string   "RowID",               limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",                limit: 512
    t.string   "Type",                limit: nil
    t.string   "NumberRef",           limit: nil
    t.string   "FullNumber",          limit: 160
    t.boolean  "FixNumber"
    t.string   "Sender",              limit: nil
    t.datetime "CreationDate"
    t.datetime "RegistrationDate"
    t.string   "RegisteredBy",        limit: nil
    t.string   "DeliveryType",        limit: nil
    t.text     "Digest"
    t.integer  "PageCount"
    t.integer  "AttachmentPageCount"
    t.string   "FiledInFolder",       limit: nil
    t.string   "FiledInCase",         limit: nil
    t.boolean  "IsSent"
    t.string   "FilesID",             limit: nil
    t.string   "DocState",            limit: nil
    t.string   "Responsible",         limit: nil
    t.string   "SenderDep",           limit: nil
    t.string   "ParentCardID",        limit: nil
    t.boolean  "PropsAsForm"
    t.boolean  "Confidential"
    t.string   "DocProperty",         limit: 128
    t.string   "BarcodeNumber",       limit: 32
    t.boolean  "NotCopyIncNumber"
    t.string   "ControlledBy",        limit: nil
    t.datetime "ControlDate"
  end

  add_index "dvtable_{22af5254-b1b0-4db0-9df0-7fa7e199e693}", ["InstanceID"], name: "dvsys_cardout_maininfo_uc_struct", unique: true

  create_table "dvtable_{22af5254-b1b0-4db0-9df0-7fa7e199e693}_archive", id: false, force: true do |t|
    t.string   "RowID",               limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",                limit: 512
    t.string   "Type",                limit: nil
    t.string   "NumberRef",           limit: nil
    t.string   "FullNumber",          limit: 160
    t.boolean  "FixNumber"
    t.string   "Sender",              limit: nil
    t.datetime "CreationDate"
    t.datetime "RegistrationDate"
    t.string   "RegisteredBy",        limit: nil
    t.string   "DeliveryType",        limit: nil
    t.text     "Digest"
    t.integer  "PageCount"
    t.integer  "AttachmentPageCount"
    t.string   "FiledInFolder",       limit: nil
    t.string   "FiledInCase",         limit: nil
    t.boolean  "IsSent"
    t.string   "FilesID",             limit: nil
    t.string   "DocState",            limit: nil
    t.string   "Responsible",         limit: nil
    t.string   "SenderDep",           limit: nil
    t.string   "ParentCardID",        limit: nil
    t.boolean  "PropsAsForm"
    t.boolean  "Confidential"
    t.string   "DocProperty",         limit: 128
    t.string   "BarcodeNumber",       limit: 32
    t.boolean  "NotCopyIncNumber"
    t.string   "ControlledBy",        limit: nil
    t.datetime "ControlDate"
  end

  add_index "dvtable_{22af5254-b1b0-4db0-9df0-7fa7e199e693}_archive", ["InstanceID"], name: "dvsys_cardout_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{2462e49c-929a-4422-9b37-3f892f36924d}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "NotifEmployee",   limit: nil
    t.datetime "FamiliarizeDate"
  end

  add_index "dvtable_{2462e49c-929a-4422-9b37-3f892f36924d}", ["InstanceID"], name: "dvsys_directivecard_notificationlist_section"

  create_table "dvtable_{2462e49c-929a-4422-9b37-3f892f36924d}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "NotifEmployee",   limit: nil
    t.datetime "FamiliarizeDate"
  end

  add_index "dvtable_{2462e49c-929a-4422-9b37-3f892f36924d}_archive", ["InstanceID"], name: "dvsys_directivecard_notificationlist_archive_section"

  create_table "dvtable_{247552c6-76c4-4193-b0c7-7033fa5b5213}", id: false, force: true do |t|
    t.string "RowID",                limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                 limit: nil
    t.string "DirectionEmployee_OD", limit: nil
  end

  add_index "dvtable_{247552c6-76c4-4193-b0c7-7033fa5b5213}", ["ParentRowID"], name: "dvsys_refdocsetup_directionemployees_od_section"

  create_table "dvtable_{25fd515b-eb74-4ae3-92f6-3397e31cf2cb}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "EditControler",   limit: nil
    t.datetime "EditDeadline"
    t.boolean  "EditToRead"
    t.text     "EditComments"
  end

  add_index "dvtable_{25fd515b-eb74-4ae3-92f6-3397e31cf2cb}", ["InstanceID"], name: "dvsys_directivecard_assignmentedit_uc_struct", unique: true

  create_table "dvtable_{25fd515b-eb74-4ae3-92f6-3397e31cf2cb}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "EditControler",   limit: nil
    t.datetime "EditDeadline"
    t.boolean  "EditToRead"
    t.text     "EditComments"
  end

  add_index "dvtable_{25fd515b-eb74-4ae3-92f6-3397e31cf2cb}_archive", ["InstanceID"], name: "dvsys_directivecard_assignmentedit_archive_uc_struct", unique: true

  create_table "dvtable_{2695bb57-67eb-48b9-b05c-1ff8b7c078c6}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ApprovalID",      limit: nil
  end

  add_index "dvtable_{2695bb57-67eb-48b9-b05c-1ff8b7c078c6}", ["InstanceID"], name: "dvsys_cardapproval_approvals_section"

  create_table "dvtable_{2695bb57-67eb-48b9-b05c-1ff8b7c078c6}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ApprovalID",      limit: nil
  end

  add_index "dvtable_{2695bb57-67eb-48b9-b05c-1ff8b7c078c6}_archive", ["InstanceID"], name: "dvsys_cardapproval_approvals_archive_section"

  create_table "dvtable_{26f95c5a-9815-4a6e-8185-2944b032eca5}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Name",            limit: 128
    t.text    "QueryText"
    t.string  "OpenMode",        limit: nil
    t.boolean "PlaySound"
    t.string  "WavPath",         limit: 256
    t.boolean "ChangeIcon"
    t.boolean "ShowMessage"
    t.boolean "ShowInfoWindow"
    t.integer "Interval"
  end

  create_table "dvtable_{26f95c5a-9815-4a6e-8185-2944b032eca5}_userdependent", id: false, force: true do |t|
    t.string  "RowID",        limit: nil, null: false
    t.string  "UserID",       limit: nil, null: false
    t.boolean "NotAvailable"
  end

  create_table "dvtable_{274df6e3-c0c1-46e9-a623-004d9d51760c}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{274df6e3-c0c1-46e9-a623-004d9d51760c}", ["InstanceID", "ParentRowID"], name: "dvsys_cardord_enumvalues_section"
  add_index "dvtable_{274df6e3-c0c1-46e9-a623-004d9d51760c}", ["ParentRowID"], name: "dvsys_cardord_enumvalues_idx_parentrowid"

  create_table "dvtable_{274df6e3-c0c1-46e9-a623-004d9d51760c}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{274df6e3-c0c1-46e9-a623-004d9d51760c}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardord_enumvalues_archive_section"
  add_index "dvtable_{274df6e3-c0c1-46e9-a623-004d9d51760c}_archive", ["ParentRowID"], name: "dvsys_cardord_enumvalues_archive_idx_parentrowid"

  create_table "dvtable_{2750c70b-0992-456b-ab3a-98ad11e99a94}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Comment",         limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.integer  "Cycle"
  end

  add_index "dvtable_{2750c70b-0992-456b-ab3a-98ad11e99a94}", ["InstanceID"], name: "dvsys_cardapproval_comments_section"

  create_table "dvtable_{2750c70b-0992-456b-ab3a-98ad11e99a94}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Comment",         limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.integer  "Cycle"
  end

  add_index "dvtable_{2750c70b-0992-456b-ab3a-98ad11e99a94}_archive", ["InstanceID"], name: "dvsys_cardapproval_comments_archive_section"

  create_table "dvtable_{2cd4b3eb-6190-4825-b1c0-48ed20cf0840}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "RefType"
    t.string  "RefID",           limit: nil
    t.string  "RefURL",          limit: 4000
    t.boolean "ReadOnly"
    t.string  "Comment",         limit: 2048
    t.string  "RefCardID",       limit: nil
    t.string  "RefFolderID",     limit: nil
    t.boolean "IsParentRef"
  end

  add_index "dvtable_{2cd4b3eb-6190-4825-b1c0-48ed20cf0840}", ["InstanceID"], name: "dvsys_cardresolution_references_section"

  create_table "dvtable_{2cd4b3eb-6190-4825-b1c0-48ed20cf0840}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "RefType"
    t.string  "RefID",           limit: nil
    t.string  "RefURL",          limit: 4000
    t.boolean "ReadOnly"
    t.string  "Comment",         limit: 2048
    t.string  "RefCardID",       limit: nil
    t.string  "RefFolderID",     limit: nil
    t.boolean "IsParentRef"
  end

  add_index "dvtable_{2cd4b3eb-6190-4825-b1c0-48ed20cf0840}_archive", ["InstanceID"], name: "dvsys_cardresolution_references_archive_section"

  create_table "dvtable_{2da5de1e-5e0a-4346-85ae-a85309230991}", id: false, force: true do |t|
    t.string  "RowID",                    limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",              limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                     limit: nil
    t.string  "IncDocNumerator",          limit: nil
    t.string  "IncDocBPTemplate",         limit: nil
    t.string  "IncDocBPStartingFolder",   limit: nil
    t.string  "IncDocBPInstanceFolder",   limit: nil
    t.string  "IncDocFolder",             limit: nil
    t.string  "IncDocPrintTemplate",      limit: nil
    t.string  "IncDocReceiptKindRef",     limit: nil
    t.string  "IncDocReceiptKindDefault", limit: nil
    t.string  "IncDocAppealNumerator",    limit: nil
    t.integer "BarcodeRegDataIndentX"
    t.integer "BarcodeRegDataIndentY"
    t.boolean "IncDocNoApproving"
  end

  add_index "dvtable_{2da5de1e-5e0a-4346-85ae-a85309230991}", ["InstanceID"], name: "dvsys_refdocsetup_incdocsetup_uc_struct", unique: true

  create_table "dvtable_{2dec53a1-850a-4af5-bd07-d6149e4199be}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Person",          limit: nil
    t.text     "Comments"
    t.datetime "Date"
    t.integer  "Resolution"
    t.string   "TaskID",          limit: nil
  end

  add_index "dvtable_{2dec53a1-850a-4af5-bd07-d6149e4199be}", ["InstanceID"], name: "dvsys_memorandumcard_approvalhistory_section"

  create_table "dvtable_{2dec53a1-850a-4af5-bd07-d6149e4199be}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Person",          limit: nil
    t.text     "Comments"
    t.datetime "Date"
    t.integer  "Resolution"
    t.string   "TaskID",          limit: nil
  end

  add_index "dvtable_{2dec53a1-850a-4af5-bd07-d6149e4199be}_archive", ["InstanceID"], name: "dvsys_memorandumcard_approvalhistory_archive_section"

  create_table "dvtable_{2df0d5d5-9c4a-4c34-aab9-b3826d4d95df}", id: false, force: true do |t|
    t.string "RowID",                limit: nil,                                                   null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",           limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",          limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                 limit: nil
    t.string "BankName",             limit: 128
    t.string "Account",              limit: 128
    t.string "CorrespondentAccount", limit: 128
    t.string "BIK",                  limit: 128
    t.string "Comments",             limit: 1024
  end

  add_index "dvtable_{2df0d5d5-9c4a-4c34-aab9-b3826d4d95df}", ["ParentRowID"], name: "dvsys_refpartners_bankaccounts_section"

# Could not dump table "dvtable_{2e37cb3d-07d7-4bc9-a44b-ff826b3db697}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{2e37cb3d-07d7-4bc9-a44b-ff826b3db697}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{2e9c5799-3ae7-4164-bc9c-de18c4ccaf71}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Department"
    t.string   "Approver",        limit: nil
    t.datetime "StartDate"
    t.datetime "ApprovingDate"
    t.integer  "Decision"
    t.integer  "Order"
    t.string   "Officer",         limit: nil
    t.integer  "ApprovingTime"
    t.text     "Comment"
    t.boolean  "IsFromTemplate"
  end

  add_index "dvtable_{2e9c5799-3ae7-4164-bc9c-de18c4ccaf71}", ["InstanceID", "ParentRowID"], name: "dvsys_directioncard_approvals_section"
  add_index "dvtable_{2e9c5799-3ae7-4164-bc9c-de18c4ccaf71}", ["ParentRowID"], name: "dvsys_directioncard_approvals_idx_parentrowid"

  create_table "dvtable_{2e9c5799-3ae7-4164-bc9c-de18c4ccaf71}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Department"
    t.string   "Approver",        limit: nil
    t.datetime "StartDate"
    t.datetime "ApprovingDate"
    t.integer  "Decision"
    t.integer  "Order"
    t.string   "Officer",         limit: nil
    t.integer  "ApprovingTime"
    t.text     "Comment"
    t.boolean  "IsFromTemplate"
  end

  add_index "dvtable_{2e9c5799-3ae7-4164-bc9c-de18c4ccaf71}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_directioncard_approvals_archive_section"
  add_index "dvtable_{2e9c5799-3ae7-4164-bc9c-de18c4ccaf71}_archive", ["ParentRowID"], name: "dvsys_directioncard_approvals_archive_idx_parentrowid"

  create_table "dvtable_{2ea98488-434c-4f71-8105-d137a5f88f72}", id: false, force: true do |t|
    t.string  "RowID",                       limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                        limit: nil
    t.string  "Name"
    t.boolean "NotAvailable"
    t.boolean "AllowEditFirst"
    t.boolean "AllowEditLast"
    t.boolean "AllowEditOrdinary"
    t.boolean "AllowAdding"
    t.boolean "AllowParallelReconciliation"
  end

  add_index "dvtable_{2ea98488-434c-4f71-8105-d137a5f88f72}", ["ParentRowID"], name: "dvsys_refroutes_routes_section"

  create_table "dvtable_{2f43792d-a3b0-4c12-b4da-cc5bbe263069}", id: false, force: true do |t|
    t.string  "RowID",                           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",                     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                            limit: nil
    t.string  "ITRole",                          limit: nil
    t.string  "NotifyProcess",                   limit: nil
    t.string  "AdminTimekeeper",                 limit: nil
    t.string  "Timekeeper",                      limit: nil
    t.integer "MaxAppMemory",                                default: 150
    t.string  "ExecuterChangeNotify",            limit: nil
    t.string  "ExecuterChangeStartingFolder",    limit: nil
    t.string  "ExecuterChangeInstanceFolder",    limit: nil
    t.integer "NoApprovingCardRegistrationType"
    t.boolean "RegistredOnExit"
    t.boolean "SendTaskByMail"
    t.string  "ForcibleCardRightsBP",            limit: nil
    t.string  "EmptyFolder",                     limit: nil
  end

  add_index "dvtable_{2f43792d-a3b0-4c12-b4da-cc5bbe263069}", ["InstanceID"], name: "dvsys_refdocsetup_generalsetup_uc_struct", unique: true

  create_table "dvtable_{2f443cef-bc72-4853-89e6-34d59a63e49f}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "Name",            limit: 32
    t.string "AlternativeName", limit: 32
    t.string "NameUID",         limit: nil
  end

  add_index "dvtable_{2f443cef-bc72-4853-89e6-34d59a63e49f}", ["Name", "NameUID"], name: "dvsys_refpartners_titles_uc_global_name", unique: true

  create_table "dvtable_{2f6c3b93-8e02-4ada-8afb-e3f5a369dd45}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "Date"
    t.string   "Person",          limit: nil
    t.text     "Comment"
    t.integer  "HistoryType"
  end

  add_index "dvtable_{2f6c3b93-8e02-4ada-8afb-e3f5a369dd45}", ["InstanceID"], name: "dvsys_durableassignmentcard_history_section"

  create_table "dvtable_{2f6c3b93-8e02-4ada-8afb-e3f5a369dd45}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "Date"
    t.string   "Person",          limit: nil
    t.text     "Comment"
    t.integer  "HistoryType"
  end

  add_index "dvtable_{2f6c3b93-8e02-4ada-8afb-e3f5a369dd45}_archive", ["InstanceID"], name: "dvsys_durableassignmentcard_history_archive_section"

  create_table "dvtable_{2fde03c2-ff87-4e42-a8c2-7ced181977fb}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Name",            limit: 256
    t.string  "ParentCardID",    limit: nil
    t.string  "CurrentID",       limit: nil
    t.integer "NextVersion"
    t.string  "CheckoutPath",    limit: 1024
    t.string  "CurrentVersion",  limit: 256
    t.string  "CheckoutUserID",  limit: nil
    t.string  "ExtCardID",       limit: nil
    t.string  "BarCode",         limit: 2048
  end

  add_index "dvtable_{2fde03c2-ff87-4e42-a8c2-7ced181977fb}", ["InstanceID"], name: "dvsys_versionedfilecard_maininfo_uc_struct", unique: true

  create_table "dvtable_{2fde03c2-ff87-4e42-a8c2-7ced181977fb}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Name",            limit: 256
    t.string  "ParentCardID",    limit: nil
    t.string  "CurrentID",       limit: nil
    t.integer "NextVersion"
    t.string  "CheckoutPath",    limit: 1024
    t.string  "CurrentVersion",  limit: 256
    t.string  "CheckoutUserID",  limit: nil
    t.string  "ExtCardID",       limit: nil
    t.string  "BarCode",         limit: 2048
  end

  add_index "dvtable_{2fde03c2-ff87-4e42-a8c2-7ced181977fb}_archive", ["InstanceID"], name: "dvsys_versionedfilecard_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{2ff80229-7ccb-4721-bd09-d1e08547e580}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Assignee",        limit: nil
    t.string "AssignmentID",    limit: nil
  end

  add_index "dvtable_{2ff80229-7ccb-4721-bd09-d1e08547e580}", ["InstanceID", "ParentRowID"], name: "dvsys_directivecard_assignees_section"
  add_index "dvtable_{2ff80229-7ccb-4721-bd09-d1e08547e580}", ["ParentRowID"], name: "dvsys_directivecard_assignees_idx_parentrowid"

  create_table "dvtable_{2ff80229-7ccb-4721-bd09-d1e08547e580}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Assignee",        limit: nil
    t.string "AssignmentID",    limit: nil
  end

  add_index "dvtable_{2ff80229-7ccb-4721-bd09-d1e08547e580}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_directivecard_assignees_archive_section"
  add_index "dvtable_{2ff80229-7ccb-4721-bd09-d1e08547e580}_archive", ["ParentRowID"], name: "dvsys_directivecard_assignees_archive_idx_parentrowid"

  create_table "dvtable_{30b22ed4-74f4-400c-9033-78f5aed3cec7}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "RestrictKind"
    t.string "Numerator",       limit: nil
  end

  add_index "dvtable_{30b22ed4-74f4-400c-9033-78f5aed3cec7}", ["ParentRowID"], name: "dvsys_refdocsetup_outdocrestrictedkinds_section"

  create_table "dvtable_{31144de1-33df-4ec0-b9e5-9317e91f4137}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Event"
    t.integer "EmployeeType"
    t.string  "Comments",        limit: 3900
    t.string  "Author",          limit: nil
    t.boolean "Disabled"
  end

  add_index "dvtable_{31144de1-33df-4ec0-b9e5-9317e91f4137}", ["InstanceID"], name: "dvsys_cardapproval_notifications_section"

  create_table "dvtable_{31144de1-33df-4ec0-b9e5-9317e91f4137}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Event"
    t.integer "EmployeeType"
    t.string  "Comments",        limit: 3900
    t.string  "Author",          limit: nil
    t.boolean "Disabled"
  end

  add_index "dvtable_{31144de1-33df-4ec0-b9e5-9317e91f4137}_archive", ["InstanceID"], name: "dvsys_cardapproval_notifications_archive_section"

  create_table "dvtable_{312b571d-1ca5-400c-ae99-00b16921cf12}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ApprovalID",      limit: nil
  end

  add_index "dvtable_{312b571d-1ca5-400c-ae99-00b16921cf12}", ["InstanceID"], name: "dvsys_carduni_approvals_section"

  create_table "dvtable_{312b571d-1ca5-400c-ae99-00b16921cf12}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ApprovalID",      limit: nil
  end

  add_index "dvtable_{312b571d-1ca5-400c-ae99-00b16921cf12}_archive", ["InstanceID"], name: "dvsys_carduni_approvals_archive_section"

  create_table "dvtable_{31f76440-7999-47c6-8530-4b7435e8eb84}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "RefID",           limit: nil
    t.integer "RefType"
    t.boolean "ReadOnly"
  end

  add_index "dvtable_{31f76440-7999-47c6-8530-4b7435e8eb84}", ["ParentRowID"], name: "dvsys_reftypes_tabrights_section"

  create_table "dvtable_{3228aa12-a828-473a-a093-265711bb1d3f}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "Order"
    t.string  "FieldName",       limit: 128
    t.boolean "FirstLetterOnly"
  end

  create_table "dvtable_{32dc8d5c-46ee-4eca-86fd-fab43898a1f9}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean "Value"
  end

  add_index "dvtable_{32dc8d5c-46ee-4eca-86fd-fab43898a1f9}", ["InstanceID"], name: "dvsys_settings_usersettings_uc_struct", unique: true

  create_table "dvtable_{32dc8d5c-46ee-4eca-86fd-fab43898a1f9}_userdependent", id: false, force: true do |t|
    t.string  "RowID",                  limit: nil,                null: false
    t.string  "UserID",                 limit: nil,                null: false
    t.boolean "ShowExportDialog",                   default: true
    t.boolean "ShowImportDialog",                   default: true
    t.boolean "ExportWithSubprocesses",             default: true
    t.boolean "ImportWithSubprocesses",             default: true
  end

  create_table "dvtable_{3361b8cd-b023-4f8b-9cb5-891d626ef299}", id: false, force: true do |t|
    t.string "RowID",            limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",             limit: nil
    t.string "ContractODPerson", limit: nil
  end

  add_index "dvtable_{3361b8cd-b023-4f8b-9cb5-891d626ef299}", ["ParentRowID"], name: "dvsys_refdocsetup_contractodpersons_section"

  create_table "dvtable_{33b49d2a-5a74-4ac6-b001-b463839b7d5c}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "DepartmentID",    limit: nil
    t.string "DepartmentIDUID", limit: nil
  end

  add_index "dvtable_{33b49d2a-5a74-4ac6-b001-b463839b7d5c}", ["DepartmentID", "ParentRowID", "DepartmentIDUID"], name: "dvsys_refpartners_group_uc_section_departmentid", unique: true
  add_index "dvtable_{33b49d2a-5a74-4ac6-b001-b463839b7d5c}", ["ParentRowID"], name: "dvsys_refpartners_group_section"

  create_table "dvtable_{340acd6f-6001-4c40-8b9f-55cc74127313}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "HistoryKind"
    t.string   "Person",          limit: nil
    t.text     "Comments"
    t.datetime "Date"
    t.string   "TaskID",          limit: nil
  end

  add_index "dvtable_{340acd6f-6001-4c40-8b9f-55cc74127313}", ["InstanceID"], name: "dvsys_directioncard_approvalhistory_section"

  create_table "dvtable_{340acd6f-6001-4c40-8b9f-55cc74127313}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "HistoryKind"
    t.string   "Person",          limit: nil
    t.text     "Comments"
    t.datetime "Date"
    t.string   "TaskID",          limit: nil
  end

  add_index "dvtable_{340acd6f-6001-4c40-8b9f-55cc74127313}_archive", ["InstanceID"], name: "dvsys_directioncard_approvalhistory_archive_section"

  create_table "dvtable_{342f9e28-485e-49a3-b13c-0393fc4e11cf}", id: false, force: true do |t|
    t.string "RowID",             limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",              limit: nil
    t.string "DirectiveEmployee", limit: nil
  end

  add_index "dvtable_{342f9e28-485e-49a3-b13c-0393fc4e11cf}", ["ParentRowID"], name: "dvsys_refdocsetup_directiveregistrators_section"

  create_table "dvtable_{359380d1-dac0-4af7-9282-98c4d3376796}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "OutDocField"
    t.text    "OutDocPrintTag"
  end

  add_index "dvtable_{359380d1-dac0-4af7-9282-98c4d3376796}", ["ParentRowID"], name: "dvsys_refdocsetup_outdocprintcolumns_section"

  create_table "dvtable_{367a6b04-4d4e-4f49-bd0d-3857e9d7fa07}", id: false, force: true do |t|
    t.string "RowID",            limit: nil,                                                   null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",       limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",  limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Recipient",        limit: nil
    t.string "RecipientOrgID",   limit: nil
    t.string "RecipientDepID",   limit: nil
    t.string "RecipientOrg",     limit: 1024
    t.string "RecipientDep",     limit: 1024
    t.string "RecipientPhone",   limit: 64
    t.string "RecipientEmail",   limit: 64
    t.string "RecipientName",    limit: 128
    t.string "RecipientAddress", limit: 1280
    t.string "IncomingNumber",   limit: 80
  end

  add_index "dvtable_{367a6b04-4d4e-4f49-bd0d-3857e9d7fa07}", ["InstanceID"], name: "dvsys_cardout_recipients_section"

  create_table "dvtable_{367a6b04-4d4e-4f49-bd0d-3857e9d7fa07}_archive", id: false, force: true do |t|
    t.string "RowID",            limit: nil,                                                   null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",       limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",  limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Recipient",        limit: nil
    t.string "RecipientOrgID",   limit: nil
    t.string "RecipientDepID",   limit: nil
    t.string "RecipientOrg",     limit: 1024
    t.string "RecipientDep",     limit: 1024
    t.string "RecipientPhone",   limit: 64
    t.string "RecipientEmail",   limit: 64
    t.string "RecipientName",    limit: 128
    t.string "RecipientAddress", limit: 1280
    t.string "IncomingNumber",   limit: 80
  end

  add_index "dvtable_{367a6b04-4d4e-4f49-bd0d-3857e9d7fa07}_archive", ["InstanceID"], name: "dvsys_cardout_recipients_archive_section"

  create_table "dvtable_{375a0577-ad33-4455-958a-d001915769d9}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text   "Value"
  end

  add_index "dvtable_{375a0577-ad33-4455-958a-d001915769d9}", ["InstanceID", "ParentRowID"], name: "dvsys_process_sparedvalues_uc_struct", unique: true
  add_index "dvtable_{375a0577-ad33-4455-958a-d001915769d9}", ["ParentRowID"], name: "dvsys_process_sparedvalues_idx_parentrowid"

  create_table "dvtable_{375a0577-ad33-4455-958a-d001915769d9}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text   "Value"
  end

  add_index "dvtable_{375a0577-ad33-4455-958a-d001915769d9}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_process_sparedvalues_archive_uc_struct", unique: true
  add_index "dvtable_{375a0577-ad33-4455-958a-d001915769d9}_archive", ["ParentRowID"], name: "dvsys_process_sparedvalues_archive_idx_parentrowid"

  create_table "dvtable_{37e44e13-884e-4ac2-8b60-9e4b4fbd48b4}", id: false, force: true do |t|
    t.string   "RowID",                    limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",              limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "AssignmentID",             limit: nil
    t.string   "AssignmentControler",      limit: nil
    t.datetime "AssignmentDeadline"
    t.boolean  "AssignmentToRead"
    t.text     "AssignmentComments"
    t.datetime "AssignmentCompletionDate"
  end

  add_index "dvtable_{37e44e13-884e-4ac2-8b60-9e4b4fbd48b4}", ["InstanceID"], name: "dvsys_ordercard_assignments_section"

  create_table "dvtable_{37e44e13-884e-4ac2-8b60-9e4b4fbd48b4}_archive", id: false, force: true do |t|
    t.string   "RowID",                    limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",              limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "AssignmentID",             limit: nil
    t.string   "AssignmentControler",      limit: nil
    t.datetime "AssignmentDeadline"
    t.boolean  "AssignmentToRead"
    t.text     "AssignmentComments"
    t.datetime "AssignmentCompletionDate"
  end

  add_index "dvtable_{37e44e13-884e-4ac2-8b60-9e4b4fbd48b4}_archive", ["InstanceID"], name: "dvsys_ordercard_assignments_archive_section"

  create_table "dvtable_{37fcf8f2-0d29-4e9f-a61d-3ca5fe1a8404}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Name",            limit: 2048
    t.string  "AssemblyID",      limit: nil
    t.boolean "AddInNewProcess"
  end

  create_table "dvtable_{388f390f-139e-498e-a461-a24fba160487}", id: false, force: true do |t|
    t.string   "RowID",            limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "FunctionName",     limit: 128
    t.string   "ChangeState",      limit: 128
    t.datetime "MessageDate"
    t.text     "Action"
    t.text     "InputParameters"
    t.text     "OutputParameters"
    t.integer  "Priority",                     default: 0
    t.integer  "ActionType"
    t.text     "Message"
  end

  add_index "dvtable_{388f390f-139e-498e-a461-a24fba160487}", ["InstanceID"], name: "dvsys_process_log_section"

  create_table "dvtable_{388f390f-139e-498e-a461-a24fba160487}_archive", id: false, force: true do |t|
    t.string   "RowID",            limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "FunctionName",     limit: 128
    t.string   "ChangeState",      limit: 128
    t.datetime "MessageDate"
    t.text     "Action"
    t.text     "InputParameters"
    t.text     "OutputParameters"
    t.integer  "Priority"
    t.integer  "ActionType"
    t.text     "Message"
  end

  add_index "dvtable_{388f390f-139e-498e-a461-a24fba160487}_archive", ["InstanceID"], name: "dvsys_process_log_archive_section"

  create_table "dvtable_{38aec979-b295-42e5-851a-7f839b7cda66}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ApprovalID",      limit: nil
  end

  add_index "dvtable_{38aec979-b295-42e5-851a-7f839b7cda66}", ["InstanceID"], name: "dvsys_cardout_approvals_section"

  create_table "dvtable_{38aec979-b295-42e5-851a-7f839b7cda66}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ApprovalID",      limit: nil
  end

  add_index "dvtable_{38aec979-b295-42e5-851a-7f839b7cda66}_archive", ["InstanceID"], name: "dvsys_cardout_approvals_archive_section"

  create_table "dvtable_{39177bdc-8180-4440-b2fc-ee8612169adb}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SectionName",     limit: 128
    t.boolean "IsTable"
    t.integer "Left"
    t.integer "Top"
    t.integer "Width"
    t.integer "Height"
    t.integer "Page"
    t.integer "ChLeft"
    t.integer "ChTop"
    t.integer "ChWidth"
    t.integer "ChHeight"
    t.integer "ChPage"
  end

  add_index "dvtable_{39177bdc-8180-4440-b2fc-ee8612169adb}", ["ParentRowID"], name: "dvsys_refstaff_tabsections_section"

  create_table "dvtable_{39e04bfc-4fcc-421c-aba2-84173090175e}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Caption",         limit: 32
    t.integer "Order"
    t.integer "Width"
    t.integer "RowAlign"
    t.integer "HeaderAlign"
    t.string  "ColumnName",      limit: 32
    t.boolean "LongDate"
    t.string  "DateFormat",      limit: 64,  default: "General Date"
    t.boolean "Hidden"
    t.integer "Flags"
  end

  add_index "dvtable_{39e04bfc-4fcc-421c-aba2-84173090175e}", ["ParentRowID"], name: "dvsys_navigatorcard_columnsettings_section"

  create_table "dvtable_{3b588032-18fc-4a50-a6ff-6bee45a1c701}", id: false, force: true do |t|
    t.string  "RowID",             limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "FieldAlias",        limit: 128
    t.boolean "Hidden"
    t.boolean "ReadOnly"
    t.boolean "Required"
    t.string  "DefaultValue",      limit: 512
    t.boolean "CopyFromParent"
    t.integer "CopyFrom"
    t.boolean "SetNull"
    t.string  "LabelName",         limit: 64
    t.boolean "CreationReadOnly"
    t.text    "ValueChangeScript"
    t.string  "FontName",          limit: 128
    t.integer "FontSize"
    t.boolean "FontBold"
    t.boolean "FontItalic"
    t.integer "FontColor"
    t.integer "FontCharset"
    t.string  "CopyPropertyName",  limit: 128
    t.string  "FieldAliasUID",     limit: nil
  end

  add_index "dvtable_{3b588032-18fc-4a50-a6ff-6bee45a1c701}", ["FieldAlias", "ParentRowID", "FieldAliasUID"], name: "dvsys_reftypes_cardfields_uc_section_fieldalias", unique: true
  add_index "dvtable_{3b588032-18fc-4a50-a6ff-6bee45a1c701}", ["ParentRowID"], name: "dvsys_reftypes_cardfields_section"

  create_table "dvtable_{3c2f1ac3-8d26-425f-956b-a3b0b52bac5d}", id: false, force: true do |t|
    t.string   "RowID",                      limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                 limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",                limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",            limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",                       limit: 544
    t.string   "Type",                       limit: nil
    t.string   "CreatedBy",                  limit: nil
    t.datetime "CreationDate"
    t.string   "InitiatedBy",                limit: nil
    t.integer  "DocumentState",                           default: 0
    t.integer  "ApprovalState"
    t.boolean  "IsOwnProcess"
    t.string   "ProcessFolder",              limit: nil
    t.integer  "PollingInterval"
    t.string   "ParentCardID",               limit: nil
    t.string   "ParentName",                 limit: 512
    t.string   "ParentTypeID",               limit: nil
    t.string   "ParentNumber",               limit: 160
    t.datetime "ParentRegDate"
    t.datetime "ParentCreationDate"
    t.integer  "DefaultApproverDuration"
    t.boolean  "DefaultCanModifyFiles"
    t.string   "DefaultResultFolder",        limit: nil
    t.boolean  "DefaultViewRights"
    t.string   "DefaultApproverComments",    limit: 2048
    t.boolean  "DefaultNotApprovedDisabled"
    t.string   "FilesID",                    limit: nil
    t.string   "CreatedByPositionID",        limit: nil
    t.string   "InitiatedByPositionID",      limit: nil
    t.string   "CreatedByDepartmentID",      limit: nil
    t.string   "InitiatedByDepartmentID",    limit: nil
    t.integer  "ConsolidatedCreation"
    t.boolean  "SendAsHTML"
  end

  add_index "dvtable_{3c2f1ac3-8d26-425f-956b-a3b0b52bac5d}", ["InstanceID"], name: "dvsys_cardapproval_maininfo_uc_struct", unique: true

  create_table "dvtable_{3c2f1ac3-8d26-425f-956b-a3b0b52bac5d}_archive", id: false, force: true do |t|
    t.string   "RowID",                      limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                 limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",                limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",            limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",                       limit: 544
    t.string   "Type",                       limit: nil
    t.string   "CreatedBy",                  limit: nil
    t.datetime "CreationDate"
    t.string   "InitiatedBy",                limit: nil
    t.integer  "DocumentState"
    t.integer  "ApprovalState"
    t.boolean  "IsOwnProcess"
    t.string   "ProcessFolder",              limit: nil
    t.integer  "PollingInterval"
    t.string   "ParentCardID",               limit: nil
    t.string   "ParentName",                 limit: 512
    t.string   "ParentTypeID",               limit: nil
    t.string   "ParentNumber",               limit: 160
    t.datetime "ParentRegDate"
    t.datetime "ParentCreationDate"
    t.integer  "DefaultApproverDuration"
    t.boolean  "DefaultCanModifyFiles"
    t.string   "DefaultResultFolder",        limit: nil
    t.boolean  "DefaultViewRights"
    t.string   "DefaultApproverComments",    limit: 2048
    t.boolean  "DefaultNotApprovedDisabled"
    t.string   "FilesID",                    limit: nil
    t.string   "CreatedByPositionID",        limit: nil
    t.string   "InitiatedByPositionID",      limit: nil
    t.string   "CreatedByDepartmentID",      limit: nil
    t.string   "InitiatedByDepartmentID",    limit: nil
    t.integer  "ConsolidatedCreation"
    t.boolean  "SendAsHTML"
  end

  add_index "dvtable_{3c2f1ac3-8d26-425f-956b-a3b0b52bac5d}_archive", ["InstanceID"], name: "dvsys_cardapproval_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{3e200cd0-1a06-48d2-93a3-217f2cf3e7dd}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "Field1"
  end

  add_index "dvtable_{3e200cd0-1a06-48d2-93a3-217f2cf3e7dd}", ["InstanceID"], name: "dvsys_navextdurableassignmentbtn_section1_uc_struct", unique: true

  create_table "dvtable_{3e838f35-017f-423f-8373-16f087f860ab}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "EditControler",   limit: nil
    t.datetime "EditDeadline"
    t.boolean  "EditToRead"
    t.text     "EditComments"
  end

  add_index "dvtable_{3e838f35-017f-423f-8373-16f087f860ab}", ["InstanceID"], name: "dvsys_directioncard_assignmentedit_uc_struct", unique: true

  create_table "dvtable_{3e838f35-017f-423f-8373-16f087f860ab}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "EditControler",   limit: nil
    t.datetime "EditDeadline"
    t.boolean  "EditToRead"
    t.text     "EditComments"
  end

  add_index "dvtable_{3e838f35-017f-423f-8373-16f087f860ab}_archive", ["InstanceID"], name: "dvsys_directioncard_assignmentedit_archive_uc_struct", unique: true

  create_table "dvtable_{3f6225e0-4fe1-451f-bc64-ebc87be4fb83}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "ChangeDate"
    t.text     "Value"
    t.string   "Author",          limit: 256
    t.string   "Description",     limit: 2048
  end

  add_index "dvtable_{3f6225e0-4fe1-451f-bc64-ebc87be4fb83}", ["InstanceID", "ParentRowID"], name: "dvsys_process_logvalues_section"
  add_index "dvtable_{3f6225e0-4fe1-451f-bc64-ebc87be4fb83}", ["ParentRowID"], name: "dvsys_process_logvalues_idx_parentrowid"

  create_table "dvtable_{3f6225e0-4fe1-451f-bc64-ebc87be4fb83}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "ChangeDate"
    t.text     "Value"
    t.string   "Author",          limit: 256
    t.string   "Description",     limit: 2048
  end

  add_index "dvtable_{3f6225e0-4fe1-451f-bc64-ebc87be4fb83}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_process_logvalues_archive_section"
  add_index "dvtable_{3f6225e0-4fe1-451f-bc64-ebc87be4fb83}_archive", ["ParentRowID"], name: "dvsys_process_logvalues_archive_idx_parentrowid"

  create_table "dvtable_{3f8270db-3603-463c-ba59-26b89ebb6cb5}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Count",                       default: 0
  end

  add_index "dvtable_{3f8270db-3603-463c-ba59-26b89ebb6cb5}", ["InstanceID"], name: "dvsys_filelist_maininfo_uc_struct", unique: true

  create_table "dvtable_{3f8270db-3603-463c-ba59-26b89ebb6cb5}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Count"
  end

  add_index "dvtable_{3f8270db-3603-463c-ba59-26b89ebb6cb5}_archive", ["InstanceID"], name: "dvsys_filelist_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{4130f43c-6dd5-4a5b-971e-aa134f7fb2e5}", id: false, force: true do |t|
    t.string   "RowID",                      limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "DirectionProjectDate"
    t.integer  "State",                                  default: 1
    t.datetime "RegistrationDate"
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID",       limit: nil
    t.integer  "ListCount"
    t.string   "Executer",                   limit: nil
    t.string   "SignedBy",                   limit: nil
    t.text     "Subject"
    t.text     "Content"
    t.string   "CaseID",                     limit: nil
    t.string   "FileListId",                 limit: nil
    t.string   "Registrator",                limit: nil
    t.integer  "InAppendix"
    t.string   "LinksListId",                limit: nil
    t.string   "LegacySystemID",             limit: 256
    t.string   "BarcodeNumber",              limit: 40
    t.string   "BarcodeNumberID",            limit: nil
    t.string   "TransferLog",                limit: nil
    t.string   "Controller",                 limit: nil
    t.string   "SignedBy_AlternateDirector", limit: nil
    t.integer  "CopiesCount"
    t.boolean  "NoApproving"
    t.string   "ApprovalListID",             limit: nil
    t.string   "ProjectNumber"
    t.string   "ProjectNumberID",            limit: nil
    t.string   "CurrentDocTemplate",         limit: nil
    t.string   "DirectionType",              limit: nil
    t.string   "DirectionTypeText",          limit: 256
    t.string   "ExecutionProcessID",         limit: nil
  end

  add_index "dvtable_{4130f43c-6dd5-4a5b-971e-aa134f7fb2e5}", ["InstanceID"], name: "dvsys_directioncard_maininfo_uc_struct", unique: true

  create_table "dvtable_{4130f43c-6dd5-4a5b-971e-aa134f7fb2e5}_archive", id: false, force: true do |t|
    t.string   "RowID",                      limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "DirectionProjectDate"
    t.integer  "State"
    t.datetime "RegistrationDate"
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID",       limit: nil
    t.integer  "ListCount"
    t.string   "Executer",                   limit: nil
    t.string   "SignedBy",                   limit: nil
    t.text     "Subject"
    t.text     "Content"
    t.string   "CaseID",                     limit: nil
    t.string   "FileListId",                 limit: nil
    t.string   "Registrator",                limit: nil
    t.integer  "InAppendix"
    t.string   "LinksListId",                limit: nil
    t.string   "LegacySystemID",             limit: 256
    t.string   "BarcodeNumber",              limit: 40
    t.string   "BarcodeNumberID",            limit: nil
    t.string   "TransferLog",                limit: nil
    t.string   "Controller",                 limit: nil
    t.string   "SignedBy_AlternateDirector", limit: nil
    t.integer  "CopiesCount"
    t.boolean  "NoApproving"
    t.string   "ApprovalListID",             limit: nil
    t.string   "ProjectNumber"
    t.string   "ProjectNumberID",            limit: nil
    t.string   "CurrentDocTemplate",         limit: nil
    t.string   "DirectionType",              limit: nil
    t.string   "DirectionTypeText",          limit: 256
    t.string   "ExecutionProcessID",         limit: nil
  end

  add_index "dvtable_{4130f43c-6dd5-4a5b-971e-aa134f7fb2e5}_archive", ["InstanceID"], name: "dvsys_directioncard_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{41ead70b-73e9-4be9-89f8-ccd1536e9488}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CardTypeID",      limit: nil
  end

  create_table "dvtable_{42b598d5-b3f4-4349-b0e8-874edb737abe}", id: false, force: true do |t|
    t.string  "RowID",               limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",          limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",         limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Name",                limit: 64
    t.string  "ServerClass",         limit: 100
    t.string  "ServerAssembly"
    t.string  "UIClass",             limit: 100
    t.string  "ID",                  limit: nil
    t.string  "DefaultSettings",     limit: 2048
    t.boolean "AddGateInNewProcess"
  end

# Could not dump table "dvtable_{42bfbcad-0407-4452-b60d-d1195ce035a1}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{432e82d0-d10c-48d6-ba02-58820644a4a7}", id: false, force: true do |t|
    t.string  "RowID",                     limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",               limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",           limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                      limit: nil
    t.string  "OutDocSendingType",         limit: 1024
    t.boolean "OutDocAdvanceReport"
    t.text    "OutDocPrintTemplateHeader"
    t.string  "OutDocPrintTemplate",       limit: nil
  end

  create_table "dvtable_{4361851c-5ced-4582-8cd6-7ed6d84eb206}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "OutDocEmployee",  limit: nil
    t.string "OutDocPrefix",    limit: 100
  end

  add_index "dvtable_{4361851c-5ced-4582-8cd6-7ed6d84eb206}", ["ParentRowID"], name: "dvsys_refdocsetup_outdocnumberprefixes_section"

  create_table "dvtable_{43b09d13-b87f-476f-a38f-12bfb0a61a09}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "RefType"
    t.string  "RefID",           limit: nil
    t.string  "RefURL",          limit: 4000
    t.boolean "ReadOnly"
    t.string  "Comment",         limit: 2048
    t.string  "RefCardID",       limit: nil
    t.string  "RefFolderID",     limit: nil
  end

  add_index "dvtable_{43b09d13-b87f-476f-a38f-12bfb0a61a09}", ["InstanceID"], name: "dvsys_cardreport_references_section"

  create_table "dvtable_{43b09d13-b87f-476f-a38f-12bfb0a61a09}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "RefType"
    t.string  "RefID",           limit: nil
    t.string  "RefURL",          limit: 4000
    t.boolean "ReadOnly"
    t.string  "Comment",         limit: 2048
    t.string  "RefCardID",       limit: nil
    t.string  "RefFolderID",     limit: nil
  end

  add_index "dvtable_{43b09d13-b87f-476f-a38f-12bfb0a61a09}_archive", ["InstanceID"], name: "dvsys_cardreport_references_archive_section"

  create_table "dvtable_{44735520-5a51-41e0-bde7-93b2330bbb95}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "Name"
  end

  create_table "dvtable_{44aa9d10-07ba-4207-a925-f5f366659e9d}", id: false, force: true do |t|
    t.string  "RowID",                 limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                  limit: nil
    t.string  "Name",                  limit: 256
    t.boolean "DisableSubfolders"
    t.boolean "DisableCards"
    t.string  "PropCardID",            limit: nil
    t.string  "DefaultViewID",         limit: nil
    t.string  "DefaultTemplateID",     limit: nil
    t.string  "URL",                   limit: 512
    t.integer "DefaultStyle",                      default: 1
    t.binary  "Icon"
    t.boolean "EnableDigest",                      default: true
    t.boolean "EnableAutorefresh",                 default: true
    t.integer "AutorefreshTimeout"
    t.integer "ViewCycleCount"
    t.boolean "HighlightUnread",                   default: true
    t.boolean "DisablePropEdit"
    t.boolean "RestrictViews"
    t.boolean "RestrictTemplates"
    t.boolean "RestrictCardTypes"
    t.boolean "RestrictFolderTypes"
    t.boolean "CreateFolderCard"
    t.string  "FolderCardLocation",    limit: nil
    t.boolean "EnableRegularCreation"
  end

  add_index "dvtable_{44aa9d10-07ba-4207-a925-f5f366659e9d}", ["ParentTreeRowID"], name: "dvsys_foldertypescard_foldertypes_section"

  create_table "dvtable_{45197dc2-7068-475e-a6a2-790e3faa4ca9}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "RefreshRate"
    t.string  "ServiceUrl",      limit: 256
  end

  add_index "dvtable_{45197dc2-7068-475e-a6a2-790e3faa4ca9}", ["InstanceID"], name: "dvsys_monitor_maininfo_uc_struct", unique: true

  create_table "dvtable_{45197dc2-7068-475e-a6a2-790e3faa4ca9}_userdependent", id: false, force: true do |t|
    t.string  "RowID",        limit: nil, null: false
    t.string  "UserID",       limit: nil, null: false
    t.boolean "ShowActive"
    t.boolean "ShowPaused"
    t.boolean "ShowFinished"
    t.boolean "ShowStopped"
    t.boolean "ShowFailed"
  end

# Could not dump table "dvtable_{452d97c9-0699-4915-b962-513053e90c72}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{452d97c9-0699-4915-b962-513053e90c72}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{462d029f-de3c-4945-9f41-481db3019d49}", id: false, force: true do |t|
    t.string "RowID",            limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",             limit: nil
    t.string "OrderEmployee_OD", limit: nil
  end

  add_index "dvtable_{462d029f-de3c-4945-9f41-481db3019d49}", ["ParentRowID"], name: "dvsys_refdocsetup_orderemployees_od_section"

  create_table "dvtable_{46bf1886-ce77-471c-95dc-560f5d952b82}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ViewID",          limit: nil
    t.string "AccessID",        limit: nil
  end

  add_index "dvtable_{46bf1886-ce77-471c-95dc-560f5d952b82}", ["ParentRowID"], name: "dvsys_foldertypescard_allowedviews_section"

  create_table "dvtable_{47c41171-9c64-450a-a3a6-102b3156ad79}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "EmployeeID",      limit: nil
    t.integer "Type"
    t.boolean "IsResponsible"
    t.string  "DepartmentID",    limit: nil
    t.string  "PositionID",      limit: nil
  end

  add_index "dvtable_{47c41171-9c64-450a-a3a6-102b3156ad79}", ["InstanceID"], name: "dvsys_cardinc_employees_section"

  create_table "dvtable_{47c41171-9c64-450a-a3a6-102b3156ad79}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "EmployeeID",      limit: nil
    t.integer "Type"
    t.boolean "IsResponsible"
    t.string  "DepartmentID",    limit: nil
    t.string  "PositionID",      limit: nil
  end

  add_index "dvtable_{47c41171-9c64-450a-a3a6-102b3156ad79}_archive", ["InstanceID"], name: "dvsys_cardinc_employees_archive_section"

  create_table "dvtable_{48402358-3ad4-41d4-a29b-e4ddd57da23c}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Name",            limit: 128
    t.text   "Text"
    t.string "NameUID",         limit: nil
  end

  add_index "dvtable_{48402358-3ad4-41d4-a29b-e4ddd57da23c}", ["Name", "ParentRowID", "NameUID"], name: "dvsys_savedviewcard_virtualfields_uc_section_name", unique: true
  add_index "dvtable_{48402358-3ad4-41d4-a29b-e4ddd57da23c}", ["ParentRowID"], name: "dvsys_savedviewcard_virtualfields_section"

  create_table "dvtable_{484b4e25-87dd-4267-8b7e-acb8598374bb}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{484b4e25-87dd-4267-8b7e-acb8598374bb}", ["CategoryID", "InstanceID", "CategoryIDUID"], name: "dvsys_cardresolution_categories_uc_card_categoryid", unique: true
  add_index "dvtable_{484b4e25-87dd-4267-8b7e-acb8598374bb}", ["InstanceID"], name: "dvsys_cardresolution_categories_section"

  create_table "dvtable_{484b4e25-87dd-4267-8b7e-acb8598374bb}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{484b4e25-87dd-4267-8b7e-acb8598374bb}_archive", ["InstanceID"], name: "dvsys_cardresolution_categories_archive_section"

  create_table "dvtable_{49834b18-d90d-4e87-8118-735a5ab1e998}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "FromEmployee",    limit: nil
    t.string   "ToEmployee",      limit: nil
    t.datetime "TransferDate"
    t.datetime "DueDate"
    t.integer  "State"
    t.string   "AssignmentID",    limit: nil
  end

  add_index "dvtable_{49834b18-d90d-4e87-8118-735a5ab1e998}", ["InstanceID"], name: "dvsys_transferlogcard_transferlog_section"

  create_table "dvtable_{49ad5a2d-17ec-46e2-a49e-c58d0bbd9c1a}", id: false, force: true do |t|
    t.string  "RowID",              limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",         limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",        limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",    limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",               limit: nil
    t.string  "Name",               limit: 128
    t.integer "Category"
    t.string  "Description",        limit: 1024
    t.boolean "NotAvailable",                    default: false
    t.string  "SyncTag",            limit: 256
    t.boolean "IsDefault"
    t.integer "DocumentType"
    t.integer "Order"
    t.integer "VersioningType"
    t.boolean "LockVersioning"
    t.boolean "CopyParentFiles"
    t.boolean "FieldsToFile"
    t.boolean "FileToFields"
    t.boolean "NoPropsToFile"
    t.boolean "NoFileToProps"
    t.boolean "LightFormDefault",                default: true
    t.boolean "NoWarning"
    t.boolean "FormModeOnly"
    t.boolean "PropsReadOnly"
    t.integer "Left"
    t.integer "Top"
    t.integer "Width"
    t.integer "Height"
    t.boolean "SelectOnClose"
    t.string  "CardTypeID",         limit: nil
    t.boolean "DefaultOpenFile"
    t.string  "TemplateID",         limit: nil
    t.integer "NewResolutionType"
    t.binary  "Icon"
    t.boolean "AppParentRefs"
    t.boolean "AppParentDoc"
    t.boolean "FileOpenDialog"
    t.integer "FileRights"
    t.boolean "LockCurrentVersion"
    t.integer "SaveVersion"
    t.boolean "FileSelectDialog"
    t.integer "MaxFileNumber"
    t.string  "ScriptProtect",      limit: 1024
    t.boolean "DisableChildMenu"
  end

  add_index "dvtable_{49ad5a2d-17ec-46e2-a49e-c58d0bbd9c1a}", ["ParentTreeRowID"], name: "dvsys_reftypes_documenttypes_section"

  create_table "dvtable_{49ad8abd-db45-44c2-bbe6-bc767aa3f6d7}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text   "Value"
  end

  add_index "dvtable_{49ad8abd-db45-44c2-bbe6-bc767aa3f6d7}", ["InstanceID", "ParentRowID"], name: "dvsys_process_sparedvalue_uc_struct", unique: true
  add_index "dvtable_{49ad8abd-db45-44c2-bbe6-bc767aa3f6d7}", ["ParentRowID"], name: "dvsys_process_sparedvalue_idx_parentrowid"

  create_table "dvtable_{49ad8abd-db45-44c2-bbe6-bc767aa3f6d7}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text   "Value"
  end

  add_index "dvtable_{49ad8abd-db45-44c2-bbe6-bc767aa3f6d7}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_process_sparedvalue_archive_uc_struct", unique: true
  add_index "dvtable_{49ad8abd-db45-44c2-bbe6-bc767aa3f6d7}_archive", ["ParentRowID"], name: "dvsys_process_sparedvalue_archive_idx_parentrowid"

  create_table "dvtable_{49fddd5c-7742-45a9-b65e-8f5bc35b9ff4}", id: false, force: true do |t|
    t.string "RowID",              limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",    limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",               limit: nil
    t.string "OrderTypeName",      limit: 256
    t.string "OrderTypeNumerator", limit: nil
  end

  add_index "dvtable_{49fddd5c-7742-45a9-b65e-8f5bc35b9ff4}", ["ParentRowID"], name: "dvsys_refdocsetup_ordertypesnumerators_section"

  create_table "dvtable_{4a40ae5b-e445-4d3f-af34-04a0be696200}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "NameCase"
    t.string  "FirstName",       limit: 32
    t.string  "MiddleName",      limit: 32
    t.string  "LastName",        limit: 32
  end

  add_index "dvtable_{4a40ae5b-e445-4d3f-af34-04a0be696200}", ["ParentRowID"], name: "dvsys_refstaff_namecases_section"

  create_table "dvtable_{4a4c5fb5-c2f2-4443-bd65-083c75018e84}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ScriptType"
    t.text    "Script"
    t.string  "ScriptTypeUID",   limit: nil
  end

  add_index "dvtable_{4a4c5fb5-c2f2-4443-bd65-083c75018e84}", ["ParentRowID"], name: "dvsys_reftypes_customscripts_section"
  add_index "dvtable_{4a4c5fb5-c2f2-4443-bd65-083c75018e84}", ["ScriptType", "ParentRowID", "ScriptTypeUID"], name: "dvsys_reftypes_customscripts_uc_section_scripttype", unique: true

  create_table "dvtable_{4b25da25-ace2-4205-bd28-69f80d1cf57f}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "Name",            limit: 128
    t.string "NameUID",         limit: nil
  end

  add_index "dvtable_{4b25da25-ace2-4205-bd28-69f80d1cf57f}", ["Name", "NameUID"], name: "dvsys_refpartners_orgtypes_uc_global_name", unique: true

  create_table "dvtable_{4bf5a4c4-ca53-4294-9d6b-00faa48ab320}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Name",            limit: 512
    t.string  "Type",            limit: nil
    t.string  "DocState",        limit: nil
    t.string  "FilesID",         limit: nil
    t.string  "BarcodeNumber",   limit: 32
    t.string  "ParentCardID",    limit: nil
    t.boolean "PropsAsForm"
  end

  add_index "dvtable_{4bf5a4c4-ca53-4294-9d6b-00faa48ab320}", ["InstanceID"], name: "dvsys_carduni_maininfo_uc_struct", unique: true

  create_table "dvtable_{4bf5a4c4-ca53-4294-9d6b-00faa48ab320}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Name",            limit: 512
    t.string  "Type",            limit: nil
    t.string  "DocState",        limit: nil
    t.string  "FilesID",         limit: nil
    t.string  "BarcodeNumber",   limit: 32
    t.string  "ParentCardID",    limit: nil
    t.boolean "PropsAsForm"
  end

  add_index "dvtable_{4bf5a4c4-ca53-4294-9d6b-00faa48ab320}_archive", ["InstanceID"], name: "dvsys_carduni_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{4c07ca25-41d6-438a-b73e-47fe7650c7bd}", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "RegistrationDate"
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID", limit: nil
    t.integer  "State",                            default: 1
    t.integer  "ListCount"
    t.integer  "InAppendix"
    t.string   "Registrator",          limit: nil
    t.string   "CaseID",               limit: nil
    t.string   "FileListId",           limit: nil
    t.string   "Executer",             limit: nil
    t.text     "Subject"
    t.string   "LinksListId",          limit: nil
    t.string   "ReplicationCard",      limit: nil
    t.boolean  "NotifyBPStarted"
    t.string   "LegacySystemID",       limit: 256
    t.string   "BarcodeNumber",        limit: 40
    t.string   "BarcodeNumberID",      limit: nil
    t.string   "TransferLog",          limit: nil
    t.string   "Topic",                limit: 256
    t.integer  "SendingKind"
    t.boolean  "Interrupted",                      default: false
    t.string   "ApprovalBP",           limit: nil
    t.boolean  "NoApproving"
    t.string   "Enclosure",            limit: 256
    t.datetime "AnswerExpectedTerm"
    t.string   "ProjectNumber"
    t.string   "ProjectNumberID",      limit: nil
    t.string   "ApprovalListID",       limit: nil
    t.string   "ExecutionProcessID",   limit: nil
    t.string   "CurrentDocTemplate",   limit: nil
    t.string   "RestrictedKind",       limit: nil
    t.string   "BoardTypeText"
    t.string   "Duplicate",            limit: nil
  end

  add_index "dvtable_{4c07ca25-41d6-438a-b73e-47fe7650c7bd}", ["InstanceID"], name: "dvsys_outdoc_maininfo_uc_struct", unique: true

  create_table "dvtable_{4c07ca25-41d6-438a-b73e-47fe7650c7bd}_archive", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "RegistrationDate"
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID", limit: nil
    t.integer  "State"
    t.integer  "ListCount"
    t.integer  "InAppendix"
    t.string   "Registrator",          limit: nil
    t.string   "CaseID",               limit: nil
    t.string   "FileListId",           limit: nil
    t.string   "Executer",             limit: nil
    t.text     "Subject"
    t.string   "LinksListId",          limit: nil
    t.string   "ReplicationCard",      limit: nil
    t.boolean  "NotifyBPStarted"
    t.string   "LegacySystemID",       limit: 256
    t.string   "BarcodeNumber",        limit: 40
    t.string   "BarcodeNumberID",      limit: nil
    t.string   "TransferLog",          limit: nil
    t.string   "Topic",                limit: 256
    t.integer  "SendingKind"
    t.boolean  "Interrupted"
    t.string   "ApprovalBP",           limit: nil
    t.boolean  "NoApproving"
    t.string   "Enclosure",            limit: 256
    t.datetime "AnswerExpectedTerm"
    t.string   "ProjectNumber"
    t.string   "ProjectNumberID",      limit: nil
    t.string   "ApprovalListID",       limit: nil
    t.string   "ExecutionProcessID",   limit: nil
    t.string   "CurrentDocTemplate",   limit: nil
    t.string   "RestrictedKind",       limit: nil
    t.string   "BoardTypeText"
    t.string   "Duplicate",            limit: nil
  end

  add_index "dvtable_{4c07ca25-41d6-438a-b73e-47fe7650c7bd}_archive", ["InstanceID"], name: "dvsys_outdoc_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{4c6efcee-c178-4249-bf7b-6c0747f1b620}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "NRDAssignment",   limit: nil
  end

  add_index "dvtable_{4c6efcee-c178-4249-bf7b-6c0747f1b620}", ["InstanceID"], name: "dvsys_ordercard_assignmentnrd_section"

  create_table "dvtable_{4c6efcee-c178-4249-bf7b-6c0747f1b620}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "NRDAssignment",   limit: nil
  end

  add_index "dvtable_{4c6efcee-c178-4249-bf7b-6c0747f1b620}_archive", ["InstanceID"], name: "dvsys_ordercard_assignmentnrd_archive_section"

  create_table "dvtable_{4d449fb3-b2d5-4596-8cf9-9a3f3189b025}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "TypeID",          limit: nil
  end

  add_index "dvtable_{4d449fb3-b2d5-4596-8cf9-9a3f3189b025}", ["ParentRowID"], name: "dvsys_reftypes_childtypes_section"

  create_table "dvtable_{4e8cffe9-07ad-44d1-b651-bc73bf628a24}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "AssignmentId",    limit: nil
    t.integer "AssignmentType"
  end

  add_index "dvtable_{4e8cffe9-07ad-44d1-b651-bc73bf628a24}", ["InstanceID"], name: "dvsys_memorandumcard_assignments_section"

  create_table "dvtable_{4e8cffe9-07ad-44d1-b651-bc73bf628a24}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "AssignmentId",    limit: nil
    t.integer "AssignmentType"
  end

  add_index "dvtable_{4e8cffe9-07ad-44d1-b651-bc73bf628a24}_archive", ["InstanceID"], name: "dvsys_memorandumcard_assignments_archive_section"

  create_table "dvtable_{50cf00fe-df60-47d8-bc13-fb973dc8dc90}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Assignee",        limit: nil
    t.string "AssignmentID",    limit: nil
  end

  add_index "dvtable_{50cf00fe-df60-47d8-bc13-fb973dc8dc90}", ["InstanceID", "ParentRowID"], name: "dvsys_nrdcard_assignees_section"
  add_index "dvtable_{50cf00fe-df60-47d8-bc13-fb973dc8dc90}", ["ParentRowID"], name: "dvsys_nrdcard_assignees_idx_parentrowid"

  create_table "dvtable_{50cf00fe-df60-47d8-bc13-fb973dc8dc90}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Assignee",        limit: nil
    t.string "AssignmentID",    limit: nil
  end

  add_index "dvtable_{50cf00fe-df60-47d8-bc13-fb973dc8dc90}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_nrdcard_assignees_archive_section"
  add_index "dvtable_{50cf00fe-df60-47d8-bc13-fb973dc8dc90}_archive", ["ParentRowID"], name: "dvsys_nrdcard_assignees_archive_idx_parentrowid"

  create_table "dvtable_{5151e289-f5a9-4a4d-a364-736f207fc9d0}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "ApproverRowID",   limit: nil
  end

  add_index "dvtable_{5151e289-f5a9-4a4d-a364-736f207fc9d0}", ["InstanceID", "ParentRowID"], name: "dvsys_cardapproval_approversset_section"
  add_index "dvtable_{5151e289-f5a9-4a4d-a364-736f207fc9d0}", ["ParentRowID"], name: "dvsys_cardapproval_approversset_idx_parentrowid"

  create_table "dvtable_{5151e289-f5a9-4a4d-a364-736f207fc9d0}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "ApproverRowID",   limit: nil
  end

  add_index "dvtable_{5151e289-f5a9-4a4d-a364-736f207fc9d0}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardapproval_approversset_archive_section"
  add_index "dvtable_{5151e289-f5a9-4a4d-a364-736f207fc9d0}_archive", ["ParentRowID"], name: "dvsys_cardapproval_approversset_archive_idx_parentrowid"

  create_table "dvtable_{5181cc4b-b595-4fdf-a59a-3f75a1de9130}", id: false, force: true do |t|
    t.string  "RowID",            limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",             limit: nil
    t.string  "AssignmentPerson", limit: nil
    t.integer "AssignmentType"
  end

  add_index "dvtable_{5181cc4b-b595-4fdf-a59a-3f75a1de9130}", ["ParentRowID"], name: "dvsys_refdocsetup_assignmentcontentsuggestions_section"

  create_table "dvtable_{51a72e72-7a3d-4ee9-8955-76a1574f7153}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "Order"
    t.string  "FieldName",       limit: 128
    t.boolean "FirstLetterOnly"
  end

  add_index "dvtable_{51a72e72-7a3d-4ee9-8955-76a1574f7153}", ["ParentRowID"], name: "dvsys_refpartners_depviewfields_section"

  create_table "dvtable_{51c02683-8d61-4f8f-98dd-80a4da5ac4f4}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "RefType"
    t.string  "RefID",           limit: nil
    t.string  "RefURL",          limit: 4000
    t.boolean "ReadOnly"
    t.string  "Comment",         limit: 2048
    t.string  "ModeID",          limit: nil
    t.string  "RefIDPID",        limit: nil
    t.string  "RefCardID",       limit: nil
    t.string  "RefFolderID",     limit: nil
  end

  add_index "dvtable_{51c02683-8d61-4f8f-98dd-80a4da5ac4f4}", ["InstanceID"], name: "dvsys_workflowtask_performerreferences_section"

  create_table "dvtable_{51c02683-8d61-4f8f-98dd-80a4da5ac4f4}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "RefType"
    t.string  "RefID",           limit: nil
    t.string  "RefURL",          limit: 4000
    t.boolean "ReadOnly"
    t.string  "Comment",         limit: 2048
    t.string  "ModeID",          limit: nil
    t.string  "RefIDPID",        limit: nil
    t.string  "RefCardID",       limit: nil
    t.string  "RefFolderID",     limit: nil
  end

  add_index "dvtable_{51c02683-8d61-4f8f-98dd-80a4da5ac4f4}_archive", ["InstanceID"], name: "dvsys_workflowtask_performerreferences_archive_section"

# Could not dump table "dvtable_{52f01448-151c-4d4b-b18e-e80a06b5a581}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{52f01448-151c-4d4b-b18e-e80a06b5a581}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{533458cf-0700-42db-8a4f-a0ee02f4b41f}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text   "Definition"
    t.text   "LicenseInfo"
  end

  add_index "dvtable_{533458cf-0700-42db-8a4f-a0ee02f4b41f}", ["ParentRowID"], name: "dvsys_gatelist_additionalinfo_uc_struct", unique: true

  create_table "dvtable_{546ef8d3-fea3-481d-9453-d134c039f653}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "RefType"
    t.string  "RefIDPID",        limit: nil
    t.boolean "ReadOnly"
    t.string  "Comment",         limit: 2048
    t.string  "CommentPID",      limit: nil
    t.integer "Rights"
    t.string  "ModeID",          limit: nil
    t.boolean "CommentRequired"
    t.boolean "OpenImmediately"
  end

  add_index "dvtable_{546ef8d3-fea3-481d-9453-d134c039f653}", ["InstanceID"], name: "dvsys_workflowtask_references_section"

  create_table "dvtable_{546ef8d3-fea3-481d-9453-d134c039f653}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "RefType"
    t.string  "RefIDPID",        limit: nil
    t.boolean "ReadOnly"
    t.string  "Comment",         limit: 2048
    t.string  "CommentPID",      limit: nil
    t.integer "Rights"
    t.string  "ModeID",          limit: nil
    t.boolean "CommentRequired"
    t.boolean "OpenImmediately"
  end

  add_index "dvtable_{546ef8d3-fea3-481d-9453-d134c039f653}_archive", ["InstanceID"], name: "dvsys_workflowtask_references_archive_section"

  create_table "dvtable_{54710759-097d-40f9-a1c3-62b295254755}", id: false, force: true do |t|
    t.string  "RowID",                                  limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",                            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",                        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                                   limit: nil
    t.string  "DirectiveNumerator",                     limit: nil
    t.string  "DirectiveBPTemplate",                    limit: nil
    t.string  "DirectiveBPStartingFolder",              limit: nil
    t.string  "DirectiveBPInstanceFolder",              limit: nil
    t.integer "DirectiveSigningDuration"
    t.integer "DirectiveCorrectionDuration"
    t.integer "DirectiveApprovingDuration"
    t.string  "DirectiveEmployee_OD",                   limit: nil
    t.integer "DirectiveAssignmentDuration"
    t.string  "DirectiveFolder",                        limit: nil
    t.integer "DirectiveSendAssignmentToExecuter"
    t.string  "DirectivePrintTemplate",                 limit: nil
    t.string  "DirectiveNotificationListPrintTemplate", limit: nil
    t.boolean "DirectiveNoApproving"
    t.string  "DirectiveNumeratorProject",              limit: nil
    t.string  "DirectiveDocPrintTemplate",              limit: nil
    t.boolean "DirectiveAlternativeProcessCorrection"
  end

  add_index "dvtable_{54710759-097d-40f9-a1c3-62b295254755}", ["InstanceID"], name: "dvsys_refdocsetup_directivesetup_uc_struct", unique: true

  create_table "dvtable_{54925928-17b1-4f56-8d6f-c14541b65ab1}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CopyToPerson",    limit: nil
  end

  add_index "dvtable_{54925928-17b1-4f56-8d6f-c14541b65ab1}", ["InstanceID", "ParentRowID"], name: "dvsys_memorandumcard_copytopersons_section"
  add_index "dvtable_{54925928-17b1-4f56-8d6f-c14541b65ab1}", ["ParentRowID"], name: "dvsys_memorandumcard_copytopersons_idx_parentrowid"

  create_table "dvtable_{54925928-17b1-4f56-8d6f-c14541b65ab1}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CopyToPerson",    limit: nil
  end

  add_index "dvtable_{54925928-17b1-4f56-8d6f-c14541b65ab1}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_memorandumcard_copytopersons_archive_section"
  add_index "dvtable_{54925928-17b1-4f56-8d6f-c14541b65ab1}_archive", ["ParentRowID"], name: "dvsys_memorandumcard_copytopersons_archive_idx_parentrowid"

  create_table "dvtable_{54f5c319-29cc-4e95-9d11-45133a68291f}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean  "IsReceived"
    t.string   "FromEmployee",    limit: nil
    t.string   "ToEmployee",      limit: nil
    t.string   "ToDepartment",    limit: nil
    t.datetime "TransferDate"
    t.boolean  "IsCopy"
    t.string   "Comments",        limit: 2048
  end

  add_index "dvtable_{54f5c319-29cc-4e95-9d11-45133a68291f}", ["InstanceID"], name: "dvsys_cardinc_transferlog_section"

  create_table "dvtable_{54f5c319-29cc-4e95-9d11-45133a68291f}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean  "IsReceived"
    t.string   "FromEmployee",    limit: nil
    t.string   "ToEmployee",      limit: nil
    t.string   "ToDepartment",    limit: nil
    t.datetime "TransferDate"
    t.boolean  "IsCopy"
    t.string   "Comments",        limit: 2048
  end

  add_index "dvtable_{54f5c319-29cc-4e95-9d11-45133a68291f}_archive", ["InstanceID"], name: "dvsys_cardinc_transferlog_archive_section"

  create_table "dvtable_{5586cf8e-1c01-40d2-8c6a-8ca808927725}", id: false, force: true do |t|
    t.string "RowID",                      limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                       limit: nil
    t.string "DurableBPTemplate",          limit: nil
    t.string "DurableBPStartingFolder",    limit: nil
    t.string "DurableBPInstanceFolder",    limit: nil
    t.string "DurableStoreFolder",         limit: nil
    t.string "DurableAssignmentNumerator", limit: nil
  end

  add_index "dvtable_{5586cf8e-1c01-40d2-8c6a-8ca808927725}", ["InstanceID"], name: "dvsys_refdocsetup_durableassignmentsetup_uc_struct", unique: true

  create_table "dvtable_{55b1b2f2-b5b6-4150-a555-fa605a1288b7}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean  "IsReceived"
    t.string   "FromEmployee",    limit: nil
    t.string   "ToEmployee",      limit: nil
    t.string   "ToDepartment",    limit: nil
    t.datetime "TransferDate"
    t.boolean  "IsCopy"
    t.string   "Comments",        limit: 2048
  end

  add_index "dvtable_{55b1b2f2-b5b6-4150-a555-fa605a1288b7}", ["InstanceID"], name: "dvsys_cardord_transferlog_section"

  create_table "dvtable_{55b1b2f2-b5b6-4150-a555-fa605a1288b7}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean  "IsReceived"
    t.string   "FromEmployee",    limit: nil
    t.string   "ToEmployee",      limit: nil
    t.string   "ToDepartment",    limit: nil
    t.datetime "TransferDate"
    t.boolean  "IsCopy"
    t.string   "Comments",        limit: 2048
  end

  add_index "dvtable_{55b1b2f2-b5b6-4150-a555-fa605a1288b7}_archive", ["InstanceID"], name: "dvsys_cardord_transferlog_archive_section"

# Could not dump table "dvtable_{55ef9765-2651-4f13-a716-4606b729881c}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{55ef9765-2651-4f13-a716-4606b729881c}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{573c39b5-6e7d-4c74-b292-50c29326a8cb}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{573c39b5-6e7d-4c74-b292-50c29326a8cb}", ["ParentRowID"], name: "dvsys_refpartners_enumvalues_section"

  create_table "dvtable_{5745984a-b458-42b7-84e5-f69de8c6f412}", id: false, force: true do |t|
    t.string "RowID",              limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",    limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",               limit: nil
    t.string "DuplicateName",      limit: 256
    t.string "DuplicateNumerator", limit: nil
  end

  add_index "dvtable_{5745984a-b458-42b7-84e5-f69de8c6f412}", ["ParentRowID"], name: "dvsys_refdocsetup_duplicatenumerators_section"

  create_table "dvtable_{5771c4f5-a4cc-4861-9db1-42db48e16d2b}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "NewDocTemplate",  limit: nil
  end

  add_index "dvtable_{5771c4f5-a4cc-4861-9db1-42db48e16d2b}", ["ParentRowID"], name: "dvsys_refdocsetup_newdoctemplates_section"

  create_table "dvtable_{578b2113-acfb-4f0a-b868-5dbc06d0daa2}", id: false, force: true do |t|
    t.string "RowID",                  limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                   limit: nil
    t.string "DirectiveTypeName",      limit: 256
    t.string "DirectiveTypeNumerator", limit: nil
  end

  add_index "dvtable_{578b2113-acfb-4f0a-b868-5dbc06d0daa2}", ["ParentRowID"], name: "dvsys_refdocsetup_directivetypesnumerators_section"

  create_table "dvtable_{57bea53e-4c46-44c8-803e-e3628f1b8e2f}", id: false, force: true do |t|
    t.string "RowID",                   limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",              limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                    limit: nil
    t.string "DirectiveSignedByPerson", limit: nil
  end

  add_index "dvtable_{57bea53e-4c46-44c8-803e-e3628f1b8e2f}", ["ParentRowID"], name: "dvsys_refdocsetup_directivesingedbypersons_section"

  create_table "dvtable_{57e1bd43-2ef8-4616-9ffa-68a88f6e4fc8}", id: false, force: true do |t|
    t.string "RowID",                limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                 limit: nil
    t.string "DirectiveEmployee_OD", limit: nil
  end

  add_index "dvtable_{57e1bd43-2ef8-4616-9ffa-68a88f6e4fc8}", ["ParentRowID"], name: "dvsys_refdocsetup_directiveemployees_od_section"

# Could not dump table "dvtable_{57f9d880-46ce-4d23-8fbe-68a654a86f75}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{57f9d880-46ce-4d23-8fbe-68a654a86f75}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{58299e31-e1ec-4756-bc89-eda47cbc6aa0}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "FolderCardID",    limit: nil
    t.string "FolderRootName",  limit: 64
  end

  add_index "dvtable_{58299e31-e1ec-4756-bc89-eda47cbc6aa0}", ["InstanceID"], name: "dvsys_navigatorcard_maininfo_uc_struct", unique: true

  create_table "dvtable_{583cb617-958b-4d88-a426-1e73cf625595}", id: false, force: true do |t|
    t.string "RowID",              limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",    limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "DiscussionsSpeaker", limit: nil
    t.text   "DiscussionsSubject"
    t.string "DiscussionsAgenda",  limit: nil
  end

  add_index "dvtable_{583cb617-958b-4d88-a426-1e73cf625595}", ["InstanceID"], name: "dvsys_protocolcard_discussions_section"

  create_table "dvtable_{583cb617-958b-4d88-a426-1e73cf625595}_archive", id: false, force: true do |t|
    t.string "RowID",              limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",    limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "DiscussionsSpeaker", limit: nil
    t.text   "DiscussionsSubject"
    t.string "DiscussionsAgenda",  limit: nil
  end

  add_index "dvtable_{583cb617-958b-4d88-a426-1e73cf625595}_archive", ["InstanceID"], name: "dvsys_protocolcard_discussions_archive_section"

  create_table "dvtable_{58d7dd28-7576-4c13-9dd4-696879353103}", id: false, force: true do |t|
    t.string "RowID",               limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "AttendeesEmployeeId", limit: nil
    t.string "PartnerEmployeeId",   limit: nil
    t.string "EmployeeText",        limit: 256
    t.string "PartnerEmployeeText", limit: 256
  end

  add_index "dvtable_{58d7dd28-7576-4c13-9dd4-696879353103}", ["InstanceID"], name: "dvsys_protocolcard_attendees_section"

  create_table "dvtable_{58d7dd28-7576-4c13-9dd4-696879353103}_archive", id: false, force: true do |t|
    t.string "RowID",               limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "AttendeesEmployeeId", limit: nil
    t.string "PartnerEmployeeId",   limit: nil
    t.string "EmployeeText",        limit: 256
    t.string "PartnerEmployeeText", limit: 256
  end

  add_index "dvtable_{58d7dd28-7576-4c13-9dd4-696879353103}_archive", ["InstanceID"], name: "dvsys_protocolcard_attendees_archive_section"

  create_table "dvtable_{58dd7f37-6042-4cc2-b3c1-6b29f49366bd}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "NRDDocumentKind", limit: 256
  end

  add_index "dvtable_{58dd7f37-6042-4cc2-b3c1-6b29f49366bd}", ["ParentRowID"], name: "dvsys_refdocsetup_nrddocumentkinds_section"

  create_table "dvtable_{5996e56a-811b-47a0-92ab-cf59c6fa4130}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{5996e56a-811b-47a0-92ab-cf59c6fa4130}", ["ParentRowID"], name: "dvsys_refuniversal_enumvalues_section"

  create_table "dvtable_{59b14465-f598-4a83-9811-55d987868d91}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "SDID",            limit: nil
    t.string   "NumeratorID",     limit: nil
    t.string   "SyncTag",         limit: 256
    t.string   "NumberPrefix",    limit: 32
    t.string   "PrefixSeparator", limit: 32,  default: "-"
    t.string   "NumberSuffix",    limit: 32
    t.string   "SuffixSeparator", limit: 32,  default: "-"
    t.integer  "CardType"
    t.integer  "ZoneType",                    default: 0
    t.integer  "ZoneInterval"
    t.integer  "ZoneDay"
    t.datetime "ZoneDate"
    t.string   "NumberFormat",    limit: 32
    t.boolean  "NotAvailable"
    t.string   "CardTypeID",      limit: nil
    t.text     "XSLTFormat"
  end

  create_table "dvtable_{59bfb8d3-724c-456e-bd2c-9912b5f6f563}", id: false, force: true do |t|
    t.string  "RowID",                   limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",              limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean "CanReject"
    t.boolean "CanReschedule"
    t.boolean "ControllerCanReschedule"
    t.boolean "CanAddFiles"
    t.boolean "IsReportNeeded"
    t.boolean "SendImmediately"
    t.boolean "ToRead"
    t.boolean "SendAndFinish"
    t.boolean "CanOpenParent"
    t.boolean "IsAddFileNeeded"
    t.boolean "CanViewLog"
    t.integer "Reminder"
    t.boolean "ReportCardRequired"
    t.boolean "DelegateToAll"
    t.boolean "DelegateToDeputies"
    t.boolean "NotifyChildCompletion"
    t.boolean "NotifyAllResolutions"
    t.boolean "CanDeleteFiles"
    t.boolean "AuthorCanReschedule"
  end

  add_index "dvtable_{59bfb8d3-724c-456e-bd2c-9912b5f6f563}", ["InstanceID"], name: "dvsys_cardresolution_settings_uc_struct", unique: true

  create_table "dvtable_{59bfb8d3-724c-456e-bd2c-9912b5f6f563}_archive", id: false, force: true do |t|
    t.string  "RowID",                   limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",              limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean "CanReject"
    t.boolean "CanReschedule"
    t.boolean "ControllerCanReschedule"
    t.boolean "CanAddFiles"
    t.boolean "IsReportNeeded"
    t.boolean "SendImmediately"
    t.boolean "ToRead"
    t.boolean "SendAndFinish"
    t.boolean "CanOpenParent"
    t.boolean "IsAddFileNeeded"
    t.boolean "CanViewLog"
    t.integer "Reminder"
    t.boolean "ReportCardRequired"
    t.boolean "DelegateToAll"
    t.boolean "DelegateToDeputies"
    t.boolean "NotifyChildCompletion"
    t.boolean "NotifyAllResolutions"
    t.boolean "CanDeleteFiles"
    t.boolean "AuthorCanReschedule"
  end

  add_index "dvtable_{59bfb8d3-724c-456e-bd2c-9912b5f6f563}_archive", ["InstanceID"], name: "dvsys_cardresolution_settings_archive_uc_struct", unique: true

  create_table "dvtable_{59c16478-a791-4d47-b7e4-a30c88f6c218}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CardTypeID",      limit: nil
  end

  create_table "dvtable_{5a9fbcfd-e4de-4fc2-80d5-a5b1f1d51229}", id: false, force: true do |t|
    t.string  "RowID",               limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "OriginalCenter"
    t.boolean "ReadyForReplication"
    t.string  "OriginalCard",        limit: nil
    t.string  "OriginalCardRow",     limit: nil
  end

  add_index "dvtable_{5a9fbcfd-e4de-4fc2-80d5-a5b1f1d51229}", ["InstanceID"], name: "dvsys_replicationcard_maininfo_uc_struct", unique: true

  create_table "dvtable_{5a9fbcfd-e4de-4fc2-80d5-a5b1f1d51229}_archive", id: false, force: true do |t|
    t.string  "RowID",               limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "OriginalCenter"
    t.boolean "ReadyForReplication"
    t.string  "OriginalCard",        limit: nil
    t.string  "OriginalCardRow",     limit: nil
  end

  add_index "dvtable_{5a9fbcfd-e4de-4fc2-80d5-a5b1f1d51229}_archive", ["InstanceID"], name: "dvsys_replicationcard_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{5aa8ecaa-8a21-4a5e-b830-c4f859397298}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "FirstNumber"
    t.integer "LastNumber"
    t.string  "OwnerID",         limit: nil
  end

  add_index "dvtable_{5aa8ecaa-8a21-4a5e-b830-c4f859397298}", ["InstanceID"], name: "dvsys_numeratorcard_ranges_section"

  create_table "dvtable_{5b607ffc-7ea2-47b1-90d4-bb72a0fe7280}", id: false, force: true do |t|
    t.string  "RowID",             limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",        limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",       limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",   limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",              limit: nil
    t.string  "Name",              limit: 128
    t.string  "Comments",          limit: 1024
    t.string  "AccountName",       limit: 128
    t.boolean "RefreshADsGroup"
    t.boolean "ADsNotSynchronize"
    t.string  "AccountSID",        limit: 256
    t.string  "NameUID",           limit: nil
  end

  add_index "dvtable_{5b607ffc-7ea2-47b1-90d4-bb72a0fe7280}", ["Name", "ParentTreeRowID", "NameUID"], name: "dvsys_refstaff_alternatehierarchy_uc_tree_name", unique: true
  add_index "dvtable_{5b607ffc-7ea2-47b1-90d4-bb72a0fe7280}", ["ParentTreeRowID"], name: "dvsys_refstaff_alternatehierarchy_section"

# Could not dump table "dvtable_{5b6b407e-3d72-49e7-97d9-8e1e028c7274}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{5b6b407e-3d72-49e7-97d9-8e1e028c7274}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{5b7091c7-18da-4e82-9c62-883f5237eed2}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "TypeID",          limit: nil
    t.string "AccessID",        limit: nil
  end

  add_index "dvtable_{5b7091c7-18da-4e82-9c62-883f5237eed2}", ["ParentRowID"], name: "dvsys_folderscard_allowedtypes_section"

  create_table "dvtable_{5c103e40-ba13-44ef-a628-e6286dc687d6}", id: false, force: true do |t|
    t.string  "RowID",            limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",             limit: nil
    t.string  "LinkName",         limit: 128
    t.string  "OppositeLinkName", limit: 128
    t.string  "SyncTag",          limit: 256
    t.string  "IncomingName",     limit: 256
    t.string  "OutgoingName",     limit: 256
    t.string  "InternalName",     limit: 256
    t.boolean "NotAvailable",                 default: false
    t.string  "LinkNameUID",      limit: nil
  end

  add_index "dvtable_{5c103e40-ba13-44ef-a628-e6286dc687d6}", ["LinkName", "LinkNameUID"], name: "dvsys_reflinks_linktypes_uc_card_linkname", unique: true

  create_table "dvtable_{5e3ed23a-2b5e-47f2-887c-e154aceafb97}", id: false, force: true do |t|
    t.string  "RowID",             limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",        limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",       limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",   limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",              limit: nil
    t.string  "Name",              limit: 1900
    t.string  "Comments",          limit: 2048
    t.boolean "NotAvailable"
    t.boolean "ShowProperties"
    t.boolean "GroupByBoxVisible"
    t.integer "NameWidth"
    t.integer "CommentsWidth"
    t.boolean "UseOrder"
    t.boolean "Locked"
  end

  add_index "dvtable_{5e3ed23a-2b5e-47f2-887c-e154aceafb97}", ["ParentTreeRowID"], name: "dvsys_refuniversal_itemtype_section"

  create_table "dvtable_{5ecee53e-4533-43bd-829d-eaeb069d0d28}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentCard",      limit: nil
  end

  add_index "dvtable_{5ecee53e-4533-43bd-829d-eaeb069d0d28}", ["InstanceID"], name: "dvsys_transferlogcard_maininfo_uc_struct", unique: true

  create_table "dvtable_{5f509152-c9c4-4a56-a0ee-4d336e8aee39}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "NRD",             limit: nil
  end

  add_index "dvtable_{5f509152-c9c4-4a56-a0ee-4d336e8aee39}", ["InstanceID"], name: "dvsys_nrdcard_nrdlinks_section"

  create_table "dvtable_{5f509152-c9c4-4a56-a0ee-4d336e8aee39}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "NRD",             limit: nil
  end

  add_index "dvtable_{5f509152-c9c4-4a56-a0ee-4d336e8aee39}_archive", ["InstanceID"], name: "dvsys_nrdcard_nrdlinks_archive_section"

# Could not dump table "dvtable_{5f7740b7-0d4d-4b10-b28c-08dbdb40f528}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{5f905c9b-c9b1-45d2-9d8b-98f243c9b3e5}", id: false, force: true do |t|
    t.string "RowID",             limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",              limit: nil
    t.string "DirectionEmployee", limit: nil
  end

  add_index "dvtable_{5f905c9b-c9b1-45d2-9d8b-98f243c9b3e5}", ["ParentRowID"], name: "dvsys_refdocsetup_directionregistrators_section"

  create_table "dvtable_{60db6ba9-b8a7-47e6-8a73-8dc3b83c4d97}", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text     "CancelInfo"
    t.datetime "Date"
    t.string   "CancellationDocument", limit: nil
    t.string   "Employee",             limit: nil
  end

  add_index "dvtable_{60db6ba9-b8a7-47e6-8a73-8dc3b83c4d97}", ["InstanceID"], name: "dvsys_directivecard_cancellationinfo_section"

  create_table "dvtable_{60db6ba9-b8a7-47e6-8a73-8dc3b83c4d97}_archive", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text     "CancelInfo"
    t.datetime "Date"
    t.string   "CancellationDocument", limit: nil
    t.string   "Employee",             limit: nil
  end

  add_index "dvtable_{60db6ba9-b8a7-47e6-8a73-8dc3b83c4d97}_archive", ["InstanceID"], name: "dvsys_directivecard_cancellationinfo_archive_section"

  create_table "dvtable_{619d42eb-beca-4377-8603-3d42cdc58936}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                   null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTypeID",    limit: nil
    t.string "LinkPoints",      limit: 2048
    t.string "ParentTypeIDUID", limit: nil
  end

  add_index "dvtable_{619d42eb-beca-4377-8603-3d42cdc58936}", ["ParentRowID"], name: "dvsys_reftypes_parenttypes_section"
  add_index "dvtable_{619d42eb-beca-4377-8603-3d42cdc58936}", ["ParentTypeID", "ParentRowID", "ParentTypeIDUID"], name: "dvsys_reftypes_parenttypes_uc_section_parenttypeid", unique: true

  create_table "dvtable_{6272e4bf-4ba4-4f32-94cc-31941f3ee5ff}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{6272e4bf-4ba4-4f32-94cc-31941f3ee5ff}", ["ParentRowID"], name: "dvsys_reftypes_enumvalues_section"

  create_table "dvtable_{633a3831-70e0-4217-9119-7385b953a89b}", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "RegistrationDate"
    t.string   "RegistrationNumberID", limit: nil
    t.string   "RegistrationNumber",   limit: 256
    t.integer  "State"
    t.integer  "ListCount"
    t.integer  "InAppendix"
    t.string   "Registrator",          limit: nil
    t.string   "Executer",             limit: nil
    t.string   "Signer",               limit: nil
    t.string   "Controller",           limit: nil
    t.text     "Content"
    t.string   "FileListID",           limit: nil
    t.string   "LinkListID",           limit: nil
    t.string   "ApprovalListID",       limit: nil
    t.string   "DocKind",              limit: nil
    t.string   "DocKindText",          limit: 256
  end

  add_index "dvtable_{633a3831-70e0-4217-9119-7385b953a89b}", ["InstanceID"], name: "dvsys_universalapprovalcard_maininfo_uc_struct", unique: true

  create_table "dvtable_{633a3831-70e0-4217-9119-7385b953a89b}_archive", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "RegistrationDate"
    t.string   "RegistrationNumberID", limit: nil
    t.string   "RegistrationNumber",   limit: 256
    t.integer  "State"
    t.integer  "ListCount"
    t.integer  "InAppendix"
    t.string   "Registrator",          limit: nil
    t.string   "Executer",             limit: nil
    t.string   "Signer",               limit: nil
    t.string   "Controller",           limit: nil
    t.text     "Content"
    t.string   "FileListID",           limit: nil
    t.string   "LinkListID",           limit: nil
    t.string   "ApprovalListID",       limit: nil
    t.string   "DocKind",              limit: nil
    t.string   "DocKindText",          limit: 256
  end

  add_index "dvtable_{633a3831-70e0-4217-9119-7385b953a89b}_archive", ["InstanceID"], name: "dvsys_universalapprovalcard_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{641f6aff-1187-491a-98d5-a735a6f97204}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                   null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "Name",            limit: 256
    t.string "TypeName",        limit: 1024
    t.string "TypeNameUID",     limit: nil
    t.string "NameUID",         limit: nil
  end

  add_index "dvtable_{641f6aff-1187-491a-98d5-a735a6f97204}", ["Name", "NameUID"], name: "dvsys_settingscard_extensions_uc_card_name", unique: true
  add_index "dvtable_{641f6aff-1187-491a-98d5-a735a6f97204}", ["TypeName", "TypeNameUID"], name: "dvsys_settingscard_extensions_uc_card_typename", unique: true

  create_table "dvtable_{655e84fd-2f25-4b5b-8c52-13beec755374}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ZoneCode"
    t.text    "ZoneDescription"
    t.string  "PartnerRef",      limit: nil
    t.string  "ZoneCodeUID",     limit: nil
  end

  add_index "dvtable_{655e84fd-2f25-4b5b-8c52-13beec755374}", ["ZoneCode", "ZoneCodeUID"], name: "dvsys_refreplicatorsetup_replicationzones_uc_section_zonecode", unique: true

  create_table "dvtable_{66e1b83f-f531-41ae-bbbf-665241e94f2d}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "NotifEmployee",   limit: nil
    t.datetime "FamiliarizeDate"
  end

  add_index "dvtable_{66e1b83f-f531-41ae-bbbf-665241e94f2d}", ["InstanceID"], name: "dvsys_ordercard_notificationlist_section"

  create_table "dvtable_{66e1b83f-f531-41ae-bbbf-665241e94f2d}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "NotifEmployee",   limit: nil
    t.datetime "FamiliarizeDate"
  end

  add_index "dvtable_{66e1b83f-f531-41ae-bbbf-665241e94f2d}_archive", ["InstanceID"], name: "dvsys_ordercard_notificationlist_archive_section"

  create_table "dvtable_{67046d6d-a2f3-4483-99a9-06741d0f200f}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{67046d6d-a2f3-4483-99a9-06741d0f200f}", ["ParentRowID"], name: "dvsys_refstaff_enumvalues_section"

  create_table "dvtable_{676b7553-d296-40ec-9f0c-e080860addd7}", id: false, force: true do |t|
    t.string "RowID",            limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",             limit: nil
    t.string "IncDocODEmployee", limit: nil
  end

  add_index "dvtable_{676b7553-d296-40ec-9f0c-e080860addd7}", ["ParentRowID"], name: "dvsys_refdocsetup_incdocodemployees_section"

  create_table "dvtable_{67f15db9-7e37-4000-bf40-8a5929abbab8}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CaseID",          limit: nil
    t.string "NumberPrefix",    limit: 32
    t.string "NumberSuffix",    limit: 32
    t.string "CaseIDUID",       limit: nil
  end

  add_index "dvtable_{67f15db9-7e37-4000-bf40-8a5929abbab8}", ["CaseID", "ParentRowID", "CaseIDUID"], name: "dvsys_refnumerators_cases_uc_section_caseid", unique: true
  add_index "dvtable_{67f15db9-7e37-4000-bf40-8a5929abbab8}", ["ParentRowID"], name: "dvsys_refnumerators_cases_section"

  create_table "dvtable_{695e5315-bcea-4ee9-b24b-50d41bad0612}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{695e5315-bcea-4ee9-b24b-50d41bad0612}", ["CategoryID", "InstanceID", "CategoryIDUID"], name: "dvsys_cardarchive_categories_uc_card_categoryid", unique: true
  add_index "dvtable_{695e5315-bcea-4ee9-b24b-50d41bad0612}", ["InstanceID"], name: "dvsys_cardarchive_categories_section"

  create_table "dvtable_{695e5315-bcea-4ee9-b24b-50d41bad0612}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{695e5315-bcea-4ee9-b24b-50d41bad0612}_archive", ["InstanceID"], name: "dvsys_cardarchive_categories_archive_section"

  create_table "dvtable_{6a2fb4a6-7c7c-4ffd-b61c-74cf11c049ca}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "EditControler",   limit: nil
    t.datetime "EditDeadline"
    t.boolean  "EditToRead"
    t.text     "EditComments"
  end

  add_index "dvtable_{6a2fb4a6-7c7c-4ffd-b61c-74cf11c049ca}", ["InstanceID"], name: "dvsys_ordercard_assignmentedit_uc_struct", unique: true

  create_table "dvtable_{6a2fb4a6-7c7c-4ffd-b61c-74cf11c049ca}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "EditControler",   limit: nil
    t.datetime "EditDeadline"
    t.boolean  "EditToRead"
    t.text     "EditComments"
  end

  add_index "dvtable_{6a2fb4a6-7c7c-4ffd-b61c-74cf11c049ca}_archive", ["InstanceID"], name: "dvsys_ordercard_assignmentedit_archive_uc_struct", unique: true

  create_table "dvtable_{6a455999-004c-42a8-883d-b875c233dfbe}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "HistoryKind"
    t.string   "HistoryPerson",   limit: nil
    t.text     "HistoryComments"
    t.datetime "HistoryDate"
    t.string   "HistoryTaskID",   limit: nil
  end

  add_index "dvtable_{6a455999-004c-42a8-883d-b875c233dfbe}", ["InstanceID"], name: "dvsys_nrdcard_approvalhistory_section"

  create_table "dvtable_{6a455999-004c-42a8-883d-b875c233dfbe}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "HistoryKind"
    t.string   "HistoryPerson",   limit: nil
    t.text     "HistoryComments"
    t.datetime "HistoryDate"
    t.string   "HistoryTaskID",   limit: nil
  end

  add_index "dvtable_{6a455999-004c-42a8-883d-b875c233dfbe}_archive", ["InstanceID"], name: "dvsys_nrdcard_approvalhistory_archive_section"

  create_table "dvtable_{6a7bd6f5-35bf-415b-b655-008528394464}", id: false, force: true do |t|
    t.string  "RowID",                limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ApprovalListTemplate", limit: nil
    t.integer "ApprovingType"
  end

  add_index "dvtable_{6a7bd6f5-35bf-415b-b655-008528394464}", ["InstanceID"], name: "dvsys_directivecard_approvallist_uc_struct", unique: true

  create_table "dvtable_{6a7bd6f5-35bf-415b-b655-008528394464}_archive", id: false, force: true do |t|
    t.string  "RowID",                limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ApprovalListTemplate", limit: nil
    t.integer "ApprovingType"
  end

  add_index "dvtable_{6a7bd6f5-35bf-415b-b655-008528394464}_archive", ["InstanceID"], name: "dvsys_directivecard_approvallist_archive_uc_struct", unique: true

  create_table "dvtable_{6a95f4b5-e86d-4464-99da-baff7264453c}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "StartTime"
    t.datetime "EndTime"
  end

  add_index "dvtable_{6a95f4b5-e86d-4464-99da-baff7264453c}", ["InstanceID"], name: "dvsys_cardcalendar_defaultworktime_section"

  create_table "dvtable_{6a95f4b5-e86d-4464-99da-baff7264453c}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "StartTime"
    t.datetime "EndTime"
  end

  add_index "dvtable_{6a95f4b5-e86d-4464-99da-baff7264453c}_archive", ["InstanceID"], name: "dvsys_cardcalendar_defaultworktime_archive_section"

  create_table "dvtable_{6b2a1a28-c249-4914-812a-cc10c559d598}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "CardTypeID",      limit: nil
    t.integer "LinkType"
    t.string  "LinkID",          limit: nil
    t.string  "LinkDescription", limit: 32
    t.string  "TypeID",          limit: nil
    t.boolean "CopyProperties"
    t.boolean "CopyCategories"
    t.integer "CopyFilesType"
    t.string  "FolderID",        limit: nil
    t.boolean "NoDialog"
  end

  add_index "dvtable_{6b2a1a28-c249-4914-812a-cc10c559d598}", ["ParentRowID"], name: "dvsys_reftypes_defaultlinks_section"

  create_table "dvtable_{6b686240-c853-4543-a659-f4fdacf886f4}", id: false, force: true do |t|
    t.string  "RowID",                                limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",                          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",                      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                                 limit: nil
    t.string  "ProtocolNumerator",                    limit: nil
    t.string  "ProtocolBPTemplate",                   limit: nil
    t.string  "ProtocolBPStartingFolder",             limit: nil
    t.string  "ProtocolBPInstanceFolder",             limit: nil
    t.string  "ProtocolBoardType",                    limit: nil
    t.string  "ProtocolBoardDefault",                 limit: nil
    t.string  "ProtocolDefaultBoard",                 limit: nil
    t.boolean "ProtocolNoApproving"
    t.string  "ProtocolDocPrintTemplate",             limit: nil
    t.boolean "ProtocolAlternativeProcessCorrection"
    t.integer "ProtocolApproveTime"
    t.integer "ProtocolSignTime"
    t.integer "ProtocolCorrectTime"
    t.string  "ProtocolFolder",                       limit: nil
  end

  add_index "dvtable_{6b686240-c853-4543-a659-f4fdacf886f4}", ["InstanceID"], name: "dvsys_refdocsetup_protocolsetup_uc_struct", unique: true

  create_table "dvtable_{6bcfb3d7-a686-4f14-b3e5-8ee2cb8709b4}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.string  "Name",            limit: 256
    t.string  "Tooltip",         limit: 256
    t.binary  "Icon"
    t.text    "Script"
    t.boolean "Toolbar"
    t.boolean "FolderMenu"
    t.boolean "CardMenu"
    t.integer "GridMenu"
    t.string  "ScriptProtect",   limit: 1024
  end

  create_table "dvtable_{6e71a21c-fa5b-4218-8a17-1f47aeba4cd5}", id: false, force: true do |t|
    t.string "RowID",               limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "AssignmentID",        limit: nil
    t.string "DurableAssignmentID", limit: nil
  end

  add_index "dvtable_{6e71a21c-fa5b-4218-8a17-1f47aeba4cd5}", ["InstanceID"], name: "dvsys_protocolcard_assignments_section"

  create_table "dvtable_{6e71a21c-fa5b-4218-8a17-1f47aeba4cd5}_archive", id: false, force: true do |t|
    t.string "RowID",               limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "AssignmentID",        limit: nil
    t.string "DurableAssignmentID", limit: nil
  end

  add_index "dvtable_{6e71a21c-fa5b-4218-8a17-1f47aeba4cd5}_archive", ["InstanceID"], name: "dvsys_protocolcard_assignments_archive_section"

  create_table "dvtable_{7016a8df-7df9-45b6-b8eb-bf94426670be}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "NRDAssignment",   limit: nil
  end

  add_index "dvtable_{7016a8df-7df9-45b6-b8eb-bf94426670be}", ["InstanceID"], name: "dvsys_directioncard_assignmentnrd_section"

  create_table "dvtable_{7016a8df-7df9-45b6-b8eb-bf94426670be}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "NRDAssignment",   limit: nil
  end

  add_index "dvtable_{7016a8df-7df9-45b6-b8eb-bf94426670be}_archive", ["InstanceID"], name: "dvsys_directioncard_assignmentnrd_archive_section"

# Could not dump table "dvtable_{703d75bf-1332-4567-8de9-9da0a0d515d0}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{70c344f8-066e-44de-a673-94c3142c6ca5}", id: false, force: true do |t|
    t.string  "RowID",                                  limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",                            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",                        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                                   limit: nil
    t.string  "DirectionNumerator",                     limit: nil
    t.string  "DirectionBPTemplate",                    limit: nil
    t.string  "DirectionBPStartingFolder",              limit: nil
    t.string  "DirectionBPInstanceFolder",              limit: nil
    t.integer "DirectionSigningDuration"
    t.integer "DirectionCorrectionDuration"
    t.integer "DirectionApprovingDuration"
    t.string  "DirectionEmployee_OD",                   limit: nil
    t.integer "DirectionAssignmentDuration"
    t.string  "DirectionFolder",                        limit: nil
    t.integer "DirectionSendAssignmentToExecuter"
    t.string  "DirectionPrintTemplate",                 limit: nil
    t.string  "DirectionNotificationListPrintTemplate", limit: nil
    t.boolean "DirectionNoApproving"
    t.string  "DirectionNumeratorProject",              limit: nil
    t.string  "DirectionDocPrintSetup",                 limit: nil
    t.boolean "DirectionAlternativeProcessCorrection"
  end

  add_index "dvtable_{70c344f8-066e-44de-a673-94c3142c6ca5}", ["InstanceID"], name: "dvsys_refdocsetup_directionsetup_uc_struct", unique: true

  create_table "dvtable_{715a3aff-93d6-42ce-b8a3-fbae8cba38f3}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Recipient",       limit: nil
    t.string "SendingType",     limit: nil
  end

  add_index "dvtable_{715a3aff-93d6-42ce-b8a3-fbae8cba38f3}", ["InstanceID"], name: "dvsys_registerfolderext_maininfo_uc_struct", unique: true

  create_table "dvtable_{71bb8f13-818b-427c-9570-9dcc52bbfa06}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "Registrator",     limit: nil
  end

  add_index "dvtable_{71bb8f13-818b-427c-9570-9dcc52bbfa06}", ["ParentRowID"], name: "dvsys_refdocsetup_ordertyperegistrators_section"

# Could not dump table "dvtable_{71efd2dd-f6c3-44b8-b3b0-5344e794c9df}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{7213a125-2ca4-40ee-a671-b52850f45e7d}", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",                 limit: 544
    t.string   "NamePID",              limit: nil
    t.text     "Comments"
    t.string   "CommentsPID",          limit: nil
    t.string   "CreatedBy",            limit: nil
    t.string   "CreatedByPID",         limit: nil
    t.string   "RegisteredBy",         limit: nil
    t.string   "RegisteredByPID",      limit: nil
    t.string   "ControlledBy",         limit: nil
    t.string   "ControlledByPID",      limit: nil
    t.boolean  "StartASAP"
    t.integer  "ExpectedDuration"
    t.string   "ExpectedDurationPID",  limit: nil
    t.datetime "ExpectedStartDate"
    t.string   "ExpectedStartDatePID", limit: nil
    t.datetime "ExpectedEndDate"
    t.string   "ExpectedEndDatePID",   limit: nil
    t.boolean  "CreateOutlookTask"
    t.integer  "Reminder"
    t.string   "ReminderPID",          limit: nil
    t.string   "FilesID",              limit: nil
    t.string   "ParentProcessID",      limit: nil
    t.string   "ParentTaskID",         limit: nil
    t.datetime "SettingsStartDate"
    t.datetime "SettingsEndDate"
    t.string   "TaskController",       limit: nil
    t.string   "SignedByPID",          limit: nil
    t.datetime "ControlDate"
    t.string   "ControlDatePID",       limit: nil
    t.integer  "ChildTaskCount"
    t.string   "ParentResolutionID",   limit: nil
    t.string   "ReportID",             limit: nil
    t.string   "PerformerFilesID",     limit: nil
    t.boolean  "IsControllerTask"
    t.string   "ParentApprovalID",     limit: nil
    t.string   "ControlledTaskID",     limit: nil
    t.string   "Type",                 limit: nil
    t.datetime "ReminderDate"
    t.string   "ReminderDatePID",      limit: nil
    t.integer  "WorkDuration"
    t.string   "WorkDurationPID",      limit: nil
    t.integer  "Priority"
    t.string   "RefsID",               limit: nil
  end

  add_index "dvtable_{7213a125-2ca4-40ee-a671-b52850f45e7d}", ["InstanceID"], name: "dvsys_workflowtask_maininfo_uc_struct", unique: true
  add_index "dvtable_{7213a125-2ca4-40ee-a671-b52850f45e7d}", ["ParentProcessID"], name: "dvsys_workflowtask_maininfo_idx_parentprocessid"

  create_table "dvtable_{7213a125-2ca4-40ee-a671-b52850f45e7d}_archive", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",                 limit: 544
    t.string   "NamePID",              limit: nil
    t.text     "Comments"
    t.string   "CommentsPID",          limit: nil
    t.string   "CreatedBy",            limit: nil
    t.string   "CreatedByPID",         limit: nil
    t.string   "RegisteredBy",         limit: nil
    t.string   "RegisteredByPID",      limit: nil
    t.string   "ControlledBy",         limit: nil
    t.string   "ControlledByPID",      limit: nil
    t.boolean  "StartASAP"
    t.integer  "ExpectedDuration"
    t.string   "ExpectedDurationPID",  limit: nil
    t.datetime "ExpectedStartDate"
    t.string   "ExpectedStartDatePID", limit: nil
    t.datetime "ExpectedEndDate"
    t.string   "ExpectedEndDatePID",   limit: nil
    t.boolean  "CreateOutlookTask"
    t.integer  "Reminder"
    t.string   "ReminderPID",          limit: nil
    t.string   "FilesID",              limit: nil
    t.string   "ParentProcessID",      limit: nil
    t.string   "ParentTaskID",         limit: nil
    t.datetime "SettingsStartDate"
    t.datetime "SettingsEndDate"
    t.string   "TaskController",       limit: nil
    t.string   "SignedByPID",          limit: nil
    t.datetime "ControlDate"
    t.string   "ControlDatePID",       limit: nil
    t.integer  "ChildTaskCount"
    t.string   "ParentResolutionID",   limit: nil
    t.string   "ReportID",             limit: nil
    t.string   "PerformerFilesID",     limit: nil
    t.boolean  "IsControllerTask"
    t.string   "ParentApprovalID",     limit: nil
    t.string   "ControlledTaskID",     limit: nil
    t.string   "Type",                 limit: nil
    t.datetime "ReminderDate"
    t.string   "ReminderDatePID",      limit: nil
    t.integer  "WorkDuration"
    t.string   "WorkDurationPID",      limit: nil
    t.integer  "Priority"
    t.string   "RefsID",               limit: nil
  end

  add_index "dvtable_{7213a125-2ca4-40ee-a671-b52850f45e7d}_archive", ["InstanceID"], name: "dvsys_workflowtask_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{729b4f37-4fd9-4319-a7a0-33061efbdb96}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{729b4f37-4fd9-4319-a7a0-33061efbdb96}", ["InstanceID", "ParentRowID"], name: "dvsys_workflowtask_enumvalues_section"
  add_index "dvtable_{729b4f37-4fd9-4319-a7a0-33061efbdb96}", ["ParentRowID"], name: "dvsys_workflowtask_enumvalues_idx_parentrowid"

  create_table "dvtable_{729b4f37-4fd9-4319-a7a0-33061efbdb96}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{729b4f37-4fd9-4319-a7a0-33061efbdb96}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_workflowtask_enumvalues_archive_section"
  add_index "dvtable_{729b4f37-4fd9-4319-a7a0-33061efbdb96}_archive", ["ParentRowID"], name: "dvsys_workflowtask_enumvalues_archive_idx_parentrowid"

  create_table "dvtable_{72a6cb51-aad5-4b65-9018-bafed95e3f96}", id: false, force: true do |t|
    t.string "RowID",                         limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",                    limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",                   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                          limit: nil
    t.string "AssignmentNumerator",           limit: nil
    t.string "AssignmentBPTemplate",          limit: nil
    t.string "AssignmentBPStartingFolder",    limit: nil
    t.string "AssignmentBPInstanceFolder",    limit: nil
    t.string "AssignmentStoreFolder",         limit: nil
    t.string "AssignmentKindDict",            limit: nil
    t.string "AssignmentKindAssignment",      limit: nil
    t.string "AssignmentKindIncDoc",          limit: nil
    t.string "AssignmentKindOrder",           limit: nil
    t.string "AssignmentKindDirection",       limit: nil
    t.string "AssignmentKindProtocol",        limit: nil
    t.string "AssignmentKindOrderApprove",    limit: nil
    t.string "AssignmentKindContractApprove", limit: nil
    t.string "AssignmentRecallBPTemplate",    limit: nil
    t.string "AssignmentRecallSubBPTemplate", limit: nil
    t.string "AssignmentKindOutDocApprove",   limit: nil
    t.string "AssignmentKindOutDocSign",      limit: nil
    t.string "AssignmentKindOutDoc",          limit: nil
    t.string "AssignmentKindMemoApprove",     limit: nil
    t.string "AssignmentKindMemoSign",        limit: nil
    t.string "AssignmentKindMemoView",        limit: nil
    t.string "AssignmentKindMemo",            limit: nil
    t.string "AssignmentKindIncDocTask",      limit: nil
    t.string "AssignmentKindNotify",          limit: nil
    t.string "AssignmentKindIncDocNotify",    limit: nil
    t.string "AssignmentKindMemoNotify",      limit: nil
    t.string "AssignmentKindOutDocNotify",    limit: nil
    t.string "AssignmentKindProtocolNotify",  limit: nil
  end

  add_index "dvtable_{72a6cb51-aad5-4b65-9018-bafed95e3f96}", ["InstanceID"], name: "dvsys_refdocsetup_assignmentsetup_uc_struct", unique: true

  create_table "dvtable_{733bfc64-32d2-440b-b8da-0b82d0674bf0}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{733bfc64-32d2-440b-b8da-0b82d0674bf0}", ["InstanceID", "ParentRowID"], name: "dvsys_workflowtask_completionenumvalues_section"
  add_index "dvtable_{733bfc64-32d2-440b-b8da-0b82d0674bf0}", ["ParentRowID"], name: "dvsys_workflowtask_completionenumvalues_idx_parentrowid"

  create_table "dvtable_{733bfc64-32d2-440b-b8da-0b82d0674bf0}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{733bfc64-32d2-440b-b8da-0b82d0674bf0}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_workflowtask_completionenumvalues_archive_section"
  add_index "dvtable_{733bfc64-32d2-440b-b8da-0b82d0674bf0}_archive", ["ParentRowID"], name: "dvsys_workflowtask_completionenumvalues_archive_idx_parentrowid"

  create_table "dvtable_{7379fd49-6fda-4b22-b99d-8040f3000869}", id: false, force: true do |t|
    t.string  "RowID",                                  limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",                            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",                        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                                   limit: nil
    t.string  "MemorandumNumerator",                    limit: nil
    t.string  "MemorandumBPTemplate",                   limit: nil
    t.string  "MemorandumBPStartingFolder",             limit: nil
    t.string  "MemorandumBPInstanceFolder",             limit: nil
    t.integer "MemorandumApprovingDuration"
    t.integer "MemorandumSigningDuration"
    t.integer "MemorandumCorrectionDuration"
    t.string  "MemorandumFolder",                       limit: nil
    t.string  "MemorandumPrintTemplate",                limit: nil
    t.string  "MemorandumApprovalListPrintTemplate",    limit: nil
    t.boolean "MemorandumNoApproving"
    t.string  "MemorandumNumeratorProject",             limit: nil
    t.boolean "MemorandumAlternativeProcessCorrection"
    t.boolean "SendToSignerFirst"
    t.integer "ImproveBy",                                          default: 1
  end

  add_index "dvtable_{7379fd49-6fda-4b22-b99d-8040f3000869}", ["InstanceID"], name: "dvsys_refdocsetup_memorandumsetup_uc_struct", unique: true

  create_table "dvtable_{7473f07f-11ed-4762-9f1e-7ff10808ddd1}", id: false, force: true do |t|
    t.string  "RowID",                limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",           limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",          limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                 limit: nil
    t.string  "Name"
    t.integer "Type"
    t.string  "Manager",              limit: nil
    t.string  "ContactPerson",        limit: nil
    t.string  "Phone",                limit: 64
    t.string  "Fax",                  limit: 64
    t.string  "Email",                limit: 64
    t.string  "Telex",                limit: 32
    t.string  "Account",              limit: 64
    t.string  "CorrespondentAccount", limit: 64
    t.string  "BankName",             limit: 64
    t.string  "BIK",                  limit: 128
    t.string  "INN",                  limit: 128
    t.string  "KPP",                  limit: 32
    t.string  "OKPO",                 limit: 128
    t.string  "OKONH",                limit: 128
    t.string  "RootFolder",           limit: nil
    t.string  "TaskFolder",           limit: nil
    t.string  "IncomingFolder",       limit: nil
    t.string  "OutgoingFolder",       limit: nil
    t.string  "ResolutionFolder",     limit: nil
    t.text    "Comments"
    t.string  "CalendarID",           limit: nil
    t.string  "FullName",             limit: 1024
    t.string  "SyncTag",              limit: 256
    t.boolean "NotAvailable",                      default: false
    t.string  "ADsPath",              limit: 1024
    t.string  "ADsID",                limit: 64
    t.boolean "ADsNotSynchronize"
    t.string  "Code",                 limit: 16
    t.string  "NameUID",              limit: nil
  end

  add_index "dvtable_{7473f07f-11ed-4762-9f1e-7ff10808ddd1}", ["INN"], name: "dvsys_refstaff_units_idx_inn"
  add_index "dvtable_{7473f07f-11ed-4762-9f1e-7ff10808ddd1}", ["Name", "ParentTreeRowID", "NameUID"], name: "dvsys_refstaff_units_uc_tree_name", unique: true
  add_index "dvtable_{7473f07f-11ed-4762-9f1e-7ff10808ddd1}", ["ParentTreeRowID"], name: "dvsys_refstaff_units_section"

  create_table "dvtable_{74cec36b-5944-4e64-b27e-93cf580b8f46}", id: false, force: true do |t|
    t.string   "RowID",               limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",          limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",         limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "SDID",                limit: nil
    t.string   "Name",                limit: 256
    t.datetime "CreationDate"
    t.integer  "VolumeCount"
    t.string   "Location",            limit: 128
    t.integer  "StoreLife"
    t.string   "Index",               limit: 64
    t.string   "Comment",             limit: 1024
    t.string   "SyncTag",             limit: 256
    t.boolean  "NotAvailable",                     default: false
    t.boolean  "StorePermanent"
    t.string   "DisplayString",       limit: 1024
    t.datetime "StoreFrom"
    t.datetime "StoreTo"
    t.string   "StoreRemarks",        limit: 32
    t.string   "NameCreationDateUID", limit: nil
  end

  add_index "dvtable_{74cec36b-5944-4e64-b27e-93cf580b8f46}", ["Name", "CreationDate", "ParentTreeRowID", "NameCreationDateUID"], name: "dvsys_refcases_cases_uc_tree_namecreationdate", unique: true
  add_index "dvtable_{74cec36b-5944-4e64-b27e-93cf580b8f46}", ["ParentTreeRowID"], name: "dvsys_refcases_cases_section"

  create_table "dvtable_{75542450-18ab-4042-8d30-7b38216ece98}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SectionName",     limit: 128
    t.boolean "IsTable"
    t.integer "Left"
    t.integer "Top"
    t.integer "Width"
    t.integer "Height"
    t.integer "Page"
    t.string  "Rights",          limit: nil
  end

  add_index "dvtable_{75542450-18ab-4042-8d30-7b38216ece98}", ["ParentRowID"], name: "dvsys_reftypes_tabsections_section"

# Could not dump table "dvtable_{75cffade-7d24-4dfe-ace7-4c7a812bef1e}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{760cfc1e-f033-4fa2-a364-b3ce538161d9}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{760cfc1e-f033-4fa2-a364-b3ce538161d9}", ["CategoryID", "InstanceID", "CategoryIDUID"], name: "dvsys_cardout_categories_uc_card_categoryid", unique: true
  add_index "dvtable_{760cfc1e-f033-4fa2-a364-b3ce538161d9}", ["InstanceID"], name: "dvsys_cardout_categories_section"

  create_table "dvtable_{760cfc1e-f033-4fa2-a364-b3ce538161d9}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{760cfc1e-f033-4fa2-a364-b3ce538161d9}_archive", ["InstanceID"], name: "dvsys_cardout_categories_archive_section"

  create_table "dvtable_{768c1f87-925c-40e2-9695-3a6498412c25}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.string  "Name",            limit: 128
    t.string  "Comment",         limit: 2048
    t.boolean "IsDefault"
  end

# Could not dump table "dvtable_{768fe177-ac8d-4866-8523-3e0049146f65}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{768fe177-ac8d-4866-8523-3e0049146f65}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{76938c95-9f44-4c38-bd6b-5b786edf8a34}", id: false, force: true do |t|
    t.string  "RowID",                limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",           limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",          limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ApproverID",           limit: nil
    t.integer "State",                             default: 0
    t.string  "Comments",             limit: 2048
    t.string  "TaskID",               limit: nil
    t.integer "Order"
    t.integer "Duration"
    t.string  "ControlTaskID",        limit: nil
    t.boolean "NotApprovedDisabled"
    t.integer "ApproverType"
    t.string  "ApproverName",         limit: 256
    t.string  "ApproverPositionID",   limit: nil
    t.string  "ApproverDepartmentID", limit: nil
    t.boolean "EmailNotification"
  end

  add_index "dvtable_{76938c95-9f44-4c38-bd6b-5b786edf8a34}", ["InstanceID", "ParentRowID"], name: "dvsys_cardapproval_approvers_section"
  add_index "dvtable_{76938c95-9f44-4c38-bd6b-5b786edf8a34}", ["ParentRowID"], name: "dvsys_cardapproval_approvers_idx_parentrowid"

  create_table "dvtable_{76938c95-9f44-4c38-bd6b-5b786edf8a34}_archive", id: false, force: true do |t|
    t.string  "RowID",                limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",           limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",          limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ApproverID",           limit: nil
    t.integer "State"
    t.string  "Comments",             limit: 2048
    t.string  "TaskID",               limit: nil
    t.integer "Order"
    t.integer "Duration"
    t.string  "ControlTaskID",        limit: nil
    t.boolean "NotApprovedDisabled"
    t.integer "ApproverType"
    t.string  "ApproverName",         limit: 256
    t.string  "ApproverPositionID",   limit: nil
    t.string  "ApproverDepartmentID", limit: nil
    t.boolean "EmailNotification"
  end

  add_index "dvtable_{76938c95-9f44-4c38-bd6b-5b786edf8a34}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardapproval_approvers_archive_section"
  add_index "dvtable_{76938c95-9f44-4c38-bd6b-5b786edf8a34}_archive", ["ParentRowID"], name: "dvsys_cardapproval_approvers_archive_idx_parentrowid"

  create_table "dvtable_{769b4c6c-0c5e-4e86-908a-61c553004fb2}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Contract",        limit: nil
  end

  add_index "dvtable_{769b4c6c-0c5e-4e86-908a-61c553004fb2}", ["InstanceID"], name: "dvsys_contractplan_references_section"

  create_table "dvtable_{769b4c6c-0c5e-4e86-908a-61c553004fb2}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Contract",        limit: nil
  end

  add_index "dvtable_{769b4c6c-0c5e-4e86-908a-61c553004fb2}_archive", ["InstanceID"], name: "dvsys_contractplan_references_archive_section"

  create_table "dvtable_{77a196d6-b596-4e46-baa8-d16d023eaba0}", id: false, force: true do |t|
    t.string "RowID",            limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "RepresentativeID", limit: nil
  end

  add_index "dvtable_{77a196d6-b596-4e46-baa8-d16d023eaba0}", ["InstanceID", "ParentRowID"], name: "dvsys_warrantcard_representatives_section"
  add_index "dvtable_{77a196d6-b596-4e46-baa8-d16d023eaba0}", ["ParentRowID"], name: "dvsys_warrantcard_representatives_idx_parentrowid"

  create_table "dvtable_{77a196d6-b596-4e46-baa8-d16d023eaba0}_archive", id: false, force: true do |t|
    t.string "RowID",            limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "RepresentativeID", limit: nil
  end

  add_index "dvtable_{77a196d6-b596-4e46-baa8-d16d023eaba0}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_warrantcard_representatives_archive_section"
  add_index "dvtable_{77a196d6-b596-4e46-baa8-d16d023eaba0}_archive", ["ParentRowID"], name: "dvsys_warrantcard_representatives_archive_idx_parentrowid"

  create_table "dvtable_{77c70c13-881a-4534-9704-c4f6b9acdb0a}", id: false, force: true do |t|
    t.string   "RowID",                 limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",            limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",           limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",       limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",                  limit: 544
    t.string   "Type",                  limit: nil
    t.string   "CreatedBy",             limit: nil
    t.string   "RegisteredBy",          limit: nil
    t.datetime "SignedDate"
    t.string   "ControlledBy",          limit: nil
    t.integer  "ControllerRoutingType"
    t.datetime "CreationDate"
    t.datetime "StartDate"
    t.datetime "ExpectedEndDate"
    t.integer  "ExpectedDuration"
    t.datetime "ActualEndDate"
    t.integer  "ResolutionState",                    default: 0
    t.integer  "ProcessingType",                     default: 0
    t.string   "ParentCardID",          limit: nil
    t.string   "FilesID",               limit: nil
    t.text     "Comments"
    t.string   "Performers",            limit: 2048
    t.string   "Responsible",           limit: 256
    t.string   "CalendarID",            limit: nil
    t.datetime "ControlDate"
    t.boolean  "IsUrgent"
    t.integer  "ControlType",                        default: 0
    t.boolean  "IsOwnProcess"
    t.string   "ProcessID",             limit: nil
    t.string   "ProcessFolder",         limit: nil
    t.integer  "PollingInterval"
    t.boolean  "KeepTasks"
    t.boolean  "LightFormDefault",                   default: true
    t.string   "ParentName",            limit: 512
    t.string   "ParentTypeID",          limit: nil
    t.string   "ParentNumber",          limit: 160
    t.datetime "ParentRegDate"
    t.boolean  "PropsAsForm"
    t.boolean  "AddParentRef"
    t.boolean  "CanModifyParent"
    t.boolean  "IsOverdue"
    t.boolean  "IsCustomProcess"
    t.string   "StartDateParam",        limit: 64
    t.string   "ExpectedEndDateParam",  limit: 64
    t.string   "ControlDateParam",      limit: 64
    t.datetime "ReminderDate"
    t.string   "ReminderDateParam",     limit: 64
    t.boolean  "DefaultUseCalendar"
    t.boolean  "SendAsHTML"
    t.boolean  "UseReminderDate"
    t.integer  "WorkDuration"
  end

  add_index "dvtable_{77c70c13-881a-4534-9704-c4f6b9acdb0a}", ["InstanceID"], name: "dvsys_cardresolution_maininfo_uc_struct", unique: true
  add_index "dvtable_{77c70c13-881a-4534-9704-c4f6b9acdb0a}", ["ResolutionState"], name: "dvsys_cardresolution_maininfo_idx_resolutionstate"

  create_table "dvtable_{77c70c13-881a-4534-9704-c4f6b9acdb0a}_archive", id: false, force: true do |t|
    t.string   "RowID",                 limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",            limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",           limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",       limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",                  limit: 544
    t.string   "Type",                  limit: nil
    t.string   "CreatedBy",             limit: nil
    t.string   "RegisteredBy",          limit: nil
    t.datetime "SignedDate"
    t.string   "ControlledBy",          limit: nil
    t.integer  "ControllerRoutingType"
    t.datetime "CreationDate"
    t.datetime "StartDate"
    t.datetime "ExpectedEndDate"
    t.integer  "ExpectedDuration"
    t.datetime "ActualEndDate"
    t.integer  "ResolutionState"
    t.integer  "ProcessingType"
    t.string   "ParentCardID",          limit: nil
    t.string   "FilesID",               limit: nil
    t.text     "Comments"
    t.string   "Performers",            limit: 2048
    t.string   "Responsible",           limit: 256
    t.string   "CalendarID",            limit: nil
    t.datetime "ControlDate"
    t.boolean  "IsUrgent"
    t.integer  "ControlType"
    t.boolean  "IsOwnProcess"
    t.string   "ProcessID",             limit: nil
    t.string   "ProcessFolder",         limit: nil
    t.integer  "PollingInterval"
    t.boolean  "KeepTasks"
    t.boolean  "LightFormDefault"
    t.string   "ParentName",            limit: 512
    t.string   "ParentTypeID",          limit: nil
    t.string   "ParentNumber",          limit: 160
    t.datetime "ParentRegDate"
    t.boolean  "PropsAsForm"
    t.boolean  "AddParentRef"
    t.boolean  "CanModifyParent"
    t.boolean  "IsOverdue"
    t.boolean  "IsCustomProcess"
    t.string   "StartDateParam",        limit: 64
    t.string   "ExpectedEndDateParam",  limit: 64
    t.string   "ControlDateParam",      limit: 64
    t.datetime "ReminderDate"
    t.string   "ReminderDateParam",     limit: 64
    t.boolean  "DefaultUseCalendar"
    t.boolean  "SendAsHTML"
    t.boolean  "UseReminderDate"
    t.integer  "WorkDuration"
  end

  add_index "dvtable_{77c70c13-881a-4534-9704-c4f6b9acdb0a}_archive", ["InstanceID"], name: "dvsys_cardresolution_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{787e0dc1-7ecf-4ed7-a93d-12e0d7d7b792}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Template",        limit: nil
    t.integer "ApprovingType"
  end

  add_index "dvtable_{787e0dc1-7ecf-4ed7-a93d-12e0d7d7b792}", ["InstanceID"], name: "dvsys_directioncard_approvallist_uc_struct", unique: true

  create_table "dvtable_{787e0dc1-7ecf-4ed7-a93d-12e0d7d7b792}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Template",        limit: nil
    t.integer "ApprovingType"
  end

  add_index "dvtable_{787e0dc1-7ecf-4ed7-a93d-12e0d7d7b792}_archive", ["InstanceID"], name: "dvsys_directioncard_approvallist_archive_uc_struct", unique: true

  create_table "dvtable_{78875629-78d3-4ccc-90d9-127b438c5522}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                   null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "Name",            limit: 128
    t.string "Comments",        limit: 1024
    t.string "NameUID",         limit: nil
  end

  add_index "dvtable_{78875629-78d3-4ccc-90d9-127b438c5522}", ["Name", "ParentTreeRowID", "NameUID"], name: "dvsys_refpartners_groups_uc_tree_name", unique: true
  add_index "dvtable_{78875629-78d3-4ccc-90d9-127b438c5522}", ["ParentTreeRowID"], name: "dvsys_refpartners_groups_section"

  create_table "dvtable_{78b8ad66-45d3-4ad0-ab4b-6d27724a77f8}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "OrderTypeSigner", limit: nil
  end

  add_index "dvtable_{78b8ad66-45d3-4ad0-ab4b-6d27724a77f8}", ["ParentRowID"], name: "dvsys_refdocsetup_ordertypesigners_section"

# Could not dump table "dvtable_{78bad58a-fdc2-4223-98b1-a286c6c76a66}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{797a212a-0291-42d4-8a0d-cbc77069a9fe}", id: false, force: true do |t|
    t.string   "RowID",                        limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",                  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",              limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "RegistrationNumber",           limit: 256
    t.datetime "RegistrationDate"
    t.string   "RegisteredBy",                 limit: nil
    t.integer  "State"
    t.string   "Partner",                      limit: nil
    t.datetime "PlannedDate"
    t.integer  "DocumentType"
    t.text     "Description"
    t.string   "CuratingDept",                 limit: nil
    t.datetime "PlannedStartJobDate"
    t.datetime "PlannedEndJobDate"
    t.float    "Amount",                       limit: 24,  default: 0.0
    t.integer  "Currency"
    t.text     "DealReason"
    t.text     "ProtocolKK"
    t.string   "TenderDeptNotification",       limit: nil
    t.string   "RegistrationNumberID",         limit: nil
    t.datetime "PlannedApprovingStartingDate"
    t.string   "LegacySystemID",               limit: 256
    t.integer  "AccountingPeriod"
    t.integer  "Year"
    t.string   "RefsID",                       limit: nil
    t.string   "BarcodeNumber",                limit: 40
    t.string   "BarcodeNumberID",              limit: nil
    t.string   "TransferLog",                  limit: nil
    t.text     "CancellationComment"
    t.string   "CancellationLinkedDocument",   limit: nil
    t.string   "CancellationFile",             limit: nil
    t.datetime "CancellationDate"
    t.string   "CancellationEmployee",         limit: nil
  end

  add_index "dvtable_{797a212a-0291-42d4-8a0d-cbc77069a9fe}", ["InstanceID"], name: "dvsys_contractplan_maininfo_uc_struct", unique: true

  create_table "dvtable_{797a212a-0291-42d4-8a0d-cbc77069a9fe}_archive", id: false, force: true do |t|
    t.string   "RowID",                        limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",                  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",              limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "RegistrationNumber",           limit: 256
    t.datetime "RegistrationDate"
    t.string   "RegisteredBy",                 limit: nil
    t.integer  "State"
    t.string   "Partner",                      limit: nil
    t.datetime "PlannedDate"
    t.integer  "DocumentType"
    t.text     "Description"
    t.string   "CuratingDept",                 limit: nil
    t.datetime "PlannedStartJobDate"
    t.datetime "PlannedEndJobDate"
    t.float    "Amount",                       limit: 24
    t.integer  "Currency"
    t.text     "DealReason"
    t.text     "ProtocolKK"
    t.string   "TenderDeptNotification",       limit: nil
    t.string   "RegistrationNumberID",         limit: nil
    t.datetime "PlannedApprovingStartingDate"
    t.string   "LegacySystemID",               limit: 256
    t.integer  "AccountingPeriod"
    t.integer  "Year"
    t.string   "RefsID",                       limit: nil
    t.string   "BarcodeNumber",                limit: 40
    t.string   "BarcodeNumberID",              limit: nil
    t.string   "TransferLog",                  limit: nil
    t.text     "CancellationComment"
    t.string   "CancellationLinkedDocument",   limit: nil
    t.string   "CancellationFile",             limit: nil
    t.datetime "CancellationDate"
    t.string   "CancellationEmployee",         limit: nil
  end

  add_index "dvtable_{797a212a-0291-42d4-8a0d-cbc77069a9fe}_archive", ["InstanceID"], name: "dvsys_contractplan_maininfo_archive_uc_struct", unique: true

# Could not dump table "dvtable_{79f5b1f6-6bd0-499b-9093-232989bdcc6e}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{79f5b1f6-6bd0-499b-9093-232989bdcc6e}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{7a357c7b-7c36-48c8-8008-294b00f48ab2}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Name",            limit: 64
    t.integer "FirstNumber"
    t.integer "LastNumber"
    t.boolean "NotAvailable",                default: false
  end

  add_index "dvtable_{7a357c7b-7c36-48c8-8008-294b00f48ab2}", ["InstanceID"], name: "dvsys_numeratorcard_numerator_uc_struct", unique: true

  create_table "dvtable_{7a9f0d60-444e-41af-845e-4f4e94f43a52}", id: false, force: true do |t|
    t.string   "RowID",            limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "CardFileID",       limit: nil
    t.integer  "FileType",                     default: 0
    t.boolean  "CanModify"
    t.string   "ApproverRowID",    limit: nil
    t.string   "ResultFolder",     limit: nil
    t.boolean  "IsNew"
    t.boolean  "IsDeleted"
    t.integer  "FileState",                    default: 0
    t.string   "FileRowID",        limit: nil
    t.string   "LastEmployeeID",   limit: nil
    t.datetime "LastDate"
    t.datetime "IsCheckedOut"
    t.string   "VerCardFileID",    limit: nil
    t.text     "FileRemarks"
    t.string   "CardRefID",        limit: nil
    t.string   "OriginalFileName", limit: 512
    t.boolean  "ApproveOriginal"
  end

  add_index "dvtable_{7a9f0d60-444e-41af-845e-4f4e94f43a52}", ["InstanceID", "ParentRowID"], name: "dvsys_cardapproval_files_section"
  add_index "dvtable_{7a9f0d60-444e-41af-845e-4f4e94f43a52}", ["ParentRowID"], name: "dvsys_cardapproval_files_idx_parentrowid"

  create_table "dvtable_{7a9f0d60-444e-41af-845e-4f4e94f43a52}_archive", id: false, force: true do |t|
    t.string   "RowID",            limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "CardFileID",       limit: nil
    t.integer  "FileType"
    t.boolean  "CanModify"
    t.string   "ApproverRowID",    limit: nil
    t.string   "ResultFolder",     limit: nil
    t.boolean  "IsNew"
    t.boolean  "IsDeleted"
    t.integer  "FileState"
    t.string   "FileRowID",        limit: nil
    t.string   "LastEmployeeID",   limit: nil
    t.datetime "LastDate"
    t.datetime "IsCheckedOut"
    t.string   "VerCardFileID",    limit: nil
    t.text     "FileRemarks"
    t.string   "CardRefID",        limit: nil
    t.string   "OriginalFileName", limit: 512
    t.boolean  "ApproveOriginal"
  end

  add_index "dvtable_{7a9f0d60-444e-41af-845e-4f4e94f43a52}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardapproval_files_archive_section"
  add_index "dvtable_{7a9f0d60-444e-41af-845e-4f4e94f43a52}_archive", ["ParentRowID"], name: "dvsys_cardapproval_files_archive_idx_parentrowid"

  create_table "dvtable_{7ada8173-9705-4a1a-959f-938291b6a10c}", id: false, force: true do |t|
    t.string  "RowID",                              limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",                        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",                    limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                               limit: nil
    t.string  "OutDocNumerator",                    limit: nil
    t.string  "OutDocBPTemplate",                   limit: nil
    t.string  "OutDocBPStartingFolder",             limit: nil
    t.string  "OutDocBPInstanceFolder",             limit: nil
    t.integer "OutDocApprovingDuration"
    t.integer "OutDocSigningDuration"
    t.integer "OutDocCorrectionDuration"
    t.string  "OutdocFolder",                       limit: nil
    t.string  "OutDocLetterOrganization",           limit: nil
    t.integer "OutDocSendAssignmentToExecuter"
    t.string  "OutDocPrintTemplate",                limit: nil
    t.string  "OutDocLetterPrintTemplate",          limit: nil
    t.string  "OutDocRecipientsPrintTemplate",      limit: nil
    t.string  "OutDocBPInterruptTemplate",          limit: nil
    t.boolean "OutDocNoApproving"
    t.string  "OutDocNumeratorProject",             limit: nil
    t.boolean "OutDocAlternativeProcessCorrection"
    t.integer "OutDocDefaultSendingKind"
    t.integer "ImproveBy",                                      default: 1
  end

  add_index "dvtable_{7ada8173-9705-4a1a-959f-938291b6a10c}", ["InstanceID"], name: "dvsys_refdocsetup_outdocsetup_uc_struct", unique: true

  create_table "dvtable_{7afa5ed9-13ca-46f9-af97-b4d8d30ba7d4}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "FieldName",       limit: 128
    t.boolean "FirstLetterOnly"
    t.string  "Prefix",          limit: 16
    t.string  "Suffix",          limit: 16
    t.boolean "IsProperty"
  end

  add_index "dvtable_{7afa5ed9-13ca-46f9-af97-b4d8d30ba7d4}", ["ParentRowID"], name: "dvsys_reftypes_tasknameformat_section"

  create_table "dvtable_{7b2e8093-a960-44c1-8f02-5f8b381b5398}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ViewID",          limit: nil
    t.string "AccessID",        limit: nil
  end

  add_index "dvtable_{7b2e8093-a960-44c1-8f02-5f8b381b5398}", ["ParentRowID"], name: "dvsys_folderscard_allowedviews_section"

  create_table "dvtable_{7b94a4fd-45c6-417a-af75-57587be22064}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "FolderTypeID",    limit: nil
    t.string "AccessID",        limit: nil
  end

  add_index "dvtable_{7b94a4fd-45c6-417a-af75-57587be22064}", ["ParentRowID"], name: "dvsys_foldertypescard_allowedfoldertypes_section"

  create_table "dvtable_{7d198b92-f97c-497d-b170-59e19e9a8942}", id: false, force: true do |t|
    t.string "RowID",                  limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                   limit: nil
    t.string "ContractSignedByPerson", limit: nil
  end

  add_index "dvtable_{7d198b92-f97c-497d-b170-59e19e9a8942}", ["ParentRowID"], name: "dvsys_refdocsetup_contractsingedbypersons_section"

  create_table "dvtable_{7dcefca1-1c83-4cfe-8c6d-4322143beafe}", id: false, force: true do |t|
    t.string "RowID",              limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",    limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",               limit: nil
    t.string "MemorandumEmployee", limit: nil
    t.string "MemorandumPrefix",   limit: 256
  end

  add_index "dvtable_{7dcefca1-1c83-4cfe-8c6d-4322143beafe}", ["ParentRowID"], name: "dvsys_refdocsetup_memorandumpersonnumerators_section"

  create_table "dvtable_{7df4140a-4664-406f-b704-982d06a3f521}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean "Reserved"
    t.integer "SyncFlags"
  end

  add_index "dvtable_{7df4140a-4664-406f-b704-982d06a3f521}", ["InstanceID"], name: "dvsys_refstaff_usersettings_uc_struct", unique: true

  create_table "dvtable_{7df4140a-4664-406f-b704-982d06a3f521}_userdependent", id: false, force: true do |t|
    t.string  "RowID",        limit: nil,                 null: false
    t.string  "UserID",       limit: nil,                 null: false
    t.boolean "IsSearchMode",             default: false
    t.integer "SearchFor",                default: 0
    t.integer "OpenMode"
  end

  create_table "dvtable_{7eb8f57c-e9bb-4472-9699-54346149be2d}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "DocTypeID",       limit: nil
    t.string "NumberPrefix",    limit: 32
    t.string "NumberSuffix",    limit: 32
    t.string "DocTypeIDUID",    limit: nil
  end

  add_index "dvtable_{7eb8f57c-e9bb-4472-9699-54346149be2d}", ["DocTypeID", "ParentRowID", "DocTypeIDUID"], name: "dvsys_refnumerators_documenttypes_uc_section_doctypeid", unique: true
  add_index "dvtable_{7eb8f57c-e9bb-4472-9699-54346149be2d}", ["ParentRowID"], name: "dvsys_refnumerators_documenttypes_section"

  create_table "dvtable_{7ecbc5ef-61b7-40c6-96de-b1889a5adadd}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Type",            limit: nil
    t.string   "Link",            limit: nil
    t.string   "Comments",        limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "URL",             limit: 512
    t.string   "LinkDesc",        limit: 32
    t.string   "FolderID",        limit: nil
  end

  add_index "dvtable_{7ecbc5ef-61b7-40c6-96de-b1889a5adadd}", ["InstanceID"], name: "dvsys_cardarchive_cardreferences_section"

  create_table "dvtable_{7ecbc5ef-61b7-40c6-96de-b1889a5adadd}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Type",            limit: nil
    t.string   "Link",            limit: nil
    t.string   "Comments",        limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "URL",             limit: 512
    t.string   "LinkDesc",        limit: 32
    t.string   "FolderID",        limit: nil
  end

  add_index "dvtable_{7ecbc5ef-61b7-40c6-96de-b1889a5adadd}_archive", ["InstanceID"], name: "dvsys_cardarchive_cardreferences_archive_section"

  create_table "dvtable_{7edf1f7e-9e62-4621-aad1-5e24833bde50}", id: false, force: true do |t|
    t.string "RowID",             limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "DefaultCalendarID", limit: nil
  end

  add_index "dvtable_{7edf1f7e-9e62-4621-aad1-5e24833bde50}", ["InstanceID"], name: "dvsys_refreports_mainconfig_uc_struct", unique: true

  create_table "dvtable_{7ef9ffb7-2e6d-416b-8145-f1713d77cd2b}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Type",            limit: nil
    t.string   "Link",            limit: nil
    t.string   "Comments",        limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "URL",             limit: 512
    t.string   "LinkDesc",        limit: 32
    t.string   "FolderID",        limit: nil
  end

  add_index "dvtable_{7ef9ffb7-2e6d-416b-8145-f1713d77cd2b}", ["InstanceID"], name: "dvsys_cardord_cardreferences_section"

  create_table "dvtable_{7ef9ffb7-2e6d-416b-8145-f1713d77cd2b}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Type",            limit: nil
    t.string   "Link",            limit: nil
    t.string   "Comments",        limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "URL",             limit: 512
    t.string   "LinkDesc",        limit: 32
    t.string   "FolderID",        limit: nil
  end

  add_index "dvtable_{7ef9ffb7-2e6d-416b-8145-f1713d77cd2b}_archive", ["InstanceID"], name: "dvsys_cardord_cardreferences_archive_section"

  create_table "dvtable_{7f553f11-6e51-4430-b868-29571ebc9813}", id: false, force: true do |t|
    t.string   "RowID",                     limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "AssignmentID",              limit: nil
    t.string   "AssignmentsControler",      limit: nil
    t.datetime "AssignmentsDeadline"
    t.boolean  "AssignmentsToRead"
    t.text     "AssignmentsComments"
    t.datetime "AssignmentsCompletionDate"
  end

  add_index "dvtable_{7f553f11-6e51-4430-b868-29571ebc9813}", ["InstanceID"], name: "dvsys_directivecard_assignments_section"

  create_table "dvtable_{7f553f11-6e51-4430-b868-29571ebc9813}_archive", id: false, force: true do |t|
    t.string   "RowID",                     limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "AssignmentID",              limit: nil
    t.string   "AssignmentsControler",      limit: nil
    t.datetime "AssignmentsDeadline"
    t.boolean  "AssignmentsToRead"
    t.text     "AssignmentsComments"
    t.datetime "AssignmentsCompletionDate"
  end

  add_index "dvtable_{7f553f11-6e51-4430-b868-29571ebc9813}_archive", ["InstanceID"], name: "dvsys_directivecard_assignments_archive_section"

  create_table "dvtable_{7f6f02b6-ac5c-4ba2-8aba-74a214284bab}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Field1"
  end

  add_index "dvtable_{7f6f02b6-ac5c-4ba2-8aba-74a214284bab}", ["InstanceID"], name: "dvsys_navextensions_maininfo_uc_struct", unique: true

  create_table "dvtable_{7fcc6c72-52a1-4cc7-bb2b-942e5fbfa38d}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "FieldName",       limit: 128
    t.string "ADsName",         limit: 128
    t.string "FieldNameUID",    limit: nil
  end

  add_index "dvtable_{7fcc6c72-52a1-4cc7-bb2b-942e5fbfa38d}", ["FieldName", "FieldNameUID"], name: "dvsys_refstaff_adsmapping_uc_global_fieldname", unique: true

  create_table "dvtable_{801b86ea-3b21-43fa-9ee7-18e017feeced}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Tab"
    t.boolean "Hidden"
    t.boolean "ReadOnly"
    t.string  "TabName",         limit: 32
    t.boolean "IsDefault"
    t.integer "Order"
  end

  add_index "dvtable_{801b86ea-3b21-43fa-9ee7-18e017feeced}", ["ParentRowID"], name: "dvsys_reftypes_cardtabs_section"

  create_table "dvtable_{80314b8b-4825-4205-9fe7-f6b294da9113}", id: false, force: true do |t|
    t.string  "RowID",             limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Assignee",          limit: nil
    t.string  "AssigneeTaskID",    limit: nil
    t.integer "CompletionVariant"
  end

  add_index "dvtable_{80314b8b-4825-4205-9fe7-f6b294da9113}", ["InstanceID", "ParentRowID"], name: "dvsys_assignment_assignees_section"
  add_index "dvtable_{80314b8b-4825-4205-9fe7-f6b294da9113}", ["ParentRowID"], name: "dvsys_assignment_assignees_idx_parentrowid"

  create_table "dvtable_{80314b8b-4825-4205-9fe7-f6b294da9113}_archive", id: false, force: true do |t|
    t.string  "RowID",             limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Assignee",          limit: nil
    t.string  "AssigneeTaskID",    limit: nil
    t.integer "CompletionVariant"
  end

  add_index "dvtable_{80314b8b-4825-4205-9fe7-f6b294da9113}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_assignment_assignees_archive_section"
  add_index "dvtable_{80314b8b-4825-4205-9fe7-f6b294da9113}_archive", ["ParentRowID"], name: "dvsys_assignment_assignees_archive_idx_parentrowid"

  create_table "dvtable_{81100533-0547-416d-b2c3-0bdcb238e60c}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.binary "Icon"
    t.string "Description",     limit: 64
  end

  create_table "dvtable_{822677a9-118c-41e7-b499-6c64a6bb325a}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "Comment",         limit: 2048
    t.boolean  "IsReport"
  end

  add_index "dvtable_{822677a9-118c-41e7-b499-6c64a6bb325a}", ["InstanceID"], name: "dvsys_cardreport_comments_section"

  create_table "dvtable_{822677a9-118c-41e7-b499-6c64a6bb325a}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "Comment",         limit: 2048
    t.boolean  "IsReport"
  end

  add_index "dvtable_{822677a9-118c-41e7-b499-6c64a6bb325a}_archive", ["InstanceID"], name: "dvsys_cardreport_comments_archive_section"

  create_table "dvtable_{829e4aa9-7cf2-466a-a5c7-f9f0d6b426e8}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "Field1"
  end

  add_index "dvtable_{829e4aa9-7cf2-466a-a5c7-f9f0d6b426e8}", ["InstanceID"], name: "dvsys_navextbarcodesbuttons_section1_uc_struct", unique: true

  create_table "dvtable_{82a38d6c-8c60-488a-b397-c40af6c85381}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "EditControler",   limit: nil
    t.datetime "EditDeadline"
    t.boolean  "EditToRead"
    t.text     "EditComments"
  end

  add_index "dvtable_{82a38d6c-8c60-488a-b397-c40af6c85381}", ["InstanceID"], name: "dvsys_nrdcard_assignmentedit_uc_struct", unique: true

  create_table "dvtable_{82a38d6c-8c60-488a-b397-c40af6c85381}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "EditControler",   limit: nil
    t.datetime "EditDeadline"
    t.boolean  "EditToRead"
    t.text     "EditComments"
  end

  add_index "dvtable_{82a38d6c-8c60-488a-b397-c40af6c85381}_archive", ["InstanceID"], name: "dvsys_nrdcard_assignmentedit_archive_uc_struct", unique: true

  create_table "dvtable_{835dd2fa-57f1-4c3f-a37f-d59571a8eb0e}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.string  "SectionName",     limit: 128
    t.boolean "IsTable"
    t.integer "Left"
    t.integer "Top"
    t.integer "Width"
    t.integer "Height"
    t.integer "Page"
    t.integer "ChLeft"
    t.integer "ChTop"
    t.integer "ChWidth"
    t.integer "ChHeight"
    t.integer "ChPage"
  end

  add_index "dvtable_{835dd2fa-57f1-4c3f-a37f-d59571a8eb0e}", ["ParentRowID"], name: "dvsys_refpartners_tabsections_section"

  create_table "dvtable_{8365b413-1100-4a79-ae14-cbe823f2f61b}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{8365b413-1100-4a79-ae14-cbe823f2f61b}", ["InstanceID", "ParentRowID"], name: "dvsys_cardfile_enumvalues_section"
  add_index "dvtable_{8365b413-1100-4a79-ae14-cbe823f2f61b}", ["ParentRowID"], name: "dvsys_cardfile_enumvalues_idx_parentrowid"

  create_table "dvtable_{8365b413-1100-4a79-ae14-cbe823f2f61b}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{8365b413-1100-4a79-ae14-cbe823f2f61b}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardfile_enumvalues_archive_section"
  add_index "dvtable_{8365b413-1100-4a79-ae14-cbe823f2f61b}_archive", ["ParentRowID"], name: "dvsys_cardfile_enumvalues_archive_idx_parentrowid"

  create_table "dvtable_{8427581a-caab-4a36-8f69-b9bcb17c4ab9}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "Order"
    t.string   "Employee",        limit: nil
    t.datetime "StartDate"
    t.datetime "ApprovingDate"
    t.integer  "Decision"
    t.text     "Comments"
    t.boolean  "InParallel"
    t.integer  "OrderType"
    t.boolean  "IsCustom"
    t.boolean  "Required"
    t.boolean  "DenyParallel"
    t.boolean  "IsSigner"
  end

  add_index "dvtable_{8427581a-caab-4a36-8f69-b9bcb17c4ab9}", ["InstanceID", "ParentRowID"], name: "dvsys_approvallist_persons_section"
  add_index "dvtable_{8427581a-caab-4a36-8f69-b9bcb17c4ab9}", ["ParentRowID"], name: "dvsys_approvallist_persons_idx_parentrowid"

  create_table "dvtable_{8427581a-caab-4a36-8f69-b9bcb17c4ab9}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "Order"
    t.string   "Employee",        limit: nil
    t.datetime "StartDate"
    t.datetime "ApprovingDate"
    t.integer  "Decision"
    t.text     "Comments"
    t.boolean  "InParallel"
    t.integer  "OrderType"
    t.boolean  "IsCustom"
    t.boolean  "Required"
    t.boolean  "DenyParallel"
    t.boolean  "IsSigner"
  end

  add_index "dvtable_{8427581a-caab-4a36-8f69-b9bcb17c4ab9}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_approvallist_persons_archive_section"
  add_index "dvtable_{8427581a-caab-4a36-8f69-b9bcb17c4ab9}_archive", ["ParentRowID"], name: "dvsys_approvallist_persons_archive_idx_parentrowid"

  create_table "dvtable_{845bd414-40f0-4540-8be1-c5898b31331f}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "EmployeeID",      limit: nil
    t.integer "Type"
    t.boolean "IsResponsible"
    t.string  "DepartmentID",    limit: nil
    t.string  "PositionID",      limit: nil
    t.integer "ItemType"
  end

  add_index "dvtable_{845bd414-40f0-4540-8be1-c5898b31331f}", ["ParentRowID"], name: "dvsys_reftypes_defaultemployees_section"

  create_table "dvtable_{851b69bd-3f36-4bd9-a5f7-9b80ffea0791}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Assignment",      limit: nil
  end

  add_index "dvtable_{851b69bd-3f36-4bd9-a5f7-9b80ffea0791}", ["InstanceID", "ParentRowID"], name: "dvsys_assignment_linkedassignments_section"
  add_index "dvtable_{851b69bd-3f36-4bd9-a5f7-9b80ffea0791}", ["ParentRowID"], name: "dvsys_assignment_linkedassignments_idx_parentrowid"

  create_table "dvtable_{851b69bd-3f36-4bd9-a5f7-9b80ffea0791}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Assignment",      limit: nil
  end

  add_index "dvtable_{851b69bd-3f36-4bd9-a5f7-9b80ffea0791}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_assignment_linkedassignments_archive_section"
  add_index "dvtable_{851b69bd-3f36-4bd9-a5f7-9b80ffea0791}_archive", ["ParentRowID"], name: "dvsys_assignment_linkedassignments_archive_idx_parentrowid"

  create_table "dvtable_{85395389-ef9b-41be-8154-5b1d128a591f}", id: false, force: true do |t|
    t.string   "RowID",            limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "StateIndex"
    t.datetime "StateHistoryDate"
  end

  add_index "dvtable_{85395389-ef9b-41be-8154-5b1d128a591f}", ["InstanceID"], name: "dvsys_contract_statehistory_section"

  create_table "dvtable_{85395389-ef9b-41be-8154-5b1d128a591f}_archive", id: false, force: true do |t|
    t.string   "RowID",            limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "StateIndex"
    t.datetime "StateHistoryDate"
  end

  add_index "dvtable_{85395389-ef9b-41be-8154-5b1d128a591f}_archive", ["InstanceID"], name: "dvsys_contract_statehistory_archive_section"

  create_table "dvtable_{8551f516-dd89-4b93-993d-076dfe058e4f}", id: false, force: true do |t|
    t.string  "RowID",              limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",    limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.binary  "Replica"
    t.string  "ReplicationCardRef", limit: nil
    t.integer "Operation"
  end

# Could not dump table "dvtable_{859348ed-f999-4139-b259-1e5b5d641d29}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{859623b3-00b6-46dd-ba0a-c258d67fa040}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "OrderEmployee",   limit: nil
  end

  add_index "dvtable_{859623b3-00b6-46dd-ba0a-c258d67fa040}", ["ParentRowID"], name: "dvsys_refdocsetup_orderregistrators_section"

# Could not dump table "dvtable_{85d15f7a-ddee-4484-9b41-57d09e0b1a9a}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{8604c385-a0ff-4dee-bd21-2009c199597f}", id: false, force: true do |t|
    t.string "RowID",             limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",              limit: nil
    t.string "OutDocEmployee_OD", limit: nil
  end

  add_index "dvtable_{8604c385-a0ff-4dee-bd21-2009c199597f}", ["ParentRowID"], name: "dvsys_refdocsetup_outdocemployees_od_section"

  create_table "dvtable_{86af6157-d65a-4f8d-8f92-3daad2910a9b}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "Date"
    t.string   "Executer",        limit: nil
    t.integer  "Decision"
    t.text     "Comment"
    t.string   "TaskID",          limit: nil
    t.string   "Files",           limit: nil
  end

  add_index "dvtable_{86af6157-d65a-4f8d-8f92-3daad2910a9b}", ["InstanceID"], name: "dvsys_assignment_history_section"

  create_table "dvtable_{86af6157-d65a-4f8d-8f92-3daad2910a9b}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "Date"
    t.string   "Executer",        limit: nil
    t.integer  "Decision"
    t.text     "Comment"
    t.string   "TaskID",          limit: nil
    t.string   "Files",           limit: nil
  end

  add_index "dvtable_{86af6157-d65a-4f8d-8f92-3daad2910a9b}_archive", ["InstanceID"], name: "dvsys_assignment_history_archive_section"

  create_table "dvtable_{8746c1f5-bb66-4b00-8d6b-0802025d4572}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "EmployeeID",      limit: nil
  end

# Could not dump table "dvtable_{87768413-16a0-48d5-b7f8-bba4ae65776f}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{87768413-16a0-48d5-b7f8-bba4ae65776f}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{8787f1e9-8fb9-4a0c-b41a-eb3b0d381e55}", id: false, force: true do |t|
    t.string "RowID",                         limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",                    limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",                   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                          limit: nil
    t.string "WarrantNumerator",              limit: nil
    t.string "WarrantBPTemplate",             limit: nil
    t.string "WarrantBPStartingFolder",       limit: nil
    t.string "WarrantBPInstanceFolder",       limit: nil
    t.string "WarrantRootWarrantsFolder",     limit: nil
    t.string "WarrantActiveWarrantsFolder",   limit: nil
    t.string "WarrantInActiveWarrantsFolder", limit: nil
  end

  add_index "dvtable_{8787f1e9-8fb9-4a0c-b41a-eb3b0d381e55}", ["InstanceID"], name: "dvsys_refdocsetup_warrantsetup_uc_struct", unique: true

  create_table "dvtable_{87a4dada-c220-40ca-82a8-3373280ba440}", id: false, force: true do |t|
    t.string   "RowID",             limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",              limit: 544
    t.string   "Type",              limit: nil
    t.string   "CreatedBy",         limit: nil
    t.datetime "CreationDate"
    t.integer  "ReportState",                   default: 0
    t.string   "ParentTaskID",      limit: nil
    t.string   "FilesID",           limit: nil
    t.text     "Comments"
    t.string   "ReportFilesID",     limit: nil
    t.datetime "PlannedDate"
    t.datetime "AcceptDate"
    t.datetime "ControlDate"
    t.datetime "ApprovalDate"
    t.datetime "ConsolidationDate"
    t.datetime "ActualDate"
    t.string   "ControlledBy",      limit: nil
    t.string   "Consolidator",      limit: nil
    t.boolean  "Confidential"
    t.datetime "ChangeDate"
    t.string   "ReportTaskID",      limit: nil
  end

  add_index "dvtable_{87a4dada-c220-40ca-82a8-3373280ba440}", ["InstanceID"], name: "dvsys_cardreport_maininfo_uc_struct", unique: true

  create_table "dvtable_{87a4dada-c220-40ca-82a8-3373280ba440}_archive", id: false, force: true do |t|
    t.string   "RowID",             limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",              limit: 544
    t.string   "Type",              limit: nil
    t.string   "CreatedBy",         limit: nil
    t.datetime "CreationDate"
    t.integer  "ReportState"
    t.string   "ParentTaskID",      limit: nil
    t.string   "FilesID",           limit: nil
    t.text     "Comments"
    t.string   "ReportFilesID",     limit: nil
    t.datetime "PlannedDate"
    t.datetime "AcceptDate"
    t.datetime "ControlDate"
    t.datetime "ApprovalDate"
    t.datetime "ConsolidationDate"
    t.datetime "ActualDate"
    t.string   "ControlledBy",      limit: nil
    t.string   "Consolidator",      limit: nil
    t.boolean  "Confidential"
    t.datetime "ChangeDate"
    t.string   "ReportTaskID",      limit: nil
  end

  add_index "dvtable_{87a4dada-c220-40ca-82a8-3373280ba440}_archive", ["InstanceID"], name: "dvsys_cardreport_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{87c44ddf-7e00-48d4-951e-17997b840309}", id: false, force: true do |t|
    t.string "RowID",                           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",                      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",                     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                            limit: nil
    t.string "RegisterNumerator",               limit: nil
    t.string "RegisterBPTemplateCloseRegister", limit: nil
    t.string "RegisterBPStartingFolder",        limit: nil
    t.string "RegisterBPInstanceFolder",        limit: nil
    t.string "RegistersStoreFolder",            limit: nil
    t.string "RegisterCardFolder",              limit: nil
  end

  add_index "dvtable_{87c44ddf-7e00-48d4-951e-17997b840309}", ["InstanceID"], name: "dvsys_refdocsetup_registersetup_uc_struct", unique: true

  create_table "dvtable_{8806efcd-39e0-40e2-b6a3-f9311d97786b}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Item"
    t.boolean "Hidden"
    t.boolean "ReadOnly"
    t.string  "NewName",         limit: 32
  end

  add_index "dvtable_{8806efcd-39e0-40e2-b6a3-f9311d97786b}", ["ParentRowID"], name: "dvsys_reftypes_cardfunctions_section"

  create_table "dvtable_{882c1df5-127d-4f61-85dc-f44532c4fa8e}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{882c1df5-127d-4f61-85dc-f44532c4fa8e}", ["ParentRowID"], name: "dvsys_refstaff_chenumvalues_section"

  create_table "dvtable_{88b419dd-55fa-4826-844a-e81956d339ee}", id: false, force: true do |t|
    t.string "RowID",               limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                limit: nil
    t.string "DirectiveTypeSigner", limit: nil
  end

  add_index "dvtable_{88b419dd-55fa-4826-844a-e81956d339ee}", ["ParentRowID"], name: "dvsys_refdocsetup_directivetypesigners_section"

  create_table "dvtable_{88de0fe6-c813-46e1-b5d8-4a2d7b68c019}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "PerformerID",     limit: nil
    t.string  "PerformerIDPID",  limit: nil
    t.integer "PerformerType"
    t.integer "RoutingType"
    t.string  "PerformerName",   limit: 256
  end

  add_index "dvtable_{88de0fe6-c813-46e1-b5d8-4a2d7b68c019}", ["InstanceID"], name: "dvsys_workflowtask_performers_section"

  create_table "dvtable_{88de0fe6-c813-46e1-b5d8-4a2d7b68c019}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "PerformerID",     limit: nil
    t.string  "PerformerIDPID",  limit: nil
    t.integer "PerformerType"
    t.integer "RoutingType"
    t.string  "PerformerName",   limit: 256
  end

  add_index "dvtable_{88de0fe6-c813-46e1-b5d8-4a2d7b68c019}_archive", ["InstanceID"], name: "dvsys_workflowtask_performers_archive_section"

  create_table "dvtable_{899c1470-9adf-4d33-8e69-9944eb44dbe7}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.string  "Name",            limit: 128
    t.string  "FolderID",        limit: nil
    t.boolean "SearchChildren"
    t.string  "Comment",         limit: 1024
    t.string  "ViewID",          limit: nil
    t.string  "SyncTag",         limit: 256
    t.boolean "NotAvailable",                 default: false
    t.string  "NameUID",         limit: nil
  end

  add_index "dvtable_{899c1470-9adf-4d33-8e69-9944eb44dbe7}", ["Name", "ParentTreeRowID", "NameUID"], name: "dvsys_refcategories_categories_uc_tree_name", unique: true
  add_index "dvtable_{899c1470-9adf-4d33-8e69-9944eb44dbe7}", ["ParentTreeRowID"], name: "dvsys_refcategories_categories_section"

  create_table "dvtable_{8a576665-4d9b-411c-8da1-d8a801b4f62b}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Category",        limit: nil
  end

  add_index "dvtable_{8a576665-4d9b-411c-8da1-d8a801b4f62b}", ["InstanceID", "ParentRowID"], name: "dvsys_contract_categories_section"
  add_index "dvtable_{8a576665-4d9b-411c-8da1-d8a801b4f62b}", ["ParentRowID"], name: "dvsys_contract_categories_idx_parentrowid"

  create_table "dvtable_{8a576665-4d9b-411c-8da1-d8a801b4f62b}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Category",        limit: nil
  end

  add_index "dvtable_{8a576665-4d9b-411c-8da1-d8a801b4f62b}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_contract_categories_archive_section"
  add_index "dvtable_{8a576665-4d9b-411c-8da1-d8a801b4f62b}_archive", ["ParentRowID"], name: "dvsys_contract_categories_archive_idx_parentrowid"

  create_table "dvtable_{8b9f02c7-dcd9-467d-a2a4-f2e5ef4a061c}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Level"
    t.string  "Name",            limit: 256
    t.string  "Comments",        limit: 2048
    t.boolean "NoReadUp"
    t.boolean "NoWriteUp"
    t.boolean "NoExecuteUp"
    t.string  "LevelUID",        limit: nil
  end

  add_index "dvtable_{8b9f02c7-dcd9-467d-a2a4-f2e5ef4a061c}", ["Level", "LevelUID"], name: "dvsys_mandatoryaccesscard_accesslevels_uc_global_level", unique: true

  create_table "dvtable_{8c77892a-21cc-4972-ad71-a9919bca8187}", id: false, force: true do |t|
    t.string   "RowID",               limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",          limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",         limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",                limit: 512
    t.string   "Type",                limit: nil
    t.string   "NumberRef",           limit: nil
    t.string   "FullNumber",          limit: 160
    t.boolean  "FixNumber"
    t.string   "Sender",              limit: nil
    t.string   "Contact",             limit: nil
    t.string   "Recipient",           limit: nil
    t.datetime "CreationDate"
    t.datetime "RegistrationDate"
    t.string   "RegisteredBy",        limit: nil
    t.string   "OutgoingNumber",      limit: 80
    t.datetime "OutgoingDate"
    t.string   "DeliveryType",        limit: nil
    t.text     "Digest"
    t.integer  "PageCount"
    t.integer  "AttachmentPageCount"
    t.string   "FiledInFolder",       limit: nil
    t.string   "FiledInCase",         limit: nil
    t.string   "FilesID",             limit: nil
    t.string   "SenderOrg",           limit: 1024
    t.string   "SenderDep",           limit: 1024
    t.string   "SenderPhone",         limit: 64
    t.string   "SenderEmail",         limit: 64
    t.string   "SenderName",          limit: 128
    t.string   "ContactName",         limit: 128
    t.string   "DocState",            limit: nil
    t.string   "Responsible",         limit: nil
    t.string   "RecipientDep",        limit: nil
    t.string   "ParentCardID",        limit: nil
    t.boolean  "PropsAsForm"
    t.boolean  "Confidential"
    t.string   "DocProperty",         limit: 128
    t.string   "BarcodeNumber",       limit: 32
    t.string   "ControlledBy",        limit: nil
    t.datetime "ControlDate"
  end

  add_index "dvtable_{8c77892a-21cc-4972-ad71-a9919bca8187}", ["InstanceID"], name: "dvsys_cardinc_maininfo_uc_struct", unique: true

  create_table "dvtable_{8c77892a-21cc-4972-ad71-a9919bca8187}_archive", id: false, force: true do |t|
    t.string   "RowID",               limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",          limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",         limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",                limit: 512
    t.string   "Type",                limit: nil
    t.string   "NumberRef",           limit: nil
    t.string   "FullNumber",          limit: 160
    t.boolean  "FixNumber"
    t.string   "Sender",              limit: nil
    t.string   "Contact",             limit: nil
    t.string   "Recipient",           limit: nil
    t.datetime "CreationDate"
    t.datetime "RegistrationDate"
    t.string   "RegisteredBy",        limit: nil
    t.string   "OutgoingNumber",      limit: 80
    t.datetime "OutgoingDate"
    t.string   "DeliveryType",        limit: nil
    t.text     "Digest"
    t.integer  "PageCount"
    t.integer  "AttachmentPageCount"
    t.string   "FiledInFolder",       limit: nil
    t.string   "FiledInCase",         limit: nil
    t.string   "FilesID",             limit: nil
    t.string   "SenderOrg",           limit: 1024
    t.string   "SenderDep",           limit: 1024
    t.string   "SenderPhone",         limit: 64
    t.string   "SenderEmail",         limit: 64
    t.string   "SenderName",          limit: 128
    t.string   "ContactName",         limit: 128
    t.string   "DocState",            limit: nil
    t.string   "Responsible",         limit: nil
    t.string   "RecipientDep",        limit: nil
    t.string   "ParentCardID",        limit: nil
    t.boolean  "PropsAsForm"
    t.boolean  "Confidential"
    t.string   "DocProperty",         limit: 128
    t.string   "BarcodeNumber",       limit: 32
    t.string   "ControlledBy",        limit: nil
    t.datetime "ControlDate"
  end

  add_index "dvtable_{8c77892a-21cc-4972-ad71-a9919bca8187}_archive", ["InstanceID"], name: "dvsys_cardinc_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{8d68ee46-400e-4119-9d41-f2dbca83ece0}", id: false, force: true do |t|
    t.string "RowID",             limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",              limit: nil
    t.string "ProtocolTypeName",  limit: 256
    t.string "ProtocolNumerator", limit: nil
  end

  add_index "dvtable_{8d68ee46-400e-4119-9d41-f2dbca83ece0}", ["ParentRowID"], name: "dvsys_refdocsetup_protocolboards_section"

  create_table "dvtable_{8e9a0e3b-1671-44a7-9c4e-bad6e43c4245}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{8e9a0e3b-1671-44a7-9c4e-bad6e43c4245}", ["InstanceID", "ParentRowID"], name: "dvsys_cardout_enumvalues_section"
  add_index "dvtable_{8e9a0e3b-1671-44a7-9c4e-bad6e43c4245}", ["ParentRowID"], name: "dvsys_cardout_enumvalues_idx_parentrowid"

  create_table "dvtable_{8e9a0e3b-1671-44a7-9c4e-bad6e43c4245}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{8e9a0e3b-1671-44a7-9c4e-bad6e43c4245}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardout_enumvalues_archive_section"
  add_index "dvtable_{8e9a0e3b-1671-44a7-9c4e-bad6e43c4245}_archive", ["ParentRowID"], name: "dvsys_cardout_enumvalues_archive_idx_parentrowid"

  create_table "dvtable_{8f135be7-9544-4e7e-937f-2551378d0ebb}", id: false, force: true do |t|
    t.string   "RowID",            limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Recipient",        limit: nil
    t.string   "Organization",     limit: nil
    t.text     "Address"
    t.string   "SendingType",      limit: nil
    t.integer  "DocumentType"
    t.string   "DocumentNumber"
    t.datetime "SentDate"
    t.float    "Amount",           limit: 24
    t.string   "ExpenseType"
    t.string   "SendingNumber"
    t.integer  "SendingState",                 default: 1
    t.string   "ParentRegister",   limit: nil
    t.string   "RecipientDual",    limit: nil
    t.string   "OrganizationDual", limit: nil
    t.text     "SendingTypeText"
    t.string   "OrganizationText", limit: 256
    t.string   "RecipientText",    limit: 256
  end

  add_index "dvtable_{8f135be7-9544-4e7e-937f-2551378d0ebb}", ["InstanceID"], name: "dvsys_outdoc_recipients_section"

  create_table "dvtable_{8f135be7-9544-4e7e-937f-2551378d0ebb}_archive", id: false, force: true do |t|
    t.string   "RowID",            limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Recipient",        limit: nil
    t.string   "Organization",     limit: nil
    t.text     "Address"
    t.string   "SendingType",      limit: nil
    t.integer  "DocumentType"
    t.string   "DocumentNumber"
    t.datetime "SentDate"
    t.float    "Amount",           limit: 24
    t.string   "ExpenseType"
    t.string   "SendingNumber"
    t.integer  "SendingState"
    t.string   "ParentRegister",   limit: nil
    t.string   "RecipientDual",    limit: nil
    t.string   "OrganizationDual", limit: nil
    t.text     "SendingTypeText"
    t.string   "OrganizationText", limit: 256
    t.string   "RecipientText",    limit: 256
  end

  add_index "dvtable_{8f135be7-9544-4e7e-937f-2551378d0ebb}_archive", ["InstanceID"], name: "dvsys_outdoc_recipients_archive_section"

  create_table "dvtable_{916cdab9-1fda-4d0a-935f-6492c75477a8}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ZoneName",        limit: 32
  end

  add_index "dvtable_{916cdab9-1fda-4d0a-935f-6492c75477a8}", ["InstanceID"], name: "dvsys_numeratorcard_zones_section"

  create_table "dvtable_{91a9af10-4f1e-4d8b-82b0-7d30389931ac}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentCard",      limit: nil
  end

  add_index "dvtable_{91a9af10-4f1e-4d8b-82b0-7d30389931ac}", ["InstanceID"], name: "dvsys_executionprocess_maininfo_uc_struct", unique: true

  create_table "dvtable_{91a9af10-4f1e-4d8b-82b0-7d30389931ac}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentCard",      limit: nil
  end

  add_index "dvtable_{91a9af10-4f1e-4d8b-82b0-7d30389931ac}_archive", ["InstanceID"], name: "dvsys_executionprocess_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{94d8e845-4847-4b35-b9ae-c9544d6de6d3}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{94d8e845-4847-4b35-b9ae-c9544d6de6d3}", ["CategoryID", "InstanceID", "CategoryIDUID"], name: "dvsys_cardreport_categories_uc_card_categoryid", unique: true
  add_index "dvtable_{94d8e845-4847-4b35-b9ae-c9544d6de6d3}", ["InstanceID"], name: "dvsys_cardreport_categories_section"

  create_table "dvtable_{94d8e845-4847-4b35-b9ae-c9544d6de6d3}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{94d8e845-4847-4b35-b9ae-c9544d6de6d3}_archive", ["InstanceID"], name: "dvsys_cardreport_categories_archive_section"

  create_table "dvtable_{94f05368-7776-476f-bc33-1e86b5c56189}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "LetterNumber",    limit: 256
    t.datetime "LetterDate"
    t.string   "LetterAuthor",    limit: nil
  end

  add_index "dvtable_{94f05368-7776-476f-bc33-1e86b5c56189}", ["InstanceID", "ParentRowID"], name: "dvsys_incdoc_embeddedletter_section"
  add_index "dvtable_{94f05368-7776-476f-bc33-1e86b5c56189}", ["ParentRowID"], name: "dvsys_incdoc_embeddedletter_idx_parentrowid"

  create_table "dvtable_{94f05368-7776-476f-bc33-1e86b5c56189}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "LetterNumber",    limit: 256
    t.datetime "LetterDate"
    t.string   "LetterAuthor",    limit: nil
  end

  add_index "dvtable_{94f05368-7776-476f-bc33-1e86b5c56189}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_incdoc_embeddedletter_archive_section"
  add_index "dvtable_{94f05368-7776-476f-bc33-1e86b5c56189}_archive", ["ParentRowID"], name: "dvsys_incdoc_embeddedletter_archive_idx_parentrowid"

  create_table "dvtable_{951620c9-1339-4ed2-848a-efc6cd3b9d21}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "TypeID",          limit: nil
    t.string "TypeIDUID",       limit: nil
  end

  add_index "dvtable_{951620c9-1339-4ed2-848a-efc6cd3b9d21}", ["InstanceID"], name: "dvsys_cardresolution_types_section"
  add_index "dvtable_{951620c9-1339-4ed2-848a-efc6cd3b9d21}", ["TypeID", "InstanceID", "TypeIDUID"], name: "dvsys_cardresolution_types_uc_card_typeid", unique: true

  create_table "dvtable_{951620c9-1339-4ed2-848a-efc6cd3b9d21}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "TypeID",          limit: nil
    t.string "TypeIDUID",       limit: nil
  end

  add_index "dvtable_{951620c9-1339-4ed2-848a-efc6cd3b9d21}_archive", ["InstanceID"], name: "dvsys_cardresolution_types_archive_section"

  create_table "dvtable_{95ac5fdc-feaf-48b1-91aa-7f24999f5f83}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ToSendSignedBy",  limit: nil
  end

  add_index "dvtable_{95ac5fdc-feaf-48b1-91aa-7f24999f5f83}", ["InstanceID", "ParentRowID"], name: "dvsys_registercard_tosendsignedby_section"
  add_index "dvtable_{95ac5fdc-feaf-48b1-91aa-7f24999f5f83}", ["ParentRowID"], name: "dvsys_registercard_tosendsignedby_idx_parentrowid"

  create_table "dvtable_{95ac5fdc-feaf-48b1-91aa-7f24999f5f83}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ToSendSignedBy",  limit: nil
  end

  add_index "dvtable_{95ac5fdc-feaf-48b1-91aa-7f24999f5f83}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_registercard_tosendsignedby_archive_section"
  add_index "dvtable_{95ac5fdc-feaf-48b1-91aa-7f24999f5f83}_archive", ["ParentRowID"], name: "dvsys_registercard_tosendsignedby_archive_idx_parentrowid"

  create_table "dvtable_{964087e9-3f72-449d-853d-fdb9bbf43e4c}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "FieldName",       limit: 128
    t.boolean "FirstLetterOnly"
  end

  create_table "dvtable_{96909c05-27c2-4e37-9770-a4d0d2c10cb8}", id: false, force: true do |t|
    t.string   "RowID",            limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "Action"
    t.datetime "ActionDate"
    t.string   "ActionBy",         limit: nil
    t.integer  "PercentCompleted"
    t.integer  "TaskState"
    t.string   "Description",      limit: 512
    t.datetime "NewEndDate"
  end

  add_index "dvtable_{96909c05-27c2-4e37-9770-a4d0d2c10cb8}", ["InstanceID"], name: "dvsys_workflowtask_log_section"

  create_table "dvtable_{96909c05-27c2-4e37-9770-a4d0d2c10cb8}_archive", id: false, force: true do |t|
    t.string   "RowID",            limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "Action"
    t.datetime "ActionDate"
    t.string   "ActionBy",         limit: nil
    t.integer  "PercentCompleted"
    t.integer  "TaskState"
    t.string   "Description",      limit: 512
    t.datetime "NewEndDate"
  end

  add_index "dvtable_{96909c05-27c2-4e37-9770-a4d0d2c10cb8}_archive", ["InstanceID"], name: "dvsys_workflowtask_log_archive_section"

  create_table "dvtable_{9694e2a6-bc96-49d6-bed8-0043311f0d7d}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "TaskState"
    t.string  "ActionAlias",     limit: 64
    t.string  "StateAlias",      limit: 64
  end

  add_index "dvtable_{9694e2a6-bc96-49d6-bed8-0043311f0d7d}", ["InstanceID"], name: "dvsys_workflowtask_aliases_section"

  create_table "dvtable_{9694e2a6-bc96-49d6-bed8-0043311f0d7d}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "TaskState"
    t.string  "ActionAlias",     limit: 64
    t.string  "StateAlias",      limit: 64
  end

  add_index "dvtable_{9694e2a6-bc96-49d6-bed8-0043311f0d7d}_archive", ["InstanceID"], name: "dvsys_workflowtask_aliases_archive_section"

  create_table "dvtable_{97cc73ba-1953-4a70-8460-415bd4bcaaae}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ID",              limit: nil
    t.integer  "Pass"
    t.integer  "State"
    t.datetime "ExecuteTime"
    t.text     "Data"
    t.boolean  "UseSparedData",               default: false
    t.boolean  "HasErrors",                   default: false
    t.boolean  "HasWarnings",                 default: false
    t.integer  "TimeoutCount"
  end

  add_index "dvtable_{97cc73ba-1953-4a70-8460-415bd4bcaaae}", ["ExecuteTime"], name: "dvsys_process_states_idx_executetime"
  add_index "dvtable_{97cc73ba-1953-4a70-8460-415bd4bcaaae}", ["InstanceID", "ParentRowID"], name: "dvsys_process_states_section"
  add_index "dvtable_{97cc73ba-1953-4a70-8460-415bd4bcaaae}", ["ParentRowID"], name: "dvsys_process_states_idx_parentrowid"
  add_index "dvtable_{97cc73ba-1953-4a70-8460-415bd4bcaaae}", ["State"], name: "dvsys_process_states_idx_state"

  create_table "dvtable_{97cc73ba-1953-4a70-8460-415bd4bcaaae}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ID",              limit: nil
    t.integer  "Pass"
    t.integer  "State"
    t.datetime "ExecuteTime"
    t.text     "Data"
    t.boolean  "UseSparedData"
    t.boolean  "HasErrors"
    t.boolean  "HasWarnings"
    t.integer  "TimeoutCount"
  end

  add_index "dvtable_{97cc73ba-1953-4a70-8460-415bd4bcaaae}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_process_states_archive_section"
  add_index "dvtable_{97cc73ba-1953-4a70-8460-415bd4bcaaae}_archive", ["ParentRowID"], name: "dvsys_process_states_archive_idx_parentrowid"

  create_table "dvtable_{989e8297-990f-43f8-9685-54df1c3fbb79}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "TypeID",          limit: nil
    t.string "ID",              limit: nil
  end

  add_index "dvtable_{989e8297-990f-43f8-9685-54df1c3fbb79}", ["InstanceID", "ParentRowID"], name: "dvsys_process_doctypes_section"
  add_index "dvtable_{989e8297-990f-43f8-9685-54df1c3fbb79}", ["ParentRowID"], name: "dvsys_process_doctypes_idx_parentrowid"

  create_table "dvtable_{989e8297-990f-43f8-9685-54df1c3fbb79}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "TypeID",          limit: nil
    t.string "ID",              limit: nil
  end

  add_index "dvtable_{989e8297-990f-43f8-9685-54df1c3fbb79}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_process_doctypes_archive_section"
  add_index "dvtable_{989e8297-990f-43f8-9685-54df1c3fbb79}_archive", ["ParentRowID"], name: "dvsys_process_doctypes_archive_idx_parentrowid"

  create_table "dvtable_{98a5f79e-1967-4b5e-abdb-e1abbf88cc66}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean  "IsReceived"
    t.string   "FromEmployee",    limit: nil
    t.string   "ToEmployee",      limit: nil
    t.string   "ToDepartment",    limit: nil
    t.datetime "TransferDate"
    t.boolean  "IsCopy"
    t.string   "Comments",        limit: 2048
  end

  add_index "dvtable_{98a5f79e-1967-4b5e-abdb-e1abbf88cc66}", ["InstanceID"], name: "dvsys_cardout_transferlog_section"

  create_table "dvtable_{98a5f79e-1967-4b5e-abdb-e1abbf88cc66}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean  "IsReceived"
    t.string   "FromEmployee",    limit: nil
    t.string   "ToEmployee",      limit: nil
    t.string   "ToDepartment",    limit: nil
    t.datetime "TransferDate"
    t.boolean  "IsCopy"
    t.string   "Comments",        limit: 2048
  end

  add_index "dvtable_{98a5f79e-1967-4b5e-abdb-e1abbf88cc66}_archive", ["InstanceID"], name: "dvsys_cardout_transferlog_archive_section"

  create_table "dvtable_{98f1fa54-5148-4e51-a27b-01841659fea5}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Assignee",        limit: nil
    t.string "AssignmentID",    limit: nil
  end

  add_index "dvtable_{98f1fa54-5148-4e51-a27b-01841659fea5}", ["InstanceID", "ParentRowID"], name: "dvsys_ordercard_assignees_section"
  add_index "dvtable_{98f1fa54-5148-4e51-a27b-01841659fea5}", ["ParentRowID"], name: "dvsys_ordercard_assignees_idx_parentrowid"

  create_table "dvtable_{98f1fa54-5148-4e51-a27b-01841659fea5}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Assignee",        limit: nil
    t.string "AssignmentID",    limit: nil
  end

  add_index "dvtable_{98f1fa54-5148-4e51-a27b-01841659fea5}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_ordercard_assignees_archive_section"
  add_index "dvtable_{98f1fa54-5148-4e51-a27b-01841659fea5}_archive", ["ParentRowID"], name: "dvsys_ordercard_assignees_archive_idx_parentrowid"

# Could not dump table "dvtable_{9957888c-8ac0-4760-b8d4-736204ef7511}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{997d01fd-f90d-4243-96b0-c6b29161c515}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ResolutionID",    limit: nil
  end

  add_index "dvtable_{997d01fd-f90d-4243-96b0-c6b29161c515}", ["InstanceID"], name: "dvsys_carduni_resolutions_section"

  create_table "dvtable_{997d01fd-f90d-4243-96b0-c6b29161c515}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ResolutionID",    limit: nil
  end

  add_index "dvtable_{997d01fd-f90d-4243-96b0-c6b29161c515}_archive", ["InstanceID"], name: "dvsys_carduni_resolutions_archive_section"

  create_table "dvtable_{99b6ba2e-2c62-407d-9d86-e3907a235bf8}", id: false, force: true do |t|
    t.string "RowID",                  limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                   limit: nil
    t.string "IncContractRegistrator", limit: nil
  end

  add_index "dvtable_{99b6ba2e-2c62-407d-9d86-e3907a235bf8}", ["ParentRowID"], name: "dvsys_refdocsetup_inccontractregistrators_section"

  create_table "dvtable_{99b9ef60-073f-435d-bd8b-9e6f62bb8609}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Field1"
  end

  add_index "dvtable_{99b9ef60-073f-435d-bd8b-9e6f62bb8609}", ["InstanceID"], name: "dvsys_replicatoradministrationcard_section1_uc_struct", unique: true

  create_table "dvtable_{99cd2dfc-9b28-48c6-ab65-19c0f3d9ccf3}", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Registrator",          limit: nil
    t.datetime "RegistrationDate"
    t.string   "RegistrationNumber",   limit: 256
    t.string   "RegistrationNumberID", limit: nil
    t.string   "Performer",            limit: nil
    t.text     "Content"
    t.string   "Author",               limit: nil
    t.string   "Controller",           limit: nil
    t.datetime "Deadline"
    t.string   "FileListID",           limit: nil
    t.string   "RefListID",            limit: nil
    t.text     "CurrentReport"
    t.integer  "State"
    t.datetime "ReportUpdateDate"
    t.text     "Reason"
    t.string   "AssigneeDocItem",      limit: 10
    t.string   "ParentDocument",       limit: nil
    t.integer  "Percentage"
  end

  add_index "dvtable_{99cd2dfc-9b28-48c6-ab65-19c0f3d9ccf3}", ["InstanceID"], name: "dvsys_durableassignmentcard_maininfo_uc_struct", unique: true

  create_table "dvtable_{99cd2dfc-9b28-48c6-ab65-19c0f3d9ccf3}_archive", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Registrator",          limit: nil
    t.datetime "RegistrationDate"
    t.string   "RegistrationNumber",   limit: 256
    t.string   "RegistrationNumberID", limit: nil
    t.string   "Performer",            limit: nil
    t.text     "Content"
    t.string   "Author",               limit: nil
    t.string   "Controller",           limit: nil
    t.datetime "Deadline"
    t.string   "FileListID",           limit: nil
    t.string   "RefListID",            limit: nil
    t.text     "CurrentReport"
    t.integer  "State"
    t.datetime "ReportUpdateDate"
    t.text     "Reason"
    t.string   "AssigneeDocItem",      limit: 10
    t.string   "ParentDocument",       limit: nil
    t.integer  "Percentage"
  end

  add_index "dvtable_{99cd2dfc-9b28-48c6-ab65-19c0f3d9ccf3}_archive", ["InstanceID"], name: "dvsys_durableassignmentcard_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{99d4b0ec-585f-4c71-8128-d6834c6e44c0}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Assignee",        limit: nil
    t.string "AssignmentID",    limit: nil
  end

  add_index "dvtable_{99d4b0ec-585f-4c71-8128-d6834c6e44c0}", ["InstanceID", "ParentRowID"], name: "dvsys_directioncard_assignees_section"
  add_index "dvtable_{99d4b0ec-585f-4c71-8128-d6834c6e44c0}", ["ParentRowID"], name: "dvsys_directioncard_assignees_idx_parentrowid"

  create_table "dvtable_{99d4b0ec-585f-4c71-8128-d6834c6e44c0}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Assignee",        limit: nil
    t.string "AssignmentID",    limit: nil
  end

  add_index "dvtable_{99d4b0ec-585f-4c71-8128-d6834c6e44c0}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_directioncard_assignees_archive_section"
  add_index "dvtable_{99d4b0ec-585f-4c71-8128-d6834c6e44c0}_archive", ["ParentRowID"], name: "dvsys_directioncard_assignees_archive_idx_parentrowid"

  create_table "dvtable_{9a5ba036-e638-4760-812a-c7d819807a47}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "Name",            limit: 128
    t.string  "Tooltip",         limit: 49
    t.binary  "Icon"
    t.text    "Script"
    t.boolean "SaveBeforeStart"
    t.boolean "CheckRequired"
    t.integer "ScriptSet"
  end

  add_index "dvtable_{9a5ba036-e638-4760-812a-c7d819807a47}", ["ParentRowID"], name: "dvsys_reftypes_buttonscripts_section"

  create_table "dvtable_{9b99d82a-8b4a-429e-a76d-469fdd1f6a86}", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID", limit: nil
    t.string   "FileListId",           limit: nil
    t.string   "LinkListId",           limit: nil
    t.string   "BarcodeNumber",        limit: 40
    t.string   "BarcodeNumberID",      limit: nil
    t.string   "Registrator",          limit: nil
    t.string   "Subject",              limit: 256
    t.datetime "RegistrationDate"
    t.text     "Comment"
    t.string   "Developer",            limit: nil
    t.string   "DocumentKind",         limit: nil
    t.integer  "State"
    t.string   "TransferLog",          limit: nil
    t.string   "ApprovalListID",       limit: nil
    t.datetime "StartDate"
    t.string   "DocumentKindText",     limit: 256
  end

  add_index "dvtable_{9b99d82a-8b4a-429e-a76d-469fdd1f6a86}", ["InstanceID"], name: "dvsys_nrdcard_maininfo_uc_struct", unique: true

  create_table "dvtable_{9b99d82a-8b4a-429e-a76d-469fdd1f6a86}_archive", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID", limit: nil
    t.string   "FileListId",           limit: nil
    t.string   "LinkListId",           limit: nil
    t.string   "BarcodeNumber",        limit: 40
    t.string   "BarcodeNumberID",      limit: nil
    t.string   "Registrator",          limit: nil
    t.string   "Subject",              limit: 256
    t.datetime "RegistrationDate"
    t.text     "Comment"
    t.string   "Developer",            limit: nil
    t.string   "DocumentKind",         limit: nil
    t.integer  "State"
    t.string   "TransferLog",          limit: nil
    t.string   "ApprovalListID",       limit: nil
    t.datetime "StartDate"
    t.string   "DocumentKindText",     limit: 256
  end

  add_index "dvtable_{9b99d82a-8b4a-429e-a76d-469fdd1f6a86}_archive", ["InstanceID"], name: "dvsys_nrdcard_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{9c69595a-d02d-451b-bc9e-1fccc508cec8}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "RefType"
    t.string  "RefID",           limit: nil
    t.string  "RefURL",          limit: 4000
    t.boolean "ReadOnly"
    t.string  "Comment",         limit: 2048
    t.string  "RefCardID",       limit: nil
    t.string  "RefFolderID",     limit: nil
  end

  add_index "dvtable_{9c69595a-d02d-451b-bc9e-1fccc508cec8}", ["InstanceID"], name: "dvsys_cardreport_reportreferences_section"

  create_table "dvtable_{9c69595a-d02d-451b-bc9e-1fccc508cec8}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "RefType"
    t.string  "RefID",           limit: nil
    t.string  "RefURL",          limit: 4000
    t.boolean "ReadOnly"
    t.string  "Comment",         limit: 2048
    t.string  "RefCardID",       limit: nil
    t.string  "RefFolderID",     limit: nil
  end

  add_index "dvtable_{9c69595a-d02d-451b-bc9e-1fccc508cec8}_archive", ["InstanceID"], name: "dvsys_cardreport_reportreferences_archive_section"

  create_table "dvtable_{9c73dad2-22fa-46b5-909c-924ff8acc095}", id: false, force: true do |t|
    t.string   "RowID",                    limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",               limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",              limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",          limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "Cycle"
    t.string   "Consolidator",             limit: nil
    t.string   "ConsolidatorTaskID",       limit: nil
    t.boolean  "UseStaffDeputies"
    t.datetime "StartDate"
    t.datetime "FinishDate"
    t.integer  "Duration"
    t.boolean  "NotifyAuthor"
    t.boolean  "SendImmediately"
    t.boolean  "SequentialProcessing"
    t.datetime "ActualFinishDate"
    t.boolean  "ConsolidateAfter"
    t.string   "AuthorTaskID",             limit: nil
    t.string   "ConsolidatorComment",      limit: 2048
    t.string   "AuthorComment",            limit: 2048
    t.string   "ProcessID",                limit: nil
    t.string   "ConsolidatorSeqComment",   limit: 2048
    t.boolean  "ConsolidateSeq"
    t.boolean  "MixedType"
    t.string   "ConsolidatorPositionID",   limit: nil
    t.string   "ConsolidatorDepartmentID", limit: nil
    t.boolean  "EmailNotification"
    t.string   "StartDateParam",           limit: 64
    t.string   "FinishDateParam",          limit: 64
    t.boolean  "AppFullRights"
  end

  add_index "dvtable_{9c73dad2-22fa-46b5-909c-924ff8acc095}", ["InstanceID"], name: "dvsys_cardapproval_cycles_section"

  create_table "dvtable_{9c73dad2-22fa-46b5-909c-924ff8acc095}_archive", id: false, force: true do |t|
    t.string   "RowID",                    limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",               limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",              limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",          limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "Cycle"
    t.string   "Consolidator",             limit: nil
    t.string   "ConsolidatorTaskID",       limit: nil
    t.boolean  "UseStaffDeputies"
    t.datetime "StartDate"
    t.datetime "FinishDate"
    t.integer  "Duration"
    t.boolean  "NotifyAuthor"
    t.boolean  "SendImmediately"
    t.boolean  "SequentialProcessing"
    t.datetime "ActualFinishDate"
    t.boolean  "ConsolidateAfter"
    t.string   "AuthorTaskID",             limit: nil
    t.string   "ConsolidatorComment",      limit: 2048
    t.string   "AuthorComment",            limit: 2048
    t.string   "ProcessID",                limit: nil
    t.string   "ConsolidatorSeqComment",   limit: 2048
    t.boolean  "ConsolidateSeq"
    t.boolean  "MixedType"
    t.string   "ConsolidatorPositionID",   limit: nil
    t.string   "ConsolidatorDepartmentID", limit: nil
    t.boolean  "EmailNotification"
    t.string   "StartDateParam",           limit: 64
    t.string   "FinishDateParam",          limit: 64
    t.boolean  "AppFullRights"
  end

  add_index "dvtable_{9c73dad2-22fa-46b5-909c-924ff8acc095}_archive", ["InstanceID"], name: "dvsys_cardapproval_cycles_archive_section"

  create_table "dvtable_{9c8cb241-40d4-48fd-a7fa-b6e5df2b97f4}", id: false, force: true do |t|
    t.string   "RowID",                    limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",              limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "AssignmentsID",            limit: nil
    t.string   "AssignmentControler",      limit: nil
    t.datetime "AssignmentDeadline"
    t.boolean  "AssignmentToRead"
    t.text     "AssignmentComments"
    t.datetime "AssignmentCompletionDate"
  end

  add_index "dvtable_{9c8cb241-40d4-48fd-a7fa-b6e5df2b97f4}", ["InstanceID"], name: "dvsys_directioncard_assignments_section"

  create_table "dvtable_{9c8cb241-40d4-48fd-a7fa-b6e5df2b97f4}_archive", id: false, force: true do |t|
    t.string   "RowID",                    limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",              limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "AssignmentsID",            limit: nil
    t.string   "AssignmentControler",      limit: nil
    t.datetime "AssignmentDeadline"
    t.boolean  "AssignmentToRead"
    t.text     "AssignmentComments"
    t.datetime "AssignmentCompletionDate"
  end

  add_index "dvtable_{9c8cb241-40d4-48fd-a7fa-b6e5df2b97f4}_archive", ["InstanceID"], name: "dvsys_directioncard_assignments_archive_section"

  create_table "dvtable_{9ce1fce1-82ad-4693-993d-01429bc28328}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{9ce1fce1-82ad-4693-993d-01429bc28328}", ["InstanceID", "ParentRowID"], name: "dvsys_cardreport_enumvalues_section"
  add_index "dvtable_{9ce1fce1-82ad-4693-993d-01429bc28328}", ["ParentRowID"], name: "dvsys_cardreport_enumvalues_idx_parentrowid"

  create_table "dvtable_{9ce1fce1-82ad-4693-993d-01429bc28328}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{9ce1fce1-82ad-4693-993d-01429bc28328}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardreport_enumvalues_archive_section"
  add_index "dvtable_{9ce1fce1-82ad-4693-993d-01429bc28328}_archive", ["ParentRowID"], name: "dvsys_cardreport_enumvalues_archive_idx_parentrowid"

  create_table "dvtable_{9d09144d-caec-4732-ad4d-eb6a3864714a}", id: false, force: true do |t|
    t.string  "RowID",              limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",    limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "PerformerID",        limit: nil
    t.string  "DelegatedFrom",      limit: nil
    t.string  "DelegatedTo",        limit: nil
    t.integer "PerformerState"
    t.string  "OutlookTaskID",      limit: 256
    t.string  "ShortcutID",         limit: nil
    t.boolean "ResponseRequired"
    t.boolean "CanReject"
    t.boolean "IsActive"
    t.integer "CurrentRoutingType"
    t.string  "DeputyFor",          limit: nil
    t.string  "OldPerformerID",     limit: nil
  end

  add_index "dvtable_{9d09144d-caec-4732-ad4d-eb6a3864714a}", ["InstanceID"], name: "dvsys_workflowtask_currentperformers_section"

  create_table "dvtable_{9d09144d-caec-4732-ad4d-eb6a3864714a}_archive", id: false, force: true do |t|
    t.string  "RowID",              limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",    limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "PerformerID",        limit: nil
    t.string  "DelegatedFrom",      limit: nil
    t.string  "DelegatedTo",        limit: nil
    t.integer "PerformerState"
    t.string  "OutlookTaskID",      limit: 256
    t.string  "ShortcutID",         limit: nil
    t.boolean "ResponseRequired"
    t.boolean "CanReject"
    t.boolean "IsActive"
    t.integer "CurrentRoutingType"
    t.string  "DeputyFor",          limit: nil
    t.string  "OldPerformerID",     limit: nil
  end

  add_index "dvtable_{9d09144d-caec-4732-ad4d-eb6a3864714a}_archive", ["InstanceID"], name: "dvsys_workflowtask_currentperformers_archive_section"

  create_table "dvtable_{9df1ba33-7324-4ea4-8eb9-390ed7136388}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SelectedValue",   limit: 512
    t.integer "Order"
  end

  add_index "dvtable_{9df1ba33-7324-4ea4-8eb9-390ed7136388}", ["InstanceID", "ParentRowID"], name: "dvsys_workflowtask_completionselectedvalues_section"
  add_index "dvtable_{9df1ba33-7324-4ea4-8eb9-390ed7136388}", ["ParentRowID"], name: "dvsys_workflowtask_completionselectedvalues_idx_parentrowid"

  create_table "dvtable_{9df1ba33-7324-4ea4-8eb9-390ed7136388}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SelectedValue",   limit: 512
    t.integer "Order"
  end

  add_index "dvtable_{9df1ba33-7324-4ea4-8eb9-390ed7136388}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_workflowtask_completionselectedvalues_archive_section"
  add_index "dvtable_{9df1ba33-7324-4ea4-8eb9-390ed7136388}_archive", ["ParentRowID"], name: "dvsys_workflowtask_completionselectedvalues_archive_idx_parentrowid"

  create_table "dvtable_{9e18811a-f993-40b8-80b8-0a206f048503}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SubTypeID",       limit: nil
    t.string "AccessID",        limit: nil
  end

  add_index "dvtable_{9e18811a-f993-40b8-80b8-0a206f048503}", ["ParentRowID"], name: "dvsys_folderscard_allowedsubtypes_section"

  create_table "dvtable_{9e22da46-f4d2-4f24-a6ba-032508651cef}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "HistoryKind"
    t.string   "PersonHistory",   limit: nil
    t.text     "CommentsHistory"
    t.datetime "DateHistory"
    t.string   "TaskHistory",     limit: nil
  end

  add_index "dvtable_{9e22da46-f4d2-4f24-a6ba-032508651cef}", ["InstanceID"], name: "dvsys_protocolcard_approvalhistory_section"

  create_table "dvtable_{9e22da46-f4d2-4f24-a6ba-032508651cef}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "HistoryKind"
    t.string   "PersonHistory",   limit: nil
    t.text     "CommentsHistory"
    t.datetime "DateHistory"
    t.string   "TaskHistory",     limit: nil
  end

  add_index "dvtable_{9e22da46-f4d2-4f24-a6ba-032508651cef}_archive", ["InstanceID"], name: "dvsys_protocolcard_approvalhistory_archive_section"

  create_table "dvtable_{9f3d8474-49a3-43dc-9d2b-59e82cc8f267}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "Comment",         limit: 2048
    t.boolean  "IsReport"
    t.boolean  "IsNew"
  end

  add_index "dvtable_{9f3d8474-49a3-43dc-9d2b-59e82cc8f267}", ["InstanceID"], name: "dvsys_workflowtask_comments_section"

  create_table "dvtable_{9f3d8474-49a3-43dc-9d2b-59e82cc8f267}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "Comment",         limit: 2048
    t.boolean  "IsReport"
    t.boolean  "IsNew"
  end

  add_index "dvtable_{9f3d8474-49a3-43dc-9d2b-59e82cc8f267}_archive", ["InstanceID"], name: "dvsys_workflowtask_comments_archive_section"

  create_table "dvtable_{9fd4934c-2353-4518-8513-a6f8b501973e}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "Type"
    t.string  "Name",            limit: 128
    t.string  "Comments",        limit: 1024
  end

  add_index "dvtable_{9fd4934c-2353-4518-8513-a6f8b501973e}", ["ParentRowID"], name: "dvsys_refpartners_contacts_section"

  create_table "dvtable_{a0c9db84-e438-46ed-9065-ac78490c761a}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "TaskID",          limit: nil
  end

  add_index "dvtable_{a0c9db84-e438-46ed-9065-ac78490c761a}", ["InstanceID", "ParentRowID"], name: "dvsys_cardresolution_grouptasks_section"
  add_index "dvtable_{a0c9db84-e438-46ed-9065-ac78490c761a}", ["ParentRowID"], name: "dvsys_cardresolution_grouptasks_idx_parentrowid"

  create_table "dvtable_{a0c9db84-e438-46ed-9065-ac78490c761a}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "TaskID",          limit: nil
  end

  add_index "dvtable_{a0c9db84-e438-46ed-9065-ac78490c761a}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardresolution_grouptasks_archive_section"
  add_index "dvtable_{a0c9db84-e438-46ed-9065-ac78490c761a}_archive", ["ParentRowID"], name: "dvsys_cardresolution_grouptasks_archive_idx_parentrowid"

  create_table "dvtable_{a15c21eb-61be-4dd9-a421-98f1dffb8323}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{a15c21eb-61be-4dd9-a421-98f1dffb8323}", ["CategoryID", "InstanceID", "CategoryIDUID"], name: "dvsys_carduni_categories_uc_card_categoryid", unique: true
  add_index "dvtable_{a15c21eb-61be-4dd9-a421-98f1dffb8323}", ["InstanceID"], name: "dvsys_carduni_categories_section"

  create_table "dvtable_{a15c21eb-61be-4dd9-a421-98f1dffb8323}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{a15c21eb-61be-4dd9-a421-98f1dffb8323}_archive", ["InstanceID"], name: "dvsys_carduni_categories_archive_section"

  create_table "dvtable_{a2784a30-421e-4cda-969f-4a2c5af58ec8}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "CenterZone"
    t.integer "CurrentZone"
    t.string  "ReplicasRef",     limit: nil
    t.string  "FolderForCards",  limit: nil
  end

  add_index "dvtable_{a2784a30-421e-4cda-969f-4a2c5af58ec8}", ["InstanceID"], name: "dvsys_refreplicatorsetup_maininfo_uc_struct", unique: true

  create_table "dvtable_{a29479d3-1cf0-49ec-b841-f45ffb8034d8}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "LNAEmployee",     limit: nil
  end

  add_index "dvtable_{a29479d3-1cf0-49ec-b841-f45ffb8034d8}", ["ParentRowID"], name: "dvsys_refdocsetup_lnaassurers_section"

  create_table "dvtable_{a2e59113-83bd-49c8-b495-05a3d2df9e42}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "Order"
    t.string  "FieldName",       limit: 128
    t.boolean "FirstLetterOnly"
  end

  create_table "dvtable_{a337b55c-54d4-485d-8e7f-e5e36170d240}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Name",            limit: 2048
    t.text    "Settings"
    t.boolean "IsDefault",                    default: false
    t.string  "Description",     limit: 2048
    t.string  "IconID",          limit: nil
  end

  add_index "dvtable_{a337b55c-54d4-485d-8e7f-e5e36170d240}", ["ParentRowID"], name: "dvsys_functionlist_predefinedfunctions_section"

  create_table "dvtable_{a390e37c-ebeb-4435-b823-82e96312e85c}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "NotifEmployee",   limit: nil
    t.datetime "FamiliarizeDate"
  end

  add_index "dvtable_{a390e37c-ebeb-4435-b823-82e96312e85c}", ["InstanceID"], name: "dvsys_directioncard_notificationlist_section"

  create_table "dvtable_{a390e37c-ebeb-4435-b823-82e96312e85c}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "NotifEmployee",   limit: nil
    t.datetime "FamiliarizeDate"
  end

  add_index "dvtable_{a390e37c-ebeb-4435-b823-82e96312e85c}_archive", ["InstanceID"], name: "dvsys_directioncard_notificationlist_archive_section"

  create_table "dvtable_{a3daf310-a7ae-457c-9964-e592bc63fad6}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "EmployeeID",      limit: nil
    t.integer "Type"
    t.boolean "IsResponsible"
    t.string  "DepartmentID",    limit: nil
    t.string  "PositionID",      limit: nil
  end

  add_index "dvtable_{a3daf310-a7ae-457c-9964-e592bc63fad6}", ["InstanceID"], name: "dvsys_cardord_employees_section"

  create_table "dvtable_{a3daf310-a7ae-457c-9964-e592bc63fad6}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "EmployeeID",      limit: nil
    t.integer "Type"
    t.boolean "IsResponsible"
    t.string  "DepartmentID",    limit: nil
    t.string  "PositionID",      limit: nil
  end

  add_index "dvtable_{a3daf310-a7ae-457c-9964-e592bc63fad6}_archive", ["InstanceID"], name: "dvsys_cardord_employees_archive_section"

  create_table "dvtable_{a454afc4-0d6f-448c-a2fe-805d8118865a}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "RefID",           limit: nil
    t.integer "RefType"
  end

  add_index "dvtable_{a454afc4-0d6f-448c-a2fe-805d8118865a}", ["ParentRowID"], name: "dvsys_reftypes_valuerights_section"

  create_table "dvtable_{a4fe6e8e-7dd7-45b4-ac4e-3c74f0b6369a}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "FirstNumber"
    t.integer "LastNumber"
    t.string  "OwnerID",         limit: nil
  end

  add_index "dvtable_{a4fe6e8e-7dd7-45b4-ac4e-3c74f0b6369a}", ["InstanceID", "ParentRowID"], name: "dvsys_numeratorcard_freeranges_section"
  add_index "dvtable_{a4fe6e8e-7dd7-45b4-ac4e-3c74f0b6369a}", ["ParentRowID", "FirstNumber", "OwnerID"], name: "dvsys_numeratorcard_freeranges_idx_parentrowidfirstnumberownerid"
  add_index "dvtable_{a4fe6e8e-7dd7-45b4-ac4e-3c74f0b6369a}", ["ParentRowID", "LastNumber", "OwnerID"], name: "dvsys_numeratorcard_freeranges_idx_parentrowidlastnumberownerid"
  add_index "dvtable_{a4fe6e8e-7dd7-45b4-ac4e-3c74f0b6369a}", ["ParentRowID"], name: "dvsys_numeratorcard_freeranges_idx_parentrowid"

  create_table "dvtable_{a5489822-1a9c-4cbe-8468-23de99c843c4}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Name",            limit: 64
    t.string  "ServerClass"
    t.string  "ServerAssembly"
    t.string  "UIClass",         limit: 100
    t.boolean "IsStart"
    t.boolean "IsStop"
    t.string  "ID",              limit: nil
    t.integer "PoolingInterval",             default: 0
    t.boolean "Obsolete"
  end

  create_table "dvtable_{a565a4b4-446d-400b-91f0-fd23ae2a4208}", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "Order"
    t.integer  "PerformerType"
    t.string   "Performer",            limit: nil
    t.integer  "RoutingType"
    t.string   "Comments",             limit: 2048
    t.integer  "Reminder"
    t.datetime "StartDate"
    t.datetime "ExpectedEndDate"
    t.integer  "Duration"
    t.boolean  "IsResponsible"
    t.boolean  "CanReject"
    t.boolean  "CanReschedule"
    t.boolean  "CanAddFiles"
    t.boolean  "IsReportNeeded"
    t.boolean  "CanOpenParent"
    t.boolean  "IsAddFileNeeded"
    t.boolean  "CanViewLog"
    t.boolean  "UseOwnSettings"
    t.boolean  "CanDelegate"
    t.boolean  "DelegateToAll"
    t.boolean  "DelegateToDeputies"
    t.string   "TaskID",               limit: nil
    t.string   "ControllerTaskID",     limit: nil
    t.boolean  "ReportCardRequired"
    t.string   "PerformerName",        limit: 256
    t.boolean  "ToRead"
    t.string   "StartDateParam",       limit: 64
    t.string   "ExpectedEndDateParam", limit: 64
    t.boolean  "CanDeleteFiles"
    t.boolean  "UseCalendar"
    t.datetime "ReminderDate"
    t.string   "ReminderDateParam",    limit: 64
    t.boolean  "UseReminderDate"
    t.string   "EmployeeID",           limit: nil
    t.string   "DepartmentID",         limit: nil
    t.string   "GroupID",              limit: nil
    t.string   "RoleID",               limit: nil
    t.boolean  "SeparateTasks"
    t.integer  "WorkDuration"
    t.boolean  "KeepDuration"
  end

  add_index "dvtable_{a565a4b4-446d-400b-91f0-fd23ae2a4208}", ["InstanceID"], name: "dvsys_cardresolution_performers_section"

  create_table "dvtable_{a565a4b4-446d-400b-91f0-fd23ae2a4208}_archive", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "Order"
    t.integer  "PerformerType"
    t.string   "Performer",            limit: nil
    t.integer  "RoutingType"
    t.string   "Comments",             limit: 2048
    t.integer  "Reminder"
    t.datetime "StartDate"
    t.datetime "ExpectedEndDate"
    t.integer  "Duration"
    t.boolean  "IsResponsible"
    t.boolean  "CanReject"
    t.boolean  "CanReschedule"
    t.boolean  "CanAddFiles"
    t.boolean  "IsReportNeeded"
    t.boolean  "CanOpenParent"
    t.boolean  "IsAddFileNeeded"
    t.boolean  "CanViewLog"
    t.boolean  "UseOwnSettings"
    t.boolean  "CanDelegate"
    t.boolean  "DelegateToAll"
    t.boolean  "DelegateToDeputies"
    t.string   "TaskID",               limit: nil
    t.string   "ControllerTaskID",     limit: nil
    t.boolean  "ReportCardRequired"
    t.string   "PerformerName",        limit: 256
    t.boolean  "ToRead"
    t.string   "StartDateParam",       limit: 64
    t.string   "ExpectedEndDateParam", limit: 64
    t.boolean  "CanDeleteFiles"
    t.boolean  "UseCalendar"
    t.datetime "ReminderDate"
    t.string   "ReminderDateParam",    limit: 64
    t.boolean  "UseReminderDate"
    t.string   "EmployeeID",           limit: nil
    t.string   "DepartmentID",         limit: nil
    t.string   "GroupID",              limit: nil
    t.string   "RoleID",               limit: nil
    t.boolean  "SeparateTasks"
    t.integer  "WorkDuration"
    t.boolean  "KeepDuration"
  end

  add_index "dvtable_{a565a4b4-446d-400b-91f0-fd23ae2a4208}_archive", ["InstanceID"], name: "dvsys_cardresolution_performers_archive_section"

  create_table "dvtable_{a6b842c8-4876-4b5a-bfd7-7a9bb2cea657}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.string  "Name",            limit: 128
    t.text    "Text"
    t.string  "Comments",        limit: 3700
    t.boolean "Hidden"
    t.string  "ViewID",          limit: nil
    t.string  "NameUID",         limit: nil
  end

  add_index "dvtable_{a6b842c8-4876-4b5a-bfd7-7a9bb2cea657}", ["Name", "ParentRowID", "NameUID"], name: "dvsys_savedviewcard_views_uc_section_name", unique: true
  add_index "dvtable_{a6b842c8-4876-4b5a-bfd7-7a9bb2cea657}", ["ParentRowID"], name: "dvsys_savedviewcard_views_section"

  create_table "dvtable_{a6c8c03e-ef37-4e94-80ab-13a78d78e66f}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "ManagementDept",  limit: nil
  end

  add_index "dvtable_{a6c8c03e-ef37-4e94-80ab-13a78d78e66f}", ["ParentRowID"], name: "dvsys_refdocsetup_managementdepts_section"

  create_table "dvtable_{a725ea78-1c4d-4882-b73d-d023707a51a5}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Name",            limit: 256
    t.string  "Description",     limit: 256
    t.integer "Duration"
    t.boolean "IsCalendar"
  end

  create_table "dvtable_{a7cfbbca-16b9-4335-879c-0d3cdcc11d6e}", id: false, force: true do |t|
    t.string  "RowID",            limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName"
    t.boolean "CommentsRequired"
  end

  add_index "dvtable_{a7cfbbca-16b9-4335-879c-0d3cdcc11d6e}", ["InstanceID", "ParentRowID"], name: "dvsys_assignment_completionvariants_section"
  add_index "dvtable_{a7cfbbca-16b9-4335-879c-0d3cdcc11d6e}", ["ParentRowID"], name: "dvsys_assignment_completionvariants_idx_parentrowid"

  create_table "dvtable_{a7cfbbca-16b9-4335-879c-0d3cdcc11d6e}_archive", id: false, force: true do |t|
    t.string  "RowID",            limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName"
    t.boolean "CommentsRequired"
  end

  add_index "dvtable_{a7cfbbca-16b9-4335-879c-0d3cdcc11d6e}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_assignment_completionvariants_archive_section"
  add_index "dvtable_{a7cfbbca-16b9-4335-879c-0d3cdcc11d6e}_archive", ["ParentRowID"], name: "dvsys_assignment_completionvariants_archive_idx_parentrowid"

  create_table "dvtable_{a83875ca-2179-4859-9ea3-96105f4fcc39}", id: false, force: true do |t|
    t.string  "RowID",                         limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                    limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",                   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                          limit: nil
    t.string  "ContractKind",                  limit: nil
    t.integer "ContractFieldState"
    t.integer "ContractAmount"
    t.integer "ContractTaxable"
    t.integer "ContractAmountNDSFree"
    t.integer "ContractIncludeMaterialCost"
    t.integer "ContractSPinGPNDSFree"
    t.integer "ContractPercent"
    t.integer "ContractPaymentDelay"
    t.integer "ContractDateFinish"
    t.integer "ContractMaterialCost"
    t.integer "ContractPeriodicityType"
    t.integer "ContractProportionalCredit"
    t.integer "ContractPaymentType"
    t.integer "ContractCreditAmount"
    t.integer "ContractCreditTerm"
    t.integer "ContractMonthlyPaymentDate"
    t.integer "ContractMonthlyPaymentNDS"
    t.integer "ContractMonthlyPaymentNDSFree"
    t.integer "ContractStageDate"
    t.integer "ContractStageAmount"
  end

  add_index "dvtable_{a83875ca-2179-4859-9ea3-96105f4fcc39}", ["ParentRowID"], name: "dvsys_refdocsetup_contractfieldstate_section"

  create_table "dvtable_{a8490857-cf91-40a1-91b9-535ceb964f5b}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "LinkID",          limit: nil
  end

  add_index "dvtable_{a8490857-cf91-40a1-91b9-535ceb964f5b}", ["ParentRowID"], name: "dvsys_reftypes_allowedlinks_section"

  create_table "dvtable_{a960e37b-f1bd-4981-858d-ae9706e0571e}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "EmployeeID",      limit: nil
    t.string "SyncTag",         limit: 256
    t.string "EmployeeIDUID",   limit: nil
  end

  add_index "dvtable_{a960e37b-f1bd-4981-858d-ae9706e0571e}", ["EmployeeID", "ParentRowID", "EmployeeIDUID"], name: "dvsys_refstaff_group_uc_section_employeeid", unique: true
  add_index "dvtable_{a960e37b-f1bd-4981-858d-ae9706e0571e}", ["ParentRowID"], name: "dvsys_refstaff_group_section"

  create_table "dvtable_{aa743d9a-d013-46d6-ab6b-ea377ffef619}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ZoneName"
    t.string  "Unit",            limit: nil
    t.boolean "IsHome"
    t.string  "MainUnit",        limit: nil
  end

  create_table "dvtable_{abc12dc8-0adf-4efd-93a9-cb1e43d3387b}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ReportID",        limit: nil
    t.integer "ChildState"
    t.integer "ChildTaskState"
  end

  add_index "dvtable_{abc12dc8-0adf-4efd-93a9-cb1e43d3387b}", ["InstanceID"], name: "dvsys_workflowtask_reports_section"

  create_table "dvtable_{abc12dc8-0adf-4efd-93a9-cb1e43d3387b}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ReportID",        limit: nil
    t.integer "ChildState"
    t.integer "ChildTaskState"
  end

  add_index "dvtable_{abc12dc8-0adf-4efd-93a9-cb1e43d3387b}_archive", ["InstanceID"], name: "dvsys_workflowtask_reports_archive_section"

  create_table "dvtable_{ac10ca69-064b-41a0-b9f5-2ed874b0bd5c}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Name",            limit: 128
    t.text    "QueryText"
    t.string  "OpenMode",        limit: nil
    t.boolean "PlaySound"
    t.string  "WavPath",         limit: 256
    t.boolean "ChangeIcon"
    t.boolean "ShowMessage"
    t.boolean "ShowInfoWindow"
    t.boolean "NotAvailable"
    t.integer "Interval"
  end

  add_index "dvtable_{ac10ca69-064b-41a0-b9f5-2ed874b0bd5c}", ["ParentRowID"], name: "dvsys_agentsettings_searchsettings_section"

  create_table "dvtable_{acd7353c-aa4f-41a9-8ab7-111b3b111500}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ResolutionID",    limit: nil
  end

  add_index "dvtable_{acd7353c-aa4f-41a9-8ab7-111b3b111500}", ["InstanceID"], name: "dvsys_cardord_resolutions_section"

  create_table "dvtable_{acd7353c-aa4f-41a9-8ab7-111b3b111500}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ResolutionID",    limit: nil
  end

  add_index "dvtable_{acd7353c-aa4f-41a9-8ab7-111b3b111500}_archive", ["InstanceID"], name: "dvsys_cardord_resolutions_archive_section"

  create_table "dvtable_{ad8bb36f-cfb2-4911-801b-2b164d82a43a}", id: false, force: true do |t|
    t.string "RowID",             limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",              limit: nil
    t.string "OutDocInterrupter", limit: nil
  end

  add_index "dvtable_{ad8bb36f-cfb2-4911-801b-2b164d82a43a}", ["ParentRowID"], name: "dvsys_refdocsetup_outdocinterrupters_section"

  create_table "dvtable_{ad95e7fb-592c-4caa-bbdf-25f32f0b2987}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ResolutionID",    limit: nil
  end

  add_index "dvtable_{ad95e7fb-592c-4caa-bbdf-25f32f0b2987}", ["InstanceID"], name: "dvsys_incdoc_resolutions_section"

  create_table "dvtable_{ad95e7fb-592c-4caa-bbdf-25f32f0b2987}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ResolutionID",    limit: nil
  end

  add_index "dvtable_{ad95e7fb-592c-4caa-bbdf-25f32f0b2987}_archive", ["InstanceID"], name: "dvsys_incdoc_resolutions_archive_section"

  create_table "dvtable_{ae0855a0-70d6-4cc9-a6bd-74acf37086ff}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Category",        limit: nil
  end

  add_index "dvtable_{ae0855a0-70d6-4cc9-a6bd-74acf37086ff}", ["InstanceID", "ParentRowID"], name: "dvsys_lna_categories_section"
  add_index "dvtable_{ae0855a0-70d6-4cc9-a6bd-74acf37086ff}", ["ParentRowID"], name: "dvsys_lna_categories_idx_parentrowid"

  create_table "dvtable_{ae0855a0-70d6-4cc9-a6bd-74acf37086ff}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Category",        limit: nil
  end

  add_index "dvtable_{ae0855a0-70d6-4cc9-a6bd-74acf37086ff}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_lna_categories_archive_section"
  add_index "dvtable_{ae0855a0-70d6-4cc9-a6bd-74acf37086ff}_archive", ["ParentRowID"], name: "dvsys_lna_categories_archive_idx_parentrowid"

  create_table "dvtable_{ae691f32-af72-46a4-8646-86754cd8087c}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ViewCardID",      limit: nil
    t.string "SearchCardID",    limit: nil
  end

  add_index "dvtable_{ae691f32-af72-46a4-8646-86754cd8087c}", ["InstanceID"], name: "dvsys_folderscard_maininfo_uc_struct", unique: true

  create_table "dvtable_{ae982579-731c-4a84-a7cb-c9ec4e613b1c}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ID",              limit: nil
    t.string  "Value",           limit: 128
    t.integer "NumValue"
  end

  add_index "dvtable_{ae982579-731c-4a84-a7cb-c9ec4e613b1c}", ["InstanceID", "ParentRowID"], name: "dvsys_process_enumvalues_section"
  add_index "dvtable_{ae982579-731c-4a84-a7cb-c9ec4e613b1c}", ["ParentRowID"], name: "dvsys_process_enumvalues_idx_parentrowid"

  create_table "dvtable_{ae982579-731c-4a84-a7cb-c9ec4e613b1c}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ID",              limit: nil
    t.string  "Value",           limit: 128
    t.integer "NumValue"
  end

  add_index "dvtable_{ae982579-731c-4a84-a7cb-c9ec4e613b1c}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_process_enumvalues_archive_section"
  add_index "dvtable_{ae982579-731c-4a84-a7cb-c9ec4e613b1c}_archive", ["ParentRowID"], name: "dvsys_process_enumvalues_archive_idx_parentrowid"

  create_table "dvtable_{aebae081-fe0a-4b24-8f3e-440cec7dfb22}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "SDID",            limit: nil
    t.string   "EntityID",        limit: nil
    t.datetime "Date"
  end

  create_table "dvtable_{af07e3e9-1c40-479b-a998-7511e17f4b95}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Document",        limit: nil
  end

  add_index "dvtable_{af07e3e9-1c40-479b-a998-7511e17f4b95}", ["InstanceID"], name: "dvsys_nrdcard_confirmingdocuments_section"

  create_table "dvtable_{af07e3e9-1c40-479b-a998-7511e17f4b95}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Document",        limit: nil
  end

  add_index "dvtable_{af07e3e9-1c40-479b-a998-7511e17f4b95}_archive", ["InstanceID"], name: "dvsys_nrdcard_confirmingdocuments_archive_section"

  create_table "dvtable_{af39c1e3-3619-4954-a7dc-0d93a4517e2c}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "FieldName",       limit: 128
    t.boolean "FirstLetterOnly"
    t.string  "Prefix",          limit: 16
    t.string  "Suffix",          limit: 16
  end

  add_index "dvtable_{af39c1e3-3619-4954-a7dc-0d93a4517e2c}", ["ParentRowID"], name: "dvsys_refcases_caseformat_section"

  create_table "dvtable_{af6239bf-b868-4ff0-b85c-2b278c7be699}", id: false, force: true do |t|
    t.string "RowID",                     limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                      limit: nil
    t.string "UniversalDocTypeName",      limit: 256
    t.string "UniversalDocTypeNumerator", limit: nil
  end

  add_index "dvtable_{af6239bf-b868-4ff0-b85c-2b278c7be699}", ["ParentRowID"], name: "dvsys_refdocsetup_universaldoctypesnumerators_section"

  create_table "dvtable_{afa56784-ff3b-4414-a7b8-a68334bf1d5e}", id: false, force: true do |t|
    t.string   "RowID",                     limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text     "AssignmentsComments"
    t.string   "AssignmentsAssignmentID",   limit: nil
    t.datetime "AssignmentsDeadline"
    t.string   "AssignmentsControler",      limit: nil
    t.boolean  "AssignmentsToRead"
    t.datetime "AssignmentsCompletionDate"
  end

  add_index "dvtable_{afa56784-ff3b-4414-a7b8-a68334bf1d5e}", ["InstanceID"], name: "dvsys_nrdcard_assignments_section"

  create_table "dvtable_{afa56784-ff3b-4414-a7b8-a68334bf1d5e}_archive", id: false, force: true do |t|
    t.string   "RowID",                     limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text     "AssignmentsComments"
    t.string   "AssignmentsAssignmentID",   limit: nil
    t.datetime "AssignmentsDeadline"
    t.string   "AssignmentsControler",      limit: nil
    t.boolean  "AssignmentsToRead"
    t.datetime "AssignmentsCompletionDate"
  end

  add_index "dvtable_{afa56784-ff3b-4414-a7b8-a68334bf1d5e}_archive", ["InstanceID"], name: "dvsys_nrdcard_assignments_archive_section"

  create_table "dvtable_{b1be7123-0a5e-4347-8a97-37a7ec4c8e3a}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.integer "ItemType"
    t.boolean "UseParent"
    t.string  "PrefixSeparator", limit: 32
    t.string  "SuffixSeparator", limit: 32
  end

  add_index "dvtable_{b1be7123-0a5e-4347-8a97-37a7ec4c8e3a}", ["ParentRowID"], name: "dvsys_refnumerators_numberfields_section"

  create_table "dvtable_{b22eb199-cab1-4f5f-88ba-38cdd6cd1fb4}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
  end

  add_index "dvtable_{b22eb199-cab1-4f5f-88ba-38cdd6cd1fb4}", ["ParentRowID"], name: "dvsys_reftypes_categories_section"

  create_table "dvtable_{b3cd26b1-1807-4a98-90da-7969244f4e4e}", id: false, force: true do |t|
    t.string   "RowID",               limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",                limit: 512
    t.string   "Type",                limit: nil
    t.string   "NumberRef",           limit: nil
    t.string   "FullNumber",          limit: 160
    t.boolean  "FixNumber"
    t.string   "Recipient",           limit: nil
    t.datetime "CreationDate"
    t.datetime "RegistrationDate"
    t.string   "RegisteredBy",        limit: nil
    t.text     "Digest"
    t.integer  "PageCount"
    t.integer  "AttachmentPageCount"
    t.string   "FiledInFolder",       limit: nil
    t.string   "FiledInCase",         limit: nil
    t.string   "FilesID",             limit: nil
    t.string   "DocState",            limit: nil
    t.string   "Responsible",         limit: nil
    t.string   "RecipientDep",        limit: nil
    t.string   "ResponsibleDep",      limit: nil
    t.string   "RecipientPosition",   limit: nil
    t.string   "ResponsiblePosition", limit: nil
    t.string   "ParentCardID",        limit: nil
    t.boolean  "PropsAsForm"
    t.boolean  "Confidential"
    t.string   "DocProperty",         limit: 128
    t.string   "BarcodeNumber",       limit: 32
    t.string   "RespRecipient",       limit: nil
    t.string   "ControlledBy",        limit: nil
    t.datetime "ControlDate"
  end

  add_index "dvtable_{b3cd26b1-1807-4a98-90da-7969244f4e4e}", ["InstanceID"], name: "dvsys_cardord_maininfo_uc_struct", unique: true

  create_table "dvtable_{b3cd26b1-1807-4a98-90da-7969244f4e4e}_archive", id: false, force: true do |t|
    t.string   "RowID",               limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Name",                limit: 512
    t.string   "Type",                limit: nil
    t.string   "NumberRef",           limit: nil
    t.string   "FullNumber",          limit: 160
    t.boolean  "FixNumber"
    t.string   "Recipient",           limit: nil
    t.datetime "CreationDate"
    t.datetime "RegistrationDate"
    t.string   "RegisteredBy",        limit: nil
    t.text     "Digest"
    t.integer  "PageCount"
    t.integer  "AttachmentPageCount"
    t.string   "FiledInFolder",       limit: nil
    t.string   "FiledInCase",         limit: nil
    t.string   "FilesID",             limit: nil
    t.string   "DocState",            limit: nil
    t.string   "Responsible",         limit: nil
    t.string   "RecipientDep",        limit: nil
    t.string   "ResponsibleDep",      limit: nil
    t.string   "RecipientPosition",   limit: nil
    t.string   "ResponsiblePosition", limit: nil
    t.string   "ParentCardID",        limit: nil
    t.boolean  "PropsAsForm"
    t.boolean  "Confidential"
    t.string   "DocProperty",         limit: 128
    t.string   "BarcodeNumber",       limit: 32
    t.string   "RespRecipient",       limit: nil
    t.string   "ControlledBy",        limit: nil
    t.datetime "ControlDate"
  end

  add_index "dvtable_{b3cd26b1-1807-4a98-90da-7969244f4e4e}_archive", ["InstanceID"], name: "dvsys_cardord_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{b4562df8-af19-4d0f-85ca-53a311354d39}", id: false, force: true do |t|
    t.string  "RowID",              limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",         limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",        limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",    limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "FileID",             limit: nil
    t.string  "FileName"
    t.string  "Author",             limit: nil
    t.integer "FileSize"
    t.integer "VersioningType"
    t.boolean "IsCheckedOut"
    t.string  "WorkflowProcessID",  limit: nil
    t.string  "URL",                limit: 4000
    t.boolean "OpenAsCard"
    t.boolean "NoPropsToFile"
    t.boolean "NoFileToProps"
    t.boolean "LockCurrentVersion"
  end

  add_index "dvtable_{b4562df8-af19-4d0f-85ca-53a311354d39}", ["InstanceID"], name: "dvsys_cardfile_maininfo_uc_struct", unique: true

  create_table "dvtable_{b4562df8-af19-4d0f-85ca-53a311354d39}_archive", id: false, force: true do |t|
    t.string  "RowID",              limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",         limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",        limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",    limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "FileID",             limit: nil
    t.string  "FileName"
    t.string  "Author",             limit: nil
    t.integer "FileSize"
    t.integer "VersioningType"
    t.boolean "IsCheckedOut"
    t.string  "WorkflowProcessID",  limit: nil
    t.string  "URL",                limit: 4000
    t.boolean "OpenAsCard"
    t.boolean "NoPropsToFile"
    t.boolean "NoFileToProps"
    t.boolean "LockCurrentVersion"
  end

  add_index "dvtable_{b4562df8-af19-4d0f-85ca-53a311354d39}_archive", ["InstanceID"], name: "dvsys_cardfile_maininfo_archive_uc_struct", unique: true

# Could not dump table "dvtable_{b46f6ba8-4098-4bf2-9881-fb98415720cf}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{b4732707-f066-48be-b19e-94c019fce4cc}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Employee",        limit: nil
  end

  add_index "dvtable_{b4732707-f066-48be-b19e-94c019fce4cc}", ["ParentRowID"], name: "dvsys_refreports_sortlistemployees_section"

  create_table "dvtable_{b4db4c03-d225-4efd-ab57-375275798404}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "TypeID",          limit: nil
    t.string "AccessID",        limit: nil
  end

  add_index "dvtable_{b4db4c03-d225-4efd-ab57-375275798404}", ["ParentRowID"], name: "dvsys_foldertypescard_allowedcardtypes_section"

  create_table "dvtable_{b5d96f96-aca2-4184-9702-2d89b1b3936a}", id: false, force: true do |t|
    t.string   "RowID",                      limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID",       limit: nil
    t.datetime "RegistrationDate"
    t.string   "Executer",                   limit: nil
    t.string   "SignedBy",                   limit: nil
    t.integer  "State",                                  default: 1
    t.string   "FilesID",                    limit: nil
    t.text     "Subject"
    t.string   "LinksListId",                limit: nil
    t.string   "Registrator",                limit: nil
    t.text     "Content"
    t.string   "LegacySystemID",             limit: 256
    t.string   "BarcodeNumber",              limit: 40
    t.string   "BarcodeNumberID",            limit: nil
    t.string   "TransferLog",                limit: nil
    t.datetime "Finished"
    t.integer  "ControlState"
    t.datetime "RemovalFromControl"
    t.datetime "Term"
    t.string   "ApprovalList",               limit: nil
    t.string   "CaseID",                     limit: nil
    t.string   "SignedBy_AlternateDirector", limit: nil
    t.boolean  "NoApproving"
    t.string   "ProjectNumber"
    t.string   "ProjectNumberID",            limit: nil
    t.string   "ExecutionProcessID",         limit: nil
    t.datetime "ExecuteDate"
    t.datetime "ProjectDate"
    t.string   "CurrentDocTemplate",         limit: nil
    t.string   "RestrictedKind",             limit: nil
    t.boolean  "WasImproved"
    t.boolean  "ToRegister"
  end

  add_index "dvtable_{b5d96f96-aca2-4184-9702-2d89b1b3936a}", ["InstanceID"], name: "dvsys_memorandumcard_maininfo_uc_struct", unique: true

  create_table "dvtable_{b5d96f96-aca2-4184-9702-2d89b1b3936a}_archive", id: false, force: true do |t|
    t.string   "RowID",                      limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID",       limit: nil
    t.datetime "RegistrationDate"
    t.string   "Executer",                   limit: nil
    t.string   "SignedBy",                   limit: nil
    t.integer  "State"
    t.string   "FilesID",                    limit: nil
    t.text     "Subject"
    t.string   "LinksListId",                limit: nil
    t.string   "Registrator",                limit: nil
    t.text     "Content"
    t.string   "LegacySystemID",             limit: 256
    t.string   "BarcodeNumber",              limit: 40
    t.string   "BarcodeNumberID",            limit: nil
    t.string   "TransferLog",                limit: nil
    t.datetime "Finished"
    t.integer  "ControlState"
    t.datetime "RemovalFromControl"
    t.datetime "Term"
    t.string   "ApprovalList",               limit: nil
    t.string   "CaseID",                     limit: nil
    t.string   "SignedBy_AlternateDirector", limit: nil
    t.boolean  "NoApproving"
    t.string   "ProjectNumber"
    t.string   "ProjectNumberID",            limit: nil
    t.string   "ExecutionProcessID",         limit: nil
    t.datetime "ExecuteDate"
    t.datetime "ProjectDate"
    t.string   "CurrentDocTemplate",         limit: nil
    t.string   "RestrictedKind",             limit: nil
    t.boolean  "WasImproved"
    t.boolean  "ToRegister"
  end

  add_index "dvtable_{b5d96f96-aca2-4184-9702-2d89b1b3936a}_archive", ["InstanceID"], name: "dvsys_memorandumcard_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{b623be26-6119-445c-88c5-8b711133bc19}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "AccountName",     limit: 128
    t.integer "AccessLevel"
  end

  create_table "dvtable_{b63745e1-3a54-4b2a-87c1-322285ba5a31}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{b63745e1-3a54-4b2a-87c1-322285ba5a31}", ["InstanceID", "ParentRowID"], name: "dvsys_cardarchive_enumvalues_section"
  add_index "dvtable_{b63745e1-3a54-4b2a-87c1-322285ba5a31}", ["ParentRowID"], name: "dvsys_cardarchive_enumvalues_idx_parentrowid"

  create_table "dvtable_{b63745e1-3a54-4b2a-87c1-322285ba5a31}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{b63745e1-3a54-4b2a-87c1-322285ba5a31}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardarchive_enumvalues_archive_section"
  add_index "dvtable_{b63745e1-3a54-4b2a-87c1-322285ba5a31}_archive", ["ParentRowID"], name: "dvsys_cardarchive_enumvalues_archive_idx_parentrowid"

  create_table "dvtable_{b72f53f0-2612-45e1-802e-5b51ba415b72}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "ChangeDate"
    t.string   "ChangedBy",       limit: nil
    t.string   "TaskName",        limit: 256
    t.string   "Value",           limit: 512
  end

  add_index "dvtable_{b72f53f0-2612-45e1-802e-5b51ba415b72}", ["InstanceID", "ParentRowID"], name: "dvsys_workflowtask_values_section"
  add_index "dvtable_{b72f53f0-2612-45e1-802e-5b51ba415b72}", ["ParentRowID"], name: "dvsys_workflowtask_values_idx_parentrowid"

  create_table "dvtable_{b72f53f0-2612-45e1-802e-5b51ba415b72}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "ChangeDate"
    t.string   "ChangedBy",       limit: nil
    t.string   "TaskName",        limit: 256
    t.string   "Value",           limit: 512
  end

  add_index "dvtable_{b72f53f0-2612-45e1-802e-5b51ba415b72}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_workflowtask_values_archive_section"
  add_index "dvtable_{b72f53f0-2612-45e1-802e-5b51ba415b72}_archive", ["ParentRowID"], name: "dvsys_workflowtask_values_archive_idx_parentrowid"

  create_table "dvtable_{b788061d-b569-4c44-8f30-ec6c0e791ea9}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Name",            limit: 128
  end

  add_index "dvtable_{b788061d-b569-4c44-8f30-ec6c0e791ea9}", ["InstanceID"], name: "dvsys_cardcalendar_maininfo_uc_struct", unique: true

  create_table "dvtable_{b788061d-b569-4c44-8f30-ec6c0e791ea9}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Name",            limit: 128
  end

  add_index "dvtable_{b788061d-b569-4c44-8f30-ec6c0e791ea9}_archive", ["InstanceID"], name: "dvsys_cardcalendar_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{b78bfefd-dd50-410f-966f-31fb27bc3904}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Type",            limit: nil
    t.string   "Link",            limit: nil
    t.string   "Comments",        limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "URL",             limit: 512
    t.string   "LinkDesc",        limit: 32
    t.string   "FolderID",        limit: nil
  end

  add_index "dvtable_{b78bfefd-dd50-410f-966f-31fb27bc3904}", ["InstanceID"], name: "dvsys_cardout_cardreferences_section"

  create_table "dvtable_{b78bfefd-dd50-410f-966f-31fb27bc3904}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Type",            limit: nil
    t.string   "Link",            limit: nil
    t.string   "Comments",        limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "URL",             limit: 512
    t.string   "LinkDesc",        limit: 32
    t.string   "FolderID",        limit: nil
  end

  add_index "dvtable_{b78bfefd-dd50-410f-966f-31fb27bc3904}_archive", ["InstanceID"], name: "dvsys_cardout_cardreferences_archive_section"

  create_table "dvtable_{b7a7d790-1be9-4f21-bc71-8be843999d36}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Event"
    t.integer "EmployeeType"
    t.string  "Comments",        limit: 3900
    t.string  "Author",          limit: nil
    t.boolean "Disabled"
  end

  add_index "dvtable_{b7a7d790-1be9-4f21-bc71-8be843999d36}", ["InstanceID"], name: "dvsys_cardresolution_notifications_section"

  create_table "dvtable_{b7a7d790-1be9-4f21-bc71-8be843999d36}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Event"
    t.integer "EmployeeType"
    t.string  "Comments",        limit: 3900
    t.string  "Author",          limit: nil
    t.boolean "Disabled"
  end

  add_index "dvtable_{b7a7d790-1be9-4f21-bc71-8be843999d36}_archive", ["InstanceID"], name: "dvsys_cardresolution_notifications_archive_section"

# Could not dump table "dvtable_{b822d7d1-2280-4b51-ae58-a1cf757c5672}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{b822d7d1-2280-4b51-ae58-a1cf757c5672}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{b856bf94-1d7c-4cd0-a98c-b50d65966fbe}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "TypeID",          limit: nil
  end

  add_index "dvtable_{b856bf94-1d7c-4cd0-a98c-b50d65966fbe}", ["ParentRowID"], name: "dvsys_navcommands_cardtypes_section"

  create_table "dvtable_{b9ff9e65-fbdb-4883-a4f8-38d31f8322d6}", id: false, force: true do |t|
    t.string  "RowID",                   limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",              limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean "CanReject"
    t.boolean "CanViewLog"
    t.boolean "CanReschedule"
    t.boolean "ControllerCanReschedule"
    t.boolean "CanDelegate"
    t.boolean "DelegateToAll"
    t.boolean "IsReportNeeded"
    t.boolean "CanAddDocuments"
    t.boolean "AddNewReferences"
    t.string  "CompletionText",          limit: 512
    t.string  "CompletionTextPID",       limit: nil
    t.boolean "ToRead"
    t.boolean "CanOpenParent"
    t.boolean "PerformConfirmation"
    t.string  "FinishParam",             limit: nil
    t.boolean "IsAddFileNeeded"
    t.boolean "DelegateToDeputies"
    t.string  "JournalsName",            limit: 128
    t.string  "FilesToAddPID",           limit: nil
    t.integer "FilesCount"
    t.integer "DefaultVersioningType"
    t.boolean "FinishListOnly"
    t.boolean "ReportCardRequired"
    t.boolean "NoDialogOnFinish"
    t.string  "TemplateID",              limit: nil
    t.boolean "KeepTask"
    t.integer "FinishDialogWidth"
    t.integer "FinishDialogHeight"
    t.boolean "CanDeleteDocuments"
    t.boolean "SendAsHTML"
    t.boolean "UseCalendar"
    t.boolean "AuthorCanReschedule"
    t.boolean "WorkDurationRequired"
  end

  add_index "dvtable_{b9ff9e65-fbdb-4883-a4f8-38d31f8322d6}", ["InstanceID"], name: "dvsys_workflowtask_additionalsettings_uc_struct", unique: true

  create_table "dvtable_{b9ff9e65-fbdb-4883-a4f8-38d31f8322d6}_archive", id: false, force: true do |t|
    t.string  "RowID",                   limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",              limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean "CanReject"
    t.boolean "CanViewLog"
    t.boolean "CanReschedule"
    t.boolean "ControllerCanReschedule"
    t.boolean "CanDelegate"
    t.boolean "DelegateToAll"
    t.boolean "IsReportNeeded"
    t.boolean "CanAddDocuments"
    t.boolean "AddNewReferences"
    t.string  "CompletionText",          limit: 512
    t.string  "CompletionTextPID",       limit: nil
    t.boolean "ToRead"
    t.boolean "CanOpenParent"
    t.boolean "PerformConfirmation"
    t.string  "FinishParam",             limit: nil
    t.boolean "IsAddFileNeeded"
    t.boolean "DelegateToDeputies"
    t.string  "JournalsName",            limit: 128
    t.string  "FilesToAddPID",           limit: nil
    t.integer "FilesCount"
    t.integer "DefaultVersioningType"
    t.boolean "FinishListOnly"
    t.boolean "ReportCardRequired"
    t.boolean "NoDialogOnFinish"
    t.string  "TemplateID",              limit: nil
    t.boolean "KeepTask"
    t.integer "FinishDialogWidth"
    t.integer "FinishDialogHeight"
    t.boolean "CanDeleteDocuments"
    t.boolean "SendAsHTML"
    t.boolean "UseCalendar"
    t.boolean "AuthorCanReschedule"
    t.boolean "WorkDurationRequired"
  end

  add_index "dvtable_{b9ff9e65-fbdb-4883-a4f8-38d31f8322d6}_archive", ["InstanceID"], name: "dvsys_workflowtask_additionalsettings_archive_uc_struct", unique: true

  create_table "dvtable_{bb0bad14-7d3d-4593-89c0-cfc7436927fc}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text     "Comment"
    t.string   "AuthorID",        limit: nil
    t.datetime "Date"
  end

  add_index "dvtable_{bb0bad14-7d3d-4593-89c0-cfc7436927fc}", ["InstanceID"], name: "dvsys_versionedfilecard_maincomments_section"

  create_table "dvtable_{bb0bad14-7d3d-4593-89c0-cfc7436927fc}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text     "Comment"
    t.string   "AuthorID",        limit: nil
    t.datetime "Date"
  end

  add_index "dvtable_{bb0bad14-7d3d-4593-89c0-cfc7436927fc}_archive", ["InstanceID"], name: "dvsys_versionedfilecard_maincomments_archive_section"

  create_table "dvtable_{bbaa81aa-999d-461b-9b74-2a60a0965555}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ResolutionID",    limit: nil
    t.integer "ChildState"
  end

  add_index "dvtable_{bbaa81aa-999d-461b-9b74-2a60a0965555}", ["InstanceID"], name: "dvsys_workflowtask_childrenresolutions_section"

  create_table "dvtable_{bbaa81aa-999d-461b-9b74-2a60a0965555}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ResolutionID",    limit: nil
    t.integer "ChildState"
  end

  add_index "dvtable_{bbaa81aa-999d-461b-9b74-2a60a0965555}_archive", ["InstanceID"], name: "dvsys_workflowtask_childrenresolutions_archive_section"

# Could not dump table "dvtable_{bc3735f3-67ee-412c-85fe-f39668fd72da}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{bc3735f3-67ee-412c-85fe-f39668fd72da}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{bc6b1152-e152-4a49-bcc0-24756c8108ab}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ResolutionID",    limit: nil
  end

  add_index "dvtable_{bc6b1152-e152-4a49-bcc0-24756c8108ab}", ["InstanceID"], name: "dvsys_cardout_resolutions_section"

  create_table "dvtable_{bc6b1152-e152-4a49-bcc0-24756c8108ab}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ResolutionID",    limit: nil
  end

  add_index "dvtable_{bc6b1152-e152-4a49-bcc0-24756c8108ab}_archive", ["InstanceID"], name: "dvsys_cardout_resolutions_archive_section"

  create_table "dvtable_{bd286ca5-2f4b-48ab-8c6a-51b77779acbc}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "FieldName",       limit: 128
    t.boolean "FirstLetterOnly"
    t.string  "Prefix",          limit: 16
    t.string  "Suffix",          limit: 16
  end

  add_index "dvtable_{bd286ca5-2f4b-48ab-8c6a-51b77779acbc}", ["ParentRowID"], name: "dvsys_refstaff_employeesformat_section"

  create_table "dvtable_{bd3d6e98-e346-4e73-bedd-a0065a01fa88}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Employee",        limit: nil
  end

  add_index "dvtable_{bd3d6e98-e346-4e73-bedd-a0065a01fa88}", ["ParentRowID"], name: "dvsys_refreports_odemployees_section"

  create_table "dvtable_{bdafe82a-04fa-4391-98b7-5df6502e03dd}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                   null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "Name",            limit: 128
    t.string "Comments",        limit: 1024
    t.string "Genitive",        limit: 128
    t.string "Dative",          limit: 128
    t.string "Accusative",      limit: 128
    t.string "Instrumental",    limit: 128
    t.string "Prepositional",   limit: 128
    t.string "AlternativeName", limit: 128
    t.string "NameUID",         limit: nil
  end

  add_index "dvtable_{bdafe82a-04fa-4391-98b7-5df6502e03dd}", ["Name", "NameUID"], name: "dvsys_refpartners_positions_uc_global_name", unique: true

  create_table "dvtable_{bde9e801-9fb5-4d5c-b604-19f7a73448c1}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{bde9e801-9fb5-4d5c-b604-19f7a73448c1}", ["CategoryID", "InstanceID", "CategoryIDUID"], name: "dvsys_cardord_categories_uc_card_categoryid", unique: true
  add_index "dvtable_{bde9e801-9fb5-4d5c-b604-19f7a73448c1}", ["InstanceID"], name: "dvsys_cardord_categories_section"

  create_table "dvtable_{bde9e801-9fb5-4d5c-b604-19f7a73448c1}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{bde9e801-9fb5-4d5c-b604-19f7a73448c1}_archive", ["InstanceID"], name: "dvsys_cardord_categories_archive_section"

  create_table "dvtable_{beda2498-9859-4d35-9de9-86d6f32db212}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "ActionDate"
    t.string   "ActionBy",        limit: nil
    t.string   "Description",     limit: 2048
    t.integer  "Cycle"
    t.string   "FileID",          limit: nil
    t.integer  "FileState"
    t.integer  "DocumentState"
    t.string   "ApproverRowID",   limit: nil
  end

  add_index "dvtable_{beda2498-9859-4d35-9de9-86d6f32db212}", ["InstanceID"], name: "dvsys_cardapproval_log_section"

  create_table "dvtable_{beda2498-9859-4d35-9de9-86d6f32db212}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "ActionDate"
    t.string   "ActionBy",        limit: nil
    t.string   "Description",     limit: 2048
    t.integer  "Cycle"
    t.string   "FileID",          limit: nil
    t.integer  "FileState"
    t.integer  "DocumentState"
    t.string   "ApproverRowID",   limit: nil
  end

  add_index "dvtable_{beda2498-9859-4d35-9de9-86d6f32db212}_archive", ["InstanceID"], name: "dvsys_cardapproval_log_archive_section"

  create_table "dvtable_{bf140314-f669-4686-aafe-0a33f1a7e87d}", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "ExecutionProcessKind"
    t.string   "Employee",             limit: nil
    t.datetime "RecordDate"
    t.text     "Comments"
  end

  add_index "dvtable_{bf140314-f669-4686-aafe-0a33f1a7e87d}", ["InstanceID", "ParentRowID"], name: "dvsys_executionprocess_executionprocesslist_section"
  add_index "dvtable_{bf140314-f669-4686-aafe-0a33f1a7e87d}", ["ParentRowID"], name: "dvsys_executionprocess_executionprocesslist_idx_parentrowid"

  create_table "dvtable_{bf140314-f669-4686-aafe-0a33f1a7e87d}_archive", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "ExecutionProcessKind"
    t.string   "Employee",             limit: nil
    t.datetime "RecordDate"
    t.text     "Comments"
  end

  add_index "dvtable_{bf140314-f669-4686-aafe-0a33f1a7e87d}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_executionprocess_executionprocesslist_archive_section"
  add_index "dvtable_{bf140314-f669-4686-aafe-0a33f1a7e87d}_archive", ["ParentRowID"], name: "dvsys_executionprocess_executionprocesslist_archive_idx_parentrowid"

  create_table "dvtable_{bf323ee8-f716-44bc-bef3-4854d347eefe}", id: false, force: true do |t|
    t.string  "RowID",             limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean "UseDuals"
    t.boolean "UseDivisionFilter"
  end

  add_index "dvtable_{bf323ee8-f716-44bc-bef3-4854d347eefe}", ["InstanceID"], name: "dvsys_refreplicatorsetup_settings_uc_struct", unique: true

  create_table "dvtable_{bf46a5e8-44a0-4545-865b-5f341875d2b2}", id: false, force: true do |t|
    t.string   "RowID",                    limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",              limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text     "CancelInfo"
    t.datetime "DateInfo"
    t.string   "CancellationDocumentInfo", limit: nil
    t.string   "EmployeeInfo",             limit: nil
  end

  add_index "dvtable_{bf46a5e8-44a0-4545-865b-5f341875d2b2}", ["InstanceID"], name: "dvsys_ordercard_cancellationinfo_section"

  create_table "dvtable_{bf46a5e8-44a0-4545-865b-5f341875d2b2}_archive", id: false, force: true do |t|
    t.string   "RowID",                    limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",              limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text     "CancelInfo"
    t.datetime "DateInfo"
    t.string   "CancellationDocumentInfo", limit: nil
    t.string   "EmployeeInfo",             limit: nil
  end

  add_index "dvtable_{bf46a5e8-44a0-4545-865b-5f341875d2b2}_archive", ["InstanceID"], name: "dvsys_ordercard_cancellationinfo_archive_section"

  create_table "dvtable_{bf5293f4-c6f5-4575-9632-0a1178755d31}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                   null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Name",            limit: 128
    t.string "Xml",             limit: 2000
    t.string "ViewID",          limit: nil
    t.string "NameUID",         limit: nil
  end

  add_index "dvtable_{bf5293f4-c6f5-4575-9632-0a1178755d31}", ["Name", "ParentRowID", "NameUID"], name: "dvsys_savedviewcard_sorting_uc_section_name", unique: true
  add_index "dvtable_{bf5293f4-c6f5-4575-9632-0a1178755d31}", ["ParentRowID"], name: "dvsys_savedviewcard_sorting_section"

  create_table "dvtable_{bf6c7a87-f8f5-4707-98e0-a33e10ae7ef2}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "StartTime"
    t.datetime "EndTime"
  end

  add_index "dvtable_{bf6c7a87-f8f5-4707-98e0-a33e10ae7ef2}", ["InstanceID", "ParentRowID"], name: "dvsys_cardcalendar_worktime_section"
  add_index "dvtable_{bf6c7a87-f8f5-4707-98e0-a33e10ae7ef2}", ["ParentRowID"], name: "dvsys_cardcalendar_worktime_idx_parentrowid"

  create_table "dvtable_{bf6c7a87-f8f5-4707-98e0-a33e10ae7ef2}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "StartTime"
    t.datetime "EndTime"
  end

  add_index "dvtable_{bf6c7a87-f8f5-4707-98e0-a33e10ae7ef2}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardcalendar_worktime_archive_section"
  add_index "dvtable_{bf6c7a87-f8f5-4707-98e0-a33e10ae7ef2}_archive", ["ParentRowID"], name: "dvsys_cardcalendar_worktime_archive_idx_parentrowid"

  create_table "dvtable_{bf8269db-570a-47ac-98f1-e88e40af7661}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "Order"
    t.string   "Approver",        limit: nil
    t.datetime "StartDate"
    t.datetime "ApprovingDate"
    t.integer  "Decision"
    t.text     "Comment"
    t.boolean  "IsSign"
  end

  add_index "dvtable_{bf8269db-570a-47ac-98f1-e88e40af7661}", ["InstanceID"], name: "dvsys_outdoc_approvals_section"

  create_table "dvtable_{bf8269db-570a-47ac-98f1-e88e40af7661}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "Order"
    t.string   "Approver",        limit: nil
    t.datetime "StartDate"
    t.datetime "ApprovingDate"
    t.integer  "Decision"
    t.text     "Comment"
    t.boolean  "IsSign"
  end

  add_index "dvtable_{bf8269db-570a-47ac-98f1-e88e40af7661}_archive", ["InstanceID"], name: "dvsys_outdoc_approvals_archive_section"

  create_table "dvtable_{c00f1798-2e00-4493-801a-8a3bc4737fb2}", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Board",                limit: nil
    t.text     "Subject"
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID", limit: nil
    t.datetime "RegisterDate"
    t.string   "Chairman",             limit: nil
    t.string   "Secretary",            limit: nil
    t.datetime "SessionDate"
    t.string   "Registrator",          limit: nil
    t.integer  "State",                            default: 1
    t.string   "FileListId",           limit: nil
    t.string   "LinksListId",          limit: nil
    t.string   "LegacySystemID",       limit: 256
    t.string   "BarcodeNumber",        limit: 40
    t.string   "BarcodeNumberID",      limit: nil
    t.string   "TransferLog",          limit: nil
    t.string   "BoardType",            limit: nil
    t.string   "CaseID",               limit: nil
    t.string   "ApprovalListID",       limit: nil
    t.string   "ProtocolFile",         limit: nil
    t.boolean  "NoApproving"
    t.string   "BoardTypeText"
  end

  add_index "dvtable_{c00f1798-2e00-4493-801a-8a3bc4737fb2}", ["InstanceID"], name: "dvsys_protocolcard_maininfo_uc_struct", unique: true

  create_table "dvtable_{c00f1798-2e00-4493-801a-8a3bc4737fb2}_archive", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Board",                limit: nil
    t.text     "Subject"
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID", limit: nil
    t.datetime "RegisterDate"
    t.string   "Chairman",             limit: nil
    t.string   "Secretary",            limit: nil
    t.datetime "SessionDate"
    t.string   "Registrator",          limit: nil
    t.integer  "State"
    t.string   "FileListId",           limit: nil
    t.string   "LinksListId",          limit: nil
    t.string   "LegacySystemID",       limit: 256
    t.string   "BarcodeNumber",        limit: 40
    t.string   "BarcodeNumberID",      limit: nil
    t.string   "TransferLog",          limit: nil
    t.string   "BoardType",            limit: nil
    t.string   "CaseID",               limit: nil
    t.string   "ApprovalListID",       limit: nil
    t.string   "ProtocolFile",         limit: nil
    t.boolean  "NoApproving"
    t.string   "BoardTypeText"
  end

  add_index "dvtable_{c00f1798-2e00-4493-801a-8a3bc4737fb2}_archive", ["InstanceID"], name: "dvsys_protocolcard_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{c01049c0-940f-490c-8a0a-4c10e9edf2f6}", id: false, force: true do |t|
    t.string   "RowID",            limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Employee",         limit: nil
    t.string   "Substitute",       limit: nil
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.datetime "PlannedStartDate"
    t.datetime "PlannedEndDate"
  end

  create_table "dvtable_{c06228b9-99f8-4b41-950b-8facdc00a2b7}", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "RegistrationDate"
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID", limit: nil
    t.integer  "State",                            default: 1
    t.integer  "ListCount"
    t.integer  "InAppendix"
    t.string   "Registrator",          limit: nil
    t.string   "CaseID",               limit: nil
    t.string   "FileListId",           limit: nil
    t.string   "SignedBy",             limit: nil
    t.string   "Executer",             limit: nil
    t.text     "Subject"
    t.integer  "DeliveryType"
    t.datetime "LetterDate"
    t.string   "LetterNumber",         limit: 100
    t.string   "Recipient",            limit: nil
    t.string   "LinksListId",          limit: nil
    t.string   "ReplicationCard",      limit: nil
    t.string   "LegacySystemID",       limit: 256
    t.datetime "Term"
    t.boolean  "FromParentOrg"
    t.datetime "Finished"
    t.string   "BarcodeNumber",        limit: 40
    t.string   "BarcodeNumberID",      limit: nil
    t.string   "TransferLog",          limit: nil
    t.integer  "ControlState",                     default: 0
    t.datetime "RemovalFromControl"
    t.datetime "OnControlDate"
    t.string   "SignedByDual",         limit: nil
    t.text     "Report"
    t.boolean  "Iteratively"
    t.integer  "DocType"
    t.string   "Address",              limit: 256
    t.string   "Enclosure",            limit: 256
    t.string   "Topic",                limit: 256
    t.string   "ExecutionProcessID",   limit: nil
    t.string   "ReceiptKind",          limit: nil
    t.string   "RestrictedKind",       limit: nil
    t.boolean  "NoApproving"
    t.text     "SignedByText"
    t.string   "OrgText",              limit: 256
  end

  add_index "dvtable_{c06228b9-99f8-4b41-950b-8facdc00a2b7}", ["InstanceID"], name: "dvsys_incdoc_maininfo_uc_struct", unique: true

  create_table "dvtable_{c06228b9-99f8-4b41-950b-8facdc00a2b7}_archive", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "RegistrationDate"
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID", limit: nil
    t.integer  "State"
    t.integer  "ListCount"
    t.integer  "InAppendix"
    t.string   "Registrator",          limit: nil
    t.string   "CaseID",               limit: nil
    t.string   "FileListId",           limit: nil
    t.string   "SignedBy",             limit: nil
    t.string   "Executer",             limit: nil
    t.text     "Subject"
    t.integer  "DeliveryType"
    t.datetime "LetterDate"
    t.string   "LetterNumber",         limit: 100
    t.string   "Recipient",            limit: nil
    t.string   "LinksListId",          limit: nil
    t.string   "ReplicationCard",      limit: nil
    t.string   "LegacySystemID",       limit: 256
    t.datetime "Term"
    t.boolean  "FromParentOrg"
    t.datetime "Finished"
    t.string   "BarcodeNumber",        limit: 40
    t.string   "BarcodeNumberID",      limit: nil
    t.string   "TransferLog",          limit: nil
    t.integer  "ControlState"
    t.datetime "RemovalFromControl"
    t.datetime "OnControlDate"
    t.string   "SignedByDual",         limit: nil
    t.text     "Report"
    t.boolean  "Iteratively"
    t.integer  "DocType"
    t.string   "Address",              limit: 256
    t.string   "Enclosure",            limit: 256
    t.string   "Topic",                limit: 256
    t.string   "ExecutionProcessID",   limit: nil
    t.string   "ReceiptKind",          limit: nil
    t.string   "RestrictedKind",       limit: nil
    t.boolean  "NoApproving"
    t.text     "SignedByText"
    t.string   "OrgText",              limit: 256
  end

  add_index "dvtable_{c06228b9-99f8-4b41-950b-8facdc00a2b7}_archive", ["InstanceID"], name: "dvsys_incdoc_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{c0c45423-d1dc-4f18-a983-0029f93805ca}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Category",        limit: nil
  end

  add_index "dvtable_{c0c45423-d1dc-4f18-a983-0029f93805ca}", ["InstanceID"], name: "dvsys_nrdcard_categories_section"

  create_table "dvtable_{c0c45423-d1dc-4f18-a983-0029f93805ca}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Category",        limit: nil
  end

  add_index "dvtable_{c0c45423-d1dc-4f18-a983-0029f93805ca}_archive", ["InstanceID"], name: "dvsys_nrdcard_categories_archive_section"

  create_table "dvtable_{c11dd518-2350-4367-b310-5f6e384f2920}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "EmployeeID",      limit: nil
    t.integer "Type"
    t.boolean "IsResponsible"
    t.string  "DepartmentID",    limit: nil
    t.string  "PositionID",      limit: nil
  end

  add_index "dvtable_{c11dd518-2350-4367-b310-5f6e384f2920}", ["InstanceID"], name: "dvsys_cardout_employees_section"

  create_table "dvtable_{c11dd518-2350-4367-b310-5f6e384f2920}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "EmployeeID",      limit: nil
    t.integer "Type"
    t.boolean "IsResponsible"
    t.string  "DepartmentID",    limit: nil
    t.string  "PositionID",      limit: nil
  end

  add_index "dvtable_{c11dd518-2350-4367-b310-5f6e384f2920}_archive", ["InstanceID"], name: "dvsys_cardout_employees_archive_section"

  create_table "dvtable_{c17b7783-42c4-45cb-a66b-05cc634c7eb0}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "Name",            limit: 256
    t.string "NameUID",         limit: nil
  end

  add_index "dvtable_{c17b7783-42c4-45cb-a66b-05cc634c7eb0}", ["Name", "ParentTreeRowID", "NameUID"], name: "dvsys_savedsearchcard_groups_uc_tree_name", unique: true
  add_index "dvtable_{c17b7783-42c4-45cb-a66b-05cc634c7eb0}", ["ParentTreeRowID"], name: "dvsys_savedsearchcard_groups_section"

  create_table "dvtable_{c1d462e3-0425-4f9a-b49f-095d709f465d}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Representative",  limit: nil
  end

  add_index "dvtable_{c1d462e3-0425-4f9a-b49f-095d709f465d}", ["InstanceID", "ParentRowID"], name: "dvsys_warrantcard_partnerrepresentatives_section"
  add_index "dvtable_{c1d462e3-0425-4f9a-b49f-095d709f465d}", ["ParentRowID"], name: "dvsys_warrantcard_partnerrepresentatives_idx_parentrowid"

  create_table "dvtable_{c1d462e3-0425-4f9a-b49f-095d709f465d}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Representative",  limit: nil
  end

  add_index "dvtable_{c1d462e3-0425-4f9a-b49f-095d709f465d}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_warrantcard_partnerrepresentatives_archive_section"
  add_index "dvtable_{c1d462e3-0425-4f9a-b49f-095d709f465d}_archive", ["ParentRowID"], name: "dvsys_warrantcard_partnerrepresentatives_archive_idx_parentrowid"

  create_table "dvtable_{c2045b41-e6bb-4576-9ac5-32a953bce9d2}", id: false, force: true do |t|
    t.string  "RowID",             limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ColumnName",        limit: 32
    t.integer "Order"
    t.boolean "Ascending"
    t.string  "AggregationText",   limit: 64
    t.string  "AggregationColumn", limit: 32
    t.integer "Aggregation"
    t.boolean "Active"
    t.boolean "ShowExpanded"
    t.integer "RowHeight"
    t.string  "GroupFont",         limit: 32,  default: "MS Sans Serif"
    t.integer "GroupFontSize",                 default: 9
    t.integer "GroupFontStyle"
    t.integer "GroupFontCharset"
    t.integer "BackColor"
    t.integer "GroupFlags"
    t.integer "ForeColor"
  end

  add_index "dvtable_{c2045b41-e6bb-4576-9ac5-32a953bce9d2}", ["ParentRowID"], name: "dvsys_navigatorcard_groupingsettings_section"

  create_table "dvtable_{c24bb3d0-d470-48d9-9672-d4d2b51f6e67}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "EmployeeID",      limit: nil
    t.integer "Type"
    t.boolean "IsResponsible"
    t.string  "DepartmentID",    limit: nil
    t.string  "PositionID",      limit: nil
  end

  add_index "dvtable_{c24bb3d0-d470-48d9-9672-d4d2b51f6e67}", ["InstanceID"], name: "dvsys_cardreport_employees_section"

  create_table "dvtable_{c24bb3d0-d470-48d9-9672-d4d2b51f6e67}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "EmployeeID",      limit: nil
    t.integer "Type"
    t.boolean "IsResponsible"
    t.string  "DepartmentID",    limit: nil
    t.string  "PositionID",      limit: nil
  end

  add_index "dvtable_{c24bb3d0-d470-48d9-9672-d4d2b51f6e67}_archive", ["InstanceID"], name: "dvsys_cardreport_employees_archive_section"

  create_table "dvtable_{c2efa36a-5d64-4694-bb39-579cf53465ad}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "FieldName",       limit: 128
    t.boolean "FirstLetterOnly"
  end

  add_index "dvtable_{c2efa36a-5d64-4694-bb39-579cf53465ad}", ["ParentRowID"], name: "dvsys_refstaff_emplviewfields_section"

  create_table "dvtable_{c5d16ffd-733f-4f78-a6a6-b03c84f80594}", id: false, force: true do |t|
    t.string  "RowID",                              limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",                        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",                    limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                               limit: nil
    t.string  "OrderNumerator",                     limit: nil
    t.string  "OrderBPTemplate",                    limit: nil
    t.string  "OrderBPStartingFolder",              limit: nil
    t.string  "OrderBPInstanceFolder",              limit: nil
    t.integer "OrderApprovingDuration"
    t.integer "OrderCorrectionDuration"
    t.integer "OrderSigningDuration"
    t.string  "OrderEmployee_OD",                   limit: nil
    t.integer "OrderAssignmentDuration"
    t.string  "OrderFolder",                        limit: nil
    t.integer "OrderSendAssignmentToExecuter"
    t.string  "OrderPrintTemplate",                 limit: nil
    t.string  "OrderNotificationListPrintTemplate", limit: nil
    t.boolean "OrderNoApproving"
    t.string  "OrderTypeRef",                       limit: nil
    t.string  "OrderNumeratorProject",              limit: nil
    t.string  "OrderDocPrintTemplate",              limit: nil
    t.boolean "OrderAlternativeProcessCorrection"
  end

  add_index "dvtable_{c5d16ffd-733f-4f78-a6a6-b03c84f80594}", ["InstanceID"], name: "dvsys_refdocsetup_ordersetup_uc_struct", unique: true

  create_table "dvtable_{c5e63756-ed2c-4557-9ccd-e4bec95f0da2}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Field"
  end

  add_index "dvtable_{c5e63756-ed2c-4557-9ccd-e4bec95f0da2}", ["InstanceID"], name: "dvsys_refreportnrd_maininfo_uc_struct", unique: true

  create_table "dvtable_{c5f5b33a-5201-414c-87f4-7e0c5e641add}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "RefID",           limit: nil
    t.integer "RefType"
    t.string  "RefIDUID",        limit: nil
  end

  add_index "dvtable_{c5f5b33a-5201-414c-87f4-7e0c5e641add}", ["ParentRowID"], name: "dvsys_refstaff_contains_section"
  add_index "dvtable_{c5f5b33a-5201-414c-87f4-7e0c5e641add}", ["RefID", "ParentRowID", "RefIDUID"], name: "dvsys_refstaff_contains_uc_section_refid", unique: true

  create_table "dvtable_{c64843c3-484f-45e0-9b8a-900ea91be54d}", id: false, force: true do |t|
    t.string  "RowID",               limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "DefaultFolderID",     limit: nil
    t.boolean "HidePickerSelection"
    t.string  "PickerExtensionID",   limit: nil
    t.binary  "Certificate"
  end

  add_index "dvtable_{c64843c3-484f-45e0-9b8a-900ea91be54d}", ["InstanceID"], name: "dvsys_userprofilecard_maininfo_uc_struct", unique: true

  create_table "dvtable_{c78abded-db1c-4217-ae0d-51a400546923}", id: false, force: true do |t|
    t.string  "RowID",                limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",           limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",          limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                 limit: nil
    t.string  "Name",                 limit: 128
    t.integer "Type"
    t.string  "Manager",              limit: nil
    t.string  "ContactPerson",        limit: nil
    t.string  "Phone",                limit: 64
    t.string  "Fax",                  limit: 64
    t.string  "Email",                limit: 64
    t.string  "Telex",                limit: 32
    t.string  "Account",              limit: 64
    t.string  "CorrespondentAccount", limit: 64
    t.string  "BankName",             limit: 128
    t.string  "BIK",                  limit: 128
    t.string  "INN",                  limit: 128
    t.string  "KPP",                  limit: 32
    t.string  "OKPO",                 limit: 128
    t.string  "OKONH",                limit: 128
    t.string  "Comments",             limit: 1024
    t.boolean "IsVendor"
    t.boolean "IsClient"
    t.string  "FullName",             limit: 1024
    t.string  "SyncTag",              limit: 256
    t.boolean "NotAvailable",                      default: false
    t.string  "ChiefAccountant",      limit: nil
    t.string  "OrgType",              limit: nil
    t.string  "URL",                  limit: 256
    t.string  "NameUID",              limit: nil
    t.string  "DuplicateID",          limit: 256
    t.string  "UniquePartner",        limit: nil
  end

  add_index "dvtable_{c78abded-db1c-4217-ae0d-51a400546923}", ["INN"], name: "dvsys_refpartners_companies_idx_inn"
  add_index "dvtable_{c78abded-db1c-4217-ae0d-51a400546923}", ["Name", "ParentTreeRowID", "NameUID"], name: "dvsys_refpartners_companies_uc_tree_name", unique: true
  add_index "dvtable_{c78abded-db1c-4217-ae0d-51a400546923}", ["ParentTreeRowID"], name: "dvsys_refpartners_companies_section"

  create_table "dvtable_{c9185c66-5104-45c2-a0a0-18787e69dc50}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "Name",            limit: 128
    t.string "NameUID",         limit: nil
  end

  add_index "dvtable_{c9185c66-5104-45c2-a0a0-18787e69dc50}", ["Name", "ParentTreeRowID", "ParentRowID", "NameUID"], name: "dvsys_settingscard_settinggroups_uc_tree_name", unique: true
  add_index "dvtable_{c9185c66-5104-45c2-a0a0-18787e69dc50}", ["ParentRowID", "ParentTreeRowID"], name: "dvsys_settingscard_settinggroups_section"

  create_table "dvtable_{c9e2d5d7-deb2-43ea-84ef-a511507259e3}", id: false, force: true do |t|
    t.string "RowID",                      limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SignedByPerson",             limit: nil
    t.string "SignedBy_AlternateDirector", limit: nil
  end

  add_index "dvtable_{c9e2d5d7-deb2-43ea-84ef-a511507259e3}", ["InstanceID", "ParentRowID"], name: "dvsys_outdoc_signedbypersons_section"
  add_index "dvtable_{c9e2d5d7-deb2-43ea-84ef-a511507259e3}", ["ParentRowID"], name: "dvsys_outdoc_signedbypersons_idx_parentrowid"

  create_table "dvtable_{c9e2d5d7-deb2-43ea-84ef-a511507259e3}_archive", id: false, force: true do |t|
    t.string "RowID",                      limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SignedByPerson",             limit: nil
    t.string "SignedBy_AlternateDirector", limit: nil
  end

  add_index "dvtable_{c9e2d5d7-deb2-43ea-84ef-a511507259e3}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_outdoc_signedbypersons_archive_section"
  add_index "dvtable_{c9e2d5d7-deb2-43ea-84ef-a511507259e3}_archive", ["ParentRowID"], name: "dvsys_outdoc_signedbypersons_archive_idx_parentrowid"

  create_table "dvtable_{ca22a1a7-bc97-4426-a489-9a96f316feec}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "Name"
    t.string "Person",          limit: nil
  end

  create_table "dvtable_{caaa3e6d-c77f-41bb-9073-c92896730096}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ProcessID",       limit: nil
    t.boolean "IsHardLink"
    t.string  "ProcessFolder",   limit: nil
    t.string  "HardProcessID",   limit: nil
  end

  add_index "dvtable_{caaa3e6d-c77f-41bb-9073-c92896730096}", ["InstanceID"], name: "dvsys_cardord_processes_section"

  create_table "dvtable_{caaa3e6d-c77f-41bb-9073-c92896730096}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ProcessID",       limit: nil
    t.boolean "IsHardLink"
    t.string  "ProcessFolder",   limit: nil
    t.string  "HardProcessID",   limit: nil
  end

  add_index "dvtable_{caaa3e6d-c77f-41bb-9073-c92896730096}_archive", ["InstanceID"], name: "dvsys_cardord_processes_archive_section"

  create_table "dvtable_{caf0ae76-5036-4cbf-ad8e-843fe8df93b8}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.boolean "IsSequential"
  end

  add_index "dvtable_{caf0ae76-5036-4cbf-ad8e-843fe8df93b8}", ["InstanceID", "ParentRowID"], name: "dvsys_cardapproval_mixedtypes_section"
  add_index "dvtable_{caf0ae76-5036-4cbf-ad8e-843fe8df93b8}", ["ParentRowID"], name: "dvsys_cardapproval_mixedtypes_idx_parentrowid"

  create_table "dvtable_{caf0ae76-5036-4cbf-ad8e-843fe8df93b8}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.boolean "IsSequential"
  end

  add_index "dvtable_{caf0ae76-5036-4cbf-ad8e-843fe8df93b8}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardapproval_mixedtypes_archive_section"
  add_index "dvtable_{caf0ae76-5036-4cbf-ad8e-843fe8df93b8}_archive", ["ParentRowID"], name: "dvsys_cardapproval_mixedtypes_archive_idx_parentrowid"

# Could not dump table "dvtable_{cafbf125-ae6c-492d-b0e4-b89f38ea3776}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{cb4dcddc-0038-4c67-b7ac-7a50e077a83f}", id: false, force: true do |t|
    t.string   "RowID",                 limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",            limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",           limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",       limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "MonitorFunction",       limit: 1024
    t.string   "ProcessID",             limit: nil
    t.datetime "LastRunDate"
    t.datetime "NextRunDate"
    t.string   "ProcessInstanceFolder", limit: nil
  end

  create_table "dvtable_{cbaf3b21-6fe4-455e-8c90-091971c762c8}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SignedByPerson",  limit: nil
  end

  add_index "dvtable_{cbaf3b21-6fe4-455e-8c90-091971c762c8}", ["InstanceID", "ParentRowID"], name: "dvsys_memorandumcard_signedbypersons_section"
  add_index "dvtable_{cbaf3b21-6fe4-455e-8c90-091971c762c8}", ["ParentRowID"], name: "dvsys_memorandumcard_signedbypersons_idx_parentrowid"

  create_table "dvtable_{cbaf3b21-6fe4-455e-8c90-091971c762c8}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SignedByPerson",  limit: nil
  end

  add_index "dvtable_{cbaf3b21-6fe4-455e-8c90-091971c762c8}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_memorandumcard_signedbypersons_archive_section"
  add_index "dvtable_{cbaf3b21-6fe4-455e-8c90-091971c762c8}_archive", ["ParentRowID"], name: "dvsys_memorandumcard_signedbypersons_archive_idx_parentrowid"

  create_table "dvtable_{cd2746f7-2dbd-4d72-8f70-3b667b9409a7}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Type",            limit: nil
    t.string   "Link",            limit: nil
    t.string   "Comments",        limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "URL",             limit: 512
    t.string   "LinkDesc",        limit: 32
    t.string   "FolderID",        limit: nil
    t.boolean  "IsParentRef"
  end

  add_index "dvtable_{cd2746f7-2dbd-4d72-8f70-3b667b9409a7}", ["InstanceID"], name: "dvsys_cardapproval_cardreferences_section"

  create_table "dvtable_{cd2746f7-2dbd-4d72-8f70-3b667b9409a7}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Type",            limit: nil
    t.string   "Link",            limit: nil
    t.string   "Comments",        limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "URL",             limit: 512
    t.string   "LinkDesc",        limit: 32
    t.string   "FolderID",        limit: nil
    t.boolean  "IsParentRef"
  end

  add_index "dvtable_{cd2746f7-2dbd-4d72-8f70-3b667b9409a7}_archive", ["InstanceID"], name: "dvsys_cardapproval_cardreferences_archive_section"

  create_table "dvtable_{cd763288-0874-468e-b774-7d00473fbc35}", id: false, force: true do |t|
    t.string  "RowID",                     limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                      limit: nil
    t.string  "FileToIncomingServiceIP",               default: "127.0.0.1"
    t.integer "FileToIncomingServicePort",             default: 1055
    t.text    "Template"
  end

  add_index "dvtable_{cd763288-0874-468e-b774-7d00473fbc35}", ["InstanceID"], name: "dvsys_refmailservicesetup_maininfo_uc_struct", unique: true

  create_table "dvtable_{ce6a58a9-b7cf-49ca-b04a-f113112b4379}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Comment",         limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
  end

  add_index "dvtable_{ce6a58a9-b7cf-49ca-b04a-f113112b4379}", ["InstanceID"], name: "dvsys_cardresolution_comments_section"

  create_table "dvtable_{ce6a58a9-b7cf-49ca-b04a-f113112b4379}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Comment",         limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
  end

  add_index "dvtable_{ce6a58a9-b7cf-49ca-b04a-f113112b4379}_archive", ["InstanceID"], name: "dvsys_cardresolution_comments_archive_section"

  create_table "dvtable_{cfdfe60a-21a8-4010-84e9-9d2df348508c}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Name",            limit: 128
    t.integer "Importance"
    t.string  "SyncTag",         limit: 256
    t.string  "Comments",        limit: 1024
    t.string  "Genitive",        limit: 128
    t.string  "Dative",          limit: 128
    t.string  "Accusative",      limit: 128
    t.string  "Instrumental",    limit: 128
    t.string  "Prepositional",   limit: 128
    t.string  "ShortName",       limit: 64
    t.string  "NameUID",         limit: nil
  end

  add_index "dvtable_{cfdfe60a-21a8-4010-84e9-9d2df348508c}", ["Name", "NameUID"], name: "dvsys_refstaff_positions_uc_global_name", unique: true

  create_table "dvtable_{d06e9f35-3b3d-4a3f-8f7a-9032dd1512fd}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ResolutionID",    limit: nil
  end

  add_index "dvtable_{d06e9f35-3b3d-4a3f-8f7a-9032dd1512fd}", ["InstanceID"], name: "dvsys_cardinc_resolutions_section"

  create_table "dvtable_{d06e9f35-3b3d-4a3f-8f7a-9032dd1512fd}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ResolutionID",    limit: nil
  end

  add_index "dvtable_{d06e9f35-3b3d-4a3f-8f7a-9032dd1512fd}_archive", ["InstanceID"], name: "dvsys_cardinc_resolutions_archive_section"

  create_table "dvtable_{d0866168-4d6c-4292-ade5-caa510d0abd7}", id: false, force: true do |t|
    t.string "RowID",                   limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",              limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                    limit: nil
    t.string "DirectionSignedByPerson", limit: nil
  end

  add_index "dvtable_{d0866168-4d6c-4292-ade5-caa510d0abd7}", ["ParentRowID"], name: "dvsys_refdocsetup_directionsingedbypersons_section"

  create_table "dvtable_{d2527f62-62b1-4f47-9d71-916c22d6994d}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ID",              limit: nil
    t.string  "Caption",         limit: 128
    t.string  "Source",          limit: nil
    t.string  "Destination",     limit: nil
    t.integer "LinkType"
    t.integer "Style"
    t.boolean "Disabled",                     default: false
    t.string  "Description",     limit: 1024
    t.string  "Points",          limit: 2048
  end

  add_index "dvtable_{d2527f62-62b1-4f47-9d71-916c22d6994d}", ["InstanceID"], name: "dvsys_process_links_section"

  create_table "dvtable_{d2527f62-62b1-4f47-9d71-916c22d6994d}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ID",              limit: nil
    t.string  "Caption",         limit: 128
    t.string  "Source",          limit: nil
    t.string  "Destination",     limit: nil
    t.integer "LinkType"
    t.integer "Style"
    t.boolean "Disabled"
    t.string  "Description",     limit: 1024
    t.string  "Points",          limit: 2048
  end

  add_index "dvtable_{d2527f62-62b1-4f47-9d71-916c22d6994d}_archive", ["InstanceID"], name: "dvsys_process_links_archive_section"

# Could not dump table "dvtable_{d25f1089-c63d-43e1-9fa4-864c48eeccb4}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{d25f1089-c63d-43e1-9fa4-864c48eeccb4}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{d344e313-749a-470f-998a-d8c0dd9c611d}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "RestrictKind",    limit: 256
    t.string "Numerator",       limit: nil
  end

  add_index "dvtable_{d344e313-749a-470f-998a-d8c0dd9c611d}", ["ParentRowID"], name: "dvsys_refdocsetup_incdocrestrictedkind_section"

  create_table "dvtable_{d4196376-3b30-4de4-a67d-afc3754db131}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "SDID",            limit: nil
    t.integer  "ID"
    t.datetime "Data"
    t.boolean  "Processed",                    default: false
    t.string   "MailTo",          limit: 1024
    t.string   "Subject",         limit: 1024
    t.text     "Body"
  end

  add_index "dvtable_{d4196376-3b30-4de4-a67d-afc3754db131}", ["InstanceID"], name: "dvsys_mailstrore_mailtable_uc_struct", unique: true

  create_table "dvtable_{d47f2c38-6553-4864-baff-0bc4d3a85290}", id: false, force: true do |t|
    t.string  "RowID",                limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Number"
    t.string  "ParentRowIDNumberUID", limit: nil
  end

  add_index "dvtable_{d47f2c38-6553-4864-baff-0bc4d3a85290}", ["InstanceID", "ParentRowID"], name: "dvsys_numeratorcard_busynumbers_section"
  add_index "dvtable_{d47f2c38-6553-4864-baff-0bc4d3a85290}", ["ParentRowID", "Number", "ParentRowIDNumberUID"], name: "dvsys_numeratorcard_busynumbers_uc_parentrowidnumber", unique: true
  add_index "dvtable_{d47f2c38-6553-4864-baff-0bc4d3a85290}", ["ParentRowID"], name: "dvsys_numeratorcard_busynumbers_idx_parentrowid"

  create_table "dvtable_{d48e6155-c774-4205-ab70-7a67ab69df22}", id: false, force: true do |t|
    t.string   "RowID",                     limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "ActualStartDate"
    t.string   "ActualStartDatePID",        limit: nil
    t.datetime "ActualEndDate"
    t.string   "ActualEndDatePID",          limit: nil
    t.integer  "TaskState"
    t.string   "TaskStatePID",              limit: nil
    t.string   "CurrentPerformer",          limit: nil
    t.string   "CurrentPerformerPID",       limit: nil
    t.integer  "PercentCompleted"
    t.string   "PercentCompletedPID",       limit: nil
    t.boolean  "ExecutionStarted"
    t.string   "ControllerShortcutID",      limit: nil
    t.string   "DelegatedTo",               limit: nil
    t.integer  "ReturnReason"
    t.integer  "ActualDuration"
    t.string   "ActualDurationPID",         limit: nil
    t.boolean  "RecreateShortcuts"
    t.string   "ReportPID",                 limit: nil
    t.boolean  "IsOverdue",                             default: false
    t.string   "TaskReferencePID",          limit: nil
    t.boolean  "CompletedByResponsible"
    t.string   "CompletedByResponsiblePID", limit: nil
    t.string   "CompletedEmployeeID",       limit: nil
    t.string   "CompletedEmployeeIDPID",    limit: nil
    t.boolean  "IsNewEndDate"
    t.boolean  "NotifyChildren"
    t.boolean  "CompletedByTaskControl"
    t.string   "CompletedByTaskControlPID", limit: nil
    t.integer  "ActualWorkDuration"
    t.string   "ActualWorkDurationPID",     limit: nil
  end

  add_index "dvtable_{d48e6155-c774-4205-ab70-7a67ab69df22}", ["InstanceID"], name: "dvsys_workflowtask_performing_uc_struct", unique: true
  add_index "dvtable_{d48e6155-c774-4205-ab70-7a67ab69df22}", ["TaskState"], name: "dvsys_workflowtask_performing_idx_taskstate"

  create_table "dvtable_{d48e6155-c774-4205-ab70-7a67ab69df22}_archive", id: false, force: true do |t|
    t.string   "RowID",                     limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "ActualStartDate"
    t.string   "ActualStartDatePID",        limit: nil
    t.datetime "ActualEndDate"
    t.string   "ActualEndDatePID",          limit: nil
    t.integer  "TaskState"
    t.string   "TaskStatePID",              limit: nil
    t.string   "CurrentPerformer",          limit: nil
    t.string   "CurrentPerformerPID",       limit: nil
    t.integer  "PercentCompleted"
    t.string   "PercentCompletedPID",       limit: nil
    t.boolean  "ExecutionStarted"
    t.string   "ControllerShortcutID",      limit: nil
    t.string   "DelegatedTo",               limit: nil
    t.integer  "ReturnReason"
    t.integer  "ActualDuration"
    t.string   "ActualDurationPID",         limit: nil
    t.boolean  "RecreateShortcuts"
    t.string   "ReportPID",                 limit: nil
    t.boolean  "IsOverdue"
    t.string   "TaskReferencePID",          limit: nil
    t.boolean  "CompletedByResponsible"
    t.string   "CompletedByResponsiblePID", limit: nil
    t.string   "CompletedEmployeeID",       limit: nil
    t.string   "CompletedEmployeeIDPID",    limit: nil
    t.boolean  "IsNewEndDate"
    t.boolean  "NotifyChildren"
    t.boolean  "CompletedByTaskControl"
    t.string   "CompletedByTaskControlPID", limit: nil
    t.integer  "ActualWorkDuration"
    t.string   "ActualWorkDurationPID",     limit: nil
  end

  add_index "dvtable_{d48e6155-c774-4205-ab70-7a67ab69df22}_archive", ["InstanceID"], name: "dvsys_workflowtask_performing_archive_uc_struct", unique: true

  create_table "dvtable_{d5e364fa-3d5d-42b0-b4a4-9e18e086d8fa}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "StageName",       limit: 256
    t.datetime "StageDate"
    t.float    "StageAmount",     limit: 24
  end

  add_index "dvtable_{d5e364fa-3d5d-42b0-b4a4-9e18e086d8fa}", ["InstanceID", "ParentRowID"], name: "dvsys_contract_stages_section"
  add_index "dvtable_{d5e364fa-3d5d-42b0-b4a4-9e18e086d8fa}", ["ParentRowID"], name: "dvsys_contract_stages_idx_parentrowid"

  create_table "dvtable_{d5e364fa-3d5d-42b0-b4a4-9e18e086d8fa}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "StageName",       limit: 256
    t.datetime "StageDate"
    t.float    "StageAmount",     limit: 24
  end

  add_index "dvtable_{d5e364fa-3d5d-42b0-b4a4-9e18e086d8fa}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_contract_stages_archive_section"
  add_index "dvtable_{d5e364fa-3d5d-42b0-b4a4-9e18e086d8fa}_archive", ["ParentRowID"], name: "dvsys_contract_stages_archive_idx_parentrowid"

  create_table "dvtable_{d5e37123-bf9a-4eaf-ba7e-de114df56cfd}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Folder",          limit: nil
    t.integer "ReportType"
    t.string  "ForEmployee",     limit: nil
    t.string  "ExportTemplate",  limit: nil
  end

  create_table "dvtable_{d766ec2a-edb4-4153-add1-3bb7bcc89d0d}", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID", limit: nil
    t.datetime "RegistrationDate"
    t.integer  "State",                            default: 1
    t.string   "Registrator",          limit: nil
    t.string   "CaseID",               limit: nil
    t.text     "Subject"
    t.string   "FileListId",           limit: nil
    t.string   "LinksListId",          limit: nil
    t.string   "Category",             limit: nil
    t.string   "BarcodeNumber",        limit: 40
    t.string   "BarcodeNumberID",      limit: nil
    t.string   "TransferLog",          limit: nil
  end

  add_index "dvtable_{d766ec2a-edb4-4153-add1-3bb7bcc89d0d}", ["InstanceID"], name: "dvsys_lna_maininfo_uc_struct", unique: true

  create_table "dvtable_{d766ec2a-edb4-4153-add1-3bb7bcc89d0d}_archive", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID", limit: nil
    t.datetime "RegistrationDate"
    t.integer  "State"
    t.string   "Registrator",          limit: nil
    t.string   "CaseID",               limit: nil
    t.text     "Subject"
    t.string   "FileListId",           limit: nil
    t.string   "LinksListId",          limit: nil
    t.string   "Category",             limit: nil
    t.string   "BarcodeNumber",        limit: 40
    t.string   "BarcodeNumberID",      limit: nil
    t.string   "TransferLog",          limit: nil
  end

  add_index "dvtable_{d766ec2a-edb4-4153-add1-3bb7bcc89d0d}_archive", ["InstanceID"], name: "dvsys_lna_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{d78d86ea-52a9-482c-94f2-1ef9fa2c7047}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Event"
    t.integer "EmployeeType"
    t.string  "Comments",        limit: 3900
    t.string  "Author",          limit: nil
    t.boolean "Disabled"
  end

  add_index "dvtable_{d78d86ea-52a9-482c-94f2-1ef9fa2c7047}", ["ParentRowID"], name: "dvsys_reftypes_notifications_section"

  create_table "dvtable_{d79e48ae-18ee-4bc8-9df0-8129c4f8840f}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "EmployeeID",      limit: nil
    t.integer "Type"
    t.boolean "IsResponsible"
    t.string  "DepartmentID",    limit: nil
    t.string  "PositionID",      limit: nil
  end

  add_index "dvtable_{d79e48ae-18ee-4bc8-9df0-8129c4f8840f}", ["InstanceID"], name: "dvsys_workflowtask_employees_section"

  create_table "dvtable_{d79e48ae-18ee-4bc8-9df0-8129c4f8840f}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "EmployeeID",      limit: nil
    t.integer "Type"
    t.boolean "IsResponsible"
    t.string  "DepartmentID",    limit: nil
    t.string  "PositionID",      limit: nil
  end

  add_index "dvtable_{d79e48ae-18ee-4bc8-9df0-8129c4f8840f}_archive", ["InstanceID"], name: "dvsys_workflowtask_employees_archive_section"

  create_table "dvtable_{d7a06820-d85c-4a1e-98ea-9fbe9c9a7b69}", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text     "CancelInfo"
    t.datetime "CancellationDate"
    t.string   "CancellationDocument", limit: nil
    t.string   "CancellationEmployee", limit: nil
  end

  add_index "dvtable_{d7a06820-d85c-4a1e-98ea-9fbe9c9a7b69}", ["InstanceID"], name: "dvsys_directioncard_cancellationinfo_section"

  create_table "dvtable_{d7a06820-d85c-4a1e-98ea-9fbe9c9a7b69}_archive", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text     "CancelInfo"
    t.datetime "CancellationDate"
    t.string   "CancellationDocument", limit: nil
    t.string   "CancellationEmployee", limit: nil
  end

  add_index "dvtable_{d7a06820-d85c-4a1e-98ea-9fbe9c9a7b69}_archive", ["InstanceID"], name: "dvsys_directioncard_cancellationinfo_archive_section"

  create_table "dvtable_{d817e75a-6eeb-4748-a49a-92617e7c07c2}", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text     "CancelInfo"
    t.datetime "Date"
    t.string   "CancellationDocument", limit: nil
    t.string   "Employee",             limit: nil
  end

  add_index "dvtable_{d817e75a-6eeb-4748-a49a-92617e7c07c2}", ["InstanceID"], name: "dvsys_lna_cancellationinfo_section"

  create_table "dvtable_{d817e75a-6eeb-4748-a49a-92617e7c07c2}_archive", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text     "CancelInfo"
    t.datetime "Date"
    t.string   "CancellationDocument", limit: nil
    t.string   "Employee",             limit: nil
  end

  add_index "dvtable_{d817e75a-6eeb-4748-a49a-92617e7c07c2}_archive", ["InstanceID"], name: "dvsys_lna_cancellationinfo_archive_section"

  create_table "dvtable_{d8b0deb3-fae7-4c06-8728-b495985183c9}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Year"
  end

  add_index "dvtable_{d8b0deb3-fae7-4c06-8728-b495985183c9}", ["InstanceID"], name: "dvsys_cardcalendar_years_section"

  create_table "dvtable_{d8b0deb3-fae7-4c06-8728-b495985183c9}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Year"
  end

  add_index "dvtable_{d8b0deb3-fae7-4c06-8728-b495985183c9}_archive", ["InstanceID"], name: "dvsys_cardcalendar_years_archive_section"

  create_table "dvtable_{d9287dde-912d-4d57-bbf8-95549ee697b0}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "PoolingInterval",             default: 15
    t.integer "KeepLogTime",                 default: 2
  end

  add_index "dvtable_{d9287dde-912d-4d57-bbf8-95549ee697b0}", ["InstanceID"], name: "dvsys_monitoringsetup_maininfo_uc_struct", unique: true

  create_table "dvtable_{d9c5b470-f1aa-4090-9d93-86d24a9c15b5}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "FileVersion",     limit: nil
    t.string "File",            limit: nil
  end

  add_index "dvtable_{d9c5b470-f1aa-4090-9d93-86d24a9c15b5}", ["ParentRowID"], name: "dvsys_reffileversions_versions_section"

  create_table "dvtable_{da4b6554-fedf-4de2-bfda-4e985e21937e}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{da4b6554-fedf-4de2-bfda-4e985e21937e}", ["InstanceID", "ParentRowID"], name: "dvsys_carduni_enumvalues_section"
  add_index "dvtable_{da4b6554-fedf-4de2-bfda-4e985e21937e}", ["ParentRowID"], name: "dvsys_carduni_enumvalues_idx_parentrowid"

  create_table "dvtable_{da4b6554-fedf-4de2-bfda-4e985e21937e}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{da4b6554-fedf-4de2-bfda-4e985e21937e}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_carduni_enumvalues_archive_section"
  add_index "dvtable_{da4b6554-fedf-4de2-bfda-4e985e21937e}_archive", ["ParentRowID"], name: "dvsys_carduni_enumvalues_archive_idx_parentrowid"

  create_table "dvtable_{da75c58d-14f7-43c5-af68-5683b8ce9dff}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "RefID",           limit: nil
    t.integer "RefType"
    t.boolean "ReadOnly"
  end

  add_index "dvtable_{da75c58d-14f7-43c5-af68-5683b8ce9dff}", ["ParentRowID"], name: "dvsys_reftypes_functionrights_section"

  create_table "dvtable_{daa76b4a-98f9-44ba-833c-dd874db33214}", id: false, force: true do |t|
    t.string   "RowID",                     limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "RegistrationDate"
    t.string   "RegistrationNumber"
    t.integer  "State",                                 default: 0
    t.string   "RegisteredBy",              limit: nil
    t.integer  "PagesCount"
    t.integer  "ItemCount"
    t.string   "SignedByCounteragent",      limit: nil
    t.string   "Responsible",               limit: nil
    t.datetime "ContractDate"
    t.float    "Amount",                    limit: 24
    t.integer  "Currency"
    t.string   "Counteragent",              limit: nil
    t.string   "ContractNumber"
    t.string   "InformationList",           limit: nil
    t.text     "Description"
    t.string   "FilesID",                   limit: nil
    t.string   "RefsID",                    limit: nil
    t.string   "RegistrationNumberID",      limit: nil
    t.string   "BarcodeNumber",             limit: 40
    t.string   "BarcodeNumberID",           limit: nil
    t.string   "TransferLog",               limit: nil
    t.string   "SignedBy",                  limit: nil
    t.datetime "ContractTerm"
    t.string   "DocKind",                   limit: nil
    t.string   "CaseID",                    limit: nil
    t.string   "LegalEntity",               limit: nil
    t.string   "ApprovalListID",            limit: nil
    t.integer  "ContractType"
    t.string   "ContractRequestAcceptedBy", limit: nil
    t.float    "AmountWithoutNDS",          limit: 24
    t.float    "CostWithoutNDS",            limit: 24
    t.float    "MaterialCost",              limit: 24
    t.integer  "PaymentDelay"
    t.float    "Percent",                   limit: 24
    t.float    "PrepaymentAmount",          limit: 24
    t.integer  "PrepaymentPeriod"
    t.boolean  "Taxable"
    t.text     "RecallComment"
    t.string   "ExecutionProcessID",        limit: nil
    t.string   "CouneragentLegal",          limit: nil
    t.float    "IncludeMaterialCost",       limit: 24
    t.integer  "MonthlyPaymentDate"
    t.float    "MonthlyPaymentNDS",         limit: 24
    t.float    "MonthlyPaymentWithoutNDS",  limit: 24
    t.boolean  "ProportionalCredit"
    t.integer  "ContractPeriodicityType"
    t.integer  "PaymentType"
    t.string   "ContractKind",              limit: nil
    t.integer  "Kind"
  end

  add_index "dvtable_{daa76b4a-98f9-44ba-833c-dd874db33214}", ["InstanceID"], name: "dvsys_contract_maininfo_uc_struct", unique: true

  create_table "dvtable_{daa76b4a-98f9-44ba-833c-dd874db33214}_archive", id: false, force: true do |t|
    t.string   "RowID",                     limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "RegistrationDate"
    t.string   "RegistrationNumber"
    t.integer  "State"
    t.string   "RegisteredBy",              limit: nil
    t.integer  "PagesCount"
    t.integer  "ItemCount"
    t.string   "SignedByCounteragent",      limit: nil
    t.string   "Responsible",               limit: nil
    t.datetime "ContractDate"
    t.float    "Amount",                    limit: 24
    t.integer  "Currency"
    t.string   "Counteragent",              limit: nil
    t.string   "ContractNumber"
    t.string   "InformationList",           limit: nil
    t.text     "Description"
    t.string   "FilesID",                   limit: nil
    t.string   "RefsID",                    limit: nil
    t.string   "RegistrationNumberID",      limit: nil
    t.string   "BarcodeNumber",             limit: 40
    t.string   "BarcodeNumberID",           limit: nil
    t.string   "TransferLog",               limit: nil
    t.string   "SignedBy",                  limit: nil
    t.datetime "ContractTerm"
    t.string   "DocKind",                   limit: nil
    t.string   "CaseID",                    limit: nil
    t.string   "LegalEntity",               limit: nil
    t.string   "ApprovalListID",            limit: nil
    t.integer  "ContractType"
    t.string   "ContractRequestAcceptedBy", limit: nil
    t.float    "AmountWithoutNDS",          limit: 24
    t.float    "CostWithoutNDS",            limit: 24
    t.float    "MaterialCost",              limit: 24
    t.integer  "PaymentDelay"
    t.float    "Percent",                   limit: 24
    t.float    "PrepaymentAmount",          limit: 24
    t.integer  "PrepaymentPeriod"
    t.boolean  "Taxable"
    t.text     "RecallComment"
    t.string   "ExecutionProcessID",        limit: nil
    t.string   "CouneragentLegal",          limit: nil
    t.float    "IncludeMaterialCost",       limit: 24
    t.integer  "MonthlyPaymentDate"
    t.float    "MonthlyPaymentNDS",         limit: 24
    t.float    "MonthlyPaymentWithoutNDS",  limit: 24
    t.boolean  "ProportionalCredit"
    t.integer  "ContractPeriodicityType"
    t.integer  "PaymentType"
    t.string   "ContractKind",              limit: nil
    t.integer  "Kind"
  end

  add_index "dvtable_{daa76b4a-98f9-44ba-833c-dd874db33214}_archive", ["InstanceID"], name: "dvsys_contract_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{db0d4513-9b62-47d5-9e1b-b242f0ba83d6}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "TemplateID",      limit: nil
  end

  add_index "dvtable_{db0d4513-9b62-47d5-9e1b-b242f0ba83d6}", ["ParentRowID"], name: "dvsys_foldertypescard_allowedtemplates_section"

  create_table "dvtable_{db94b195-2dcf-4001-b60d-33337b0c4f3e}", id: false, force: true do |t|
    t.string "RowID",                    limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",               limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",              limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                     limit: nil
    t.string "DirectionTypeRegistrator", limit: nil
  end

  add_index "dvtable_{db94b195-2dcf-4001-b60d-33337b0c4f3e}", ["ParentRowID"], name: "dvsys_refdocsetup_directiontyperegistrators_section"

  create_table "dvtable_{dbc8ae9d-c1d2-4d5e-978b-339d22b32482}", id: false, force: true do |t|
    t.string   "RowID",             limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
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
    t.integer  "RoutingType",                    default: 5
    t.string   "IDNumber",          limit: 32
    t.string   "IDIssuedBy",        limit: 256
    t.datetime "BirthDate"
    t.string   "Comments",          limit: 1024
    t.string   "CalendarID",        limit: nil
    t.integer  "Status",                         default: 0
    t.boolean  "NotAvailable",                   default: false
    t.integer  "Gender",                         default: 0
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

  add_index "dvtable_{dbc8ae9d-c1d2-4d5e-978b-339d22b32482}", ["AccountName"], name: "dvsys_refstaff_employees_idx_accountname"
  add_index "dvtable_{dbc8ae9d-c1d2-4d5e-978b-339d22b32482}", ["LastName"], name: "dvsys_refstaff_employees_idx_lastname"
  add_index "dvtable_{dbc8ae9d-c1d2-4d5e-978b-339d22b32482}", ["ParentRowID"], name: "dvsys_refstaff_employees_section"

  create_table "dvtable_{dbed195f-6235-4404-b7b2-d86148dc1180}", id: false, force: true do |t|
    t.string  "RowID",                            limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",                      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",                  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                             limit: nil
    t.string  "ContractNumerator",                limit: nil
    t.string  "ContractBPTemplate",               limit: nil
    t.string  "ContractBPStartingFolder",         limit: nil
    t.string  "ContractBPInstanceFolder",         limit: nil
    t.string  "ContractRootContractFolder",       limit: nil
    t.string  "ContractApprovingContractFolder",  limit: nil
    t.string  "ContractActiveContractFolder",     limit: nil
    t.string  "ContractArchiveContractFolder",    limit: nil
    t.integer "ContractExpiryNotifyDays"
    t.integer "ContractApproveTime"
    t.integer "ContractSignTime"
    t.integer "ContractCorrectTime"
    t.integer "ContractTaskTime"
    t.string  "ContractSigner",                   limit: nil
    t.string  "ContractSentContractFolder",       limit: nil
    t.integer "ContractSendAssignmentToExecuter"
    t.string  "ContractDocKindRef",               limit: nil
    t.string  "ContractDefaultDocKind",           limit: nil
    t.string  "ContractPrintTemplate",            limit: nil
    t.boolean "ContractNoApproving"
    t.string  "ContractDocumentType",             limit: nil
    t.string  "ContractDepartmentManager",        limit: nil
    t.string  "ContractRequestBPTemplate",        limit: nil
    t.string  "ContractRecallBPTemplate",         limit: nil
    t.string  "ContractRequestCheckerEmployee",   limit: nil
  end

  add_index "dvtable_{dbed195f-6235-4404-b7b2-d86148dc1180}", ["InstanceID"], name: "dvsys_refdocsetup_contractsetup_uc_struct", unique: true

  create_table "dvtable_{dbf3c53f-0131-4beb-a0f8-1cc8cc71c455}", id: false, force: true do |t|
    t.string  "RowID",               limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "DelegateID",          limit: nil
    t.string  "DelegateIDPID",       limit: nil
    t.integer "DelegateType"
    t.boolean "ResponseRequired"
    t.string  "ResponseRequiredPID", limit: nil
    t.boolean "CanReject"
    t.string  "CanRejectPID",        limit: nil
    t.integer "RoutingType"
    t.boolean "IsDelegated"
  end

  add_index "dvtable_{dbf3c53f-0131-4beb-a0f8-1cc8cc71c455}", ["InstanceID"], name: "dvsys_workflowtask_delegates_section"

  create_table "dvtable_{dbf3c53f-0131-4beb-a0f8-1cc8cc71c455}_archive", id: false, force: true do |t|
    t.string  "RowID",               limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "DelegateID",          limit: nil
    t.string  "DelegateIDPID",       limit: nil
    t.integer "DelegateType"
    t.boolean "ResponseRequired"
    t.string  "ResponseRequiredPID", limit: nil
    t.boolean "CanReject"
    t.string  "CanRejectPID",        limit: nil
    t.integer "RoutingType"
    t.boolean "IsDelegated"
  end

  add_index "dvtable_{dbf3c53f-0131-4beb-a0f8-1cc8cc71c455}_archive", ["InstanceID"], name: "dvsys_workflowtask_delegates_archive_section"

  create_table "dvtable_{dc0b5794-60e4-440e-adef-b049d1b816bd}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Route",           limit: nil
    t.string  "ParentCard",      limit: nil
    t.integer "DocumentType"
  end

  add_index "dvtable_{dc0b5794-60e4-440e-adef-b049d1b816bd}", ["InstanceID"], name: "dvsys_approvallist_maininfo_uc_struct", unique: true

  create_table "dvtable_{dc0b5794-60e4-440e-adef-b049d1b816bd}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Route",           limit: nil
    t.string  "ParentCard",      limit: nil
    t.integer "DocumentType"
  end

  add_index "dvtable_{dc0b5794-60e4-440e-adef-b049d1b816bd}_archive", ["InstanceID"], name: "dvsys_approvallist_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{dc47d0d9-d83e-4ab5-a6af-ca197fe1444c}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "FieldName",       limit: 128
    t.boolean "FirstLetterOnly"
  end

  add_index "dvtable_{dc47d0d9-d83e-4ab5-a6af-ca197fe1444c}", ["ParentRowID"], name: "dvsys_refstaff_depviewfields_section"

  create_table "dvtable_{dc55dca5-5d69-4fc4-90b1-c62e93a91b73}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "AddressType"
    t.string  "ZipCode",         limit: 32
    t.string  "City",            limit: 128
    t.string  "Address",         limit: 1024
    t.string  "Country",         limit: 128
  end

  add_index "dvtable_{dc55dca5-5d69-4fc4-90b1-c62e93a91b73}", ["ParentRowID"], name: "dvsys_refstaff_addresses_section"

  create_table "dvtable_{dc8a71dc-d2bb-4875-8b9f-0bbff04383f7}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Name",            limit: 256
    t.text   "Text"
    t.string "NameUID",         limit: nil
  end

  add_index "dvtable_{dc8a71dc-d2bb-4875-8b9f-0bbff04383f7}", ["Name", "ParentRowID", "NameUID"], name: "dvsys_savedsearchcard_layouts_uc_section_name", unique: true
  add_index "dvtable_{dc8a71dc-d2bb-4875-8b9f-0bbff04383f7}", ["ParentRowID"], name: "dvsys_savedsearchcard_layouts_section"

  create_table "dvtable_{dced4af6-4492-4a0b-bfa9-77fc0ad9dcd0}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Discusser",       limit: nil
    t.text   "Message"
  end

  add_index "dvtable_{dced4af6-4492-4a0b-bfa9-77fc0ad9dcd0}", ["InstanceID", "ParentRowID"], name: "dvsys_protocolcard_discussers_section"
  add_index "dvtable_{dced4af6-4492-4a0b-bfa9-77fc0ad9dcd0}", ["ParentRowID"], name: "dvsys_protocolcard_discussers_idx_parentrowid"

  create_table "dvtable_{dced4af6-4492-4a0b-bfa9-77fc0ad9dcd0}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Discusser",       limit: nil
    t.text   "Message"
  end

  add_index "dvtable_{dced4af6-4492-4a0b-bfa9-77fc0ad9dcd0}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_protocolcard_discussers_archive_section"
  add_index "dvtable_{dced4af6-4492-4a0b-bfa9-77fc0ad9dcd0}_archive", ["ParentRowID"], name: "dvsys_protocolcard_discussers_archive_idx_parentrowid"

  create_table "dvtable_{dd20bf9b-90f8-4d9a-9553-5b5f17ad724e}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.string  "Name",            limit: 1900
    t.string  "Comments",        limit: 2048
    t.boolean "NotAvailable"
    t.integer "Order"
  end

  add_index "dvtable_{dd20bf9b-90f8-4d9a-9553-5b5f17ad724e}", ["ParentRowID"], name: "dvsys_refuniversal_item_section"

  create_table "dvtable_{dd5ae8d5-eab2-4dc2-8434-1c2ebf9bbb30}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "FolderID",        limit: nil
    t.string "NumberPrefix",    limit: 32
    t.string "NumberSuffix",    limit: 32
    t.string "FolderIDUID",     limit: nil
  end

  add_index "dvtable_{dd5ae8d5-eab2-4dc2-8434-1c2ebf9bbb30}", ["FolderID", "ParentRowID", "FolderIDUID"], name: "dvsys_refnumerators_folders_uc_section_folderid", unique: true
  add_index "dvtable_{dd5ae8d5-eab2-4dc2-8434-1c2ebf9bbb30}", ["ParentRowID"], name: "dvsys_refnumerators_folders_section"

  create_table "dvtable_{ddf1c304-3967-4d36-97d2-d38f9f392489}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "PrevFunction",    limit: 128
  end

  add_index "dvtable_{ddf1c304-3967-4d36-97d2-d38f9f392489}", ["InstanceID", "ParentRowID"], name: "dvsys_process_constraints_section"
  add_index "dvtable_{ddf1c304-3967-4d36-97d2-d38f9f392489}", ["ParentRowID"], name: "dvsys_process_constraints_idx_parentrowid"

  create_table "dvtable_{ddf1c304-3967-4d36-97d2-d38f9f392489}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "PrevFunction",    limit: 128
  end

  add_index "dvtable_{ddf1c304-3967-4d36-97d2-d38f9f392489}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_process_constraints_archive_section"
  add_index "dvtable_{ddf1c304-3967-4d36-97d2-d38f9f392489}_archive", ["ParentRowID"], name: "dvsys_process_constraints_archive_idx_parentrowid"

  create_table "dvtable_{de2bdab8-ed9b-420f-a1e5-c845d5f801e7}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "TaskID",          limit: nil
    t.integer "ChildState"
  end

  add_index "dvtable_{de2bdab8-ed9b-420f-a1e5-c845d5f801e7}", ["InstanceID"], name: "dvsys_workflowtask_childrentasks_section"

  create_table "dvtable_{de2bdab8-ed9b-420f-a1e5-c845d5f801e7}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "TaskID",          limit: nil
    t.integer "ChildState"
  end

  add_index "dvtable_{de2bdab8-ed9b-420f-a1e5-c845d5f801e7}_archive", ["InstanceID"], name: "dvsys_workflowtask_childrentasks_archive_section"

  create_table "dvtable_{df069c16-e911-4c45-a6d2-a363342be4d4}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SignedByPerson",  limit: nil
  end

  add_index "dvtable_{df069c16-e911-4c45-a6d2-a363342be4d4}", ["InstanceID", "ParentRowID"], name: "dvsys_incdoc_signedbypersons_section"
  add_index "dvtable_{df069c16-e911-4c45-a6d2-a363342be4d4}", ["ParentRowID"], name: "dvsys_incdoc_signedbypersons_idx_parentrowid"

  create_table "dvtable_{df069c16-e911-4c45-a6d2-a363342be4d4}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SignedByPerson",  limit: nil
  end

  add_index "dvtable_{df069c16-e911-4c45-a6d2-a363342be4d4}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_incdoc_signedbypersons_archive_section"
  add_index "dvtable_{df069c16-e911-4c45-a6d2-a363342be4d4}_archive", ["ParentRowID"], name: "dvsys_incdoc_signedbypersons_archive_idx_parentrowid"

  create_table "dvtable_{df390b82-fff1-4c97-af12-e25a2dbdfec3}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "Order"
    t.string  "Role",            limit: nil
    t.string  "Person",          limit: nil
    t.boolean "InParallel"
    t.integer "OrderType",                   default: 1
    t.boolean "Required"
    t.boolean "DenyParallel"
  end

  add_index "dvtable_{df390b82-fff1-4c97-af12-e25a2dbdfec3}", ["ParentRowID"], name: "dvsys_refroutes_persons_section"

  create_table "dvtable_{dfb6eb87-5957-4e54-8809-cbe0ccb7f4f4}", id: false, force: true do |t|
    t.string  "RowID",                            limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",                      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",                  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                             limit: nil
    t.string  "NRDStoreFolder",                   limit: nil
    t.string  "NRDNumerator",                     limit: nil
    t.string  "NRDBPTemplate",                    limit: nil
    t.string  "NRDBPStartingFolder",              limit: nil
    t.string  "NRDBPInstanceFolder",              limit: nil
    t.string  "NRDPrintTemplate",                 limit: nil
    t.boolean "NRDAlternativeProcessCorrection"
    t.string  "NRDNotificationListPrintTemplate", limit: nil
  end

  add_index "dvtable_{dfb6eb87-5957-4e54-8809-cbe0ccb7f4f4}", ["InstanceID"], name: "dvsys_refdocsetup_nrdsetup_uc_struct", unique: true

  create_table "dvtable_{e049f370-c073-4321-afe4-4fa3c5c73c3f}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "DelegateType"
    t.string  "DelegateID",      limit: nil
    t.integer "RoutingType"
  end

  add_index "dvtable_{e049f370-c073-4321-afe4-4fa3c5c73c3f}", ["InstanceID", "ParentRowID"], name: "dvsys_cardresolution_delegates_section"
  add_index "dvtable_{e049f370-c073-4321-afe4-4fa3c5c73c3f}", ["ParentRowID"], name: "dvsys_cardresolution_delegates_idx_parentrowid"

  create_table "dvtable_{e049f370-c073-4321-afe4-4fa3c5c73c3f}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "DelegateType"
    t.string  "DelegateID",      limit: nil
    t.integer "RoutingType"
  end

  add_index "dvtable_{e049f370-c073-4321-afe4-4fa3c5c73c3f}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardresolution_delegates_archive_section"
  add_index "dvtable_{e049f370-c073-4321-afe4-4fa3c5c73c3f}_archive", ["ParentRowID"], name: "dvsys_cardresolution_delegates_archive_idx_parentrowid"

  create_table "dvtable_{e0e8a2c4-fbfc-4d15-8497-074180da08e4}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Type",            limit: nil
    t.string   "Link",            limit: nil
    t.string   "Comments",        limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "URL",             limit: 512
    t.string   "LinkDesc",        limit: 32
    t.string   "FolderID",        limit: nil
  end

  add_index "dvtable_{e0e8a2c4-fbfc-4d15-8497-074180da08e4}", ["InstanceID"], name: "dvsys_cardinc_cardreferences_section"

  create_table "dvtable_{e0e8a2c4-fbfc-4d15-8497-074180da08e4}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Type",            limit: nil
    t.string   "Link",            limit: nil
    t.string   "Comments",        limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "URL",             limit: 512
    t.string   "LinkDesc",        limit: 32
    t.string   "FolderID",        limit: nil
  end

  add_index "dvtable_{e0e8a2c4-fbfc-4d15-8497-074180da08e4}_archive", ["InstanceID"], name: "dvsys_cardinc_cardreferences_archive_section"

# Could not dump table "dvtable_{e0f66c3d-36e1-4247-bbe0-22f91ac679f4}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{e1b26a96-9cf1-46e5-85e5-e68d3a4a7c4a}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "ContractKind",    limit: 256
  end

  add_index "dvtable_{e1b26a96-9cf1-46e5-85e5-e68d3a4a7c4a}", ["ParentRowID"], name: "dvsys_refdocsetup_contractkinds_section"

  create_table "dvtable_{e1c92c90-dd3f-4ed8-aa37-35f5f2eb65d8}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text   "Data"
  end

  add_index "dvtable_{e1c92c90-dd3f-4ed8-aa37-35f5f2eb65d8}", ["InstanceID", "ParentRowID"], name: "dvsys_process_functiondata_uc_struct", unique: true
  add_index "dvtable_{e1c92c90-dd3f-4ed8-aa37-35f5f2eb65d8}", ["ParentRowID"], name: "dvsys_process_functiondata_idx_parentrowid"

  create_table "dvtable_{e1c92c90-dd3f-4ed8-aa37-35f5f2eb65d8}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text   "Data"
  end

  add_index "dvtable_{e1c92c90-dd3f-4ed8-aa37-35f5f2eb65d8}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_process_functiondata_archive_uc_struct", unique: true
  add_index "dvtable_{e1c92c90-dd3f-4ed8-aa37-35f5f2eb65d8}_archive", ["ParentRowID"], name: "dvsys_process_functiondata_archive_idx_parentrowid"

# Could not dump table "dvtable_{e1ed3a9f-e462-463c-8f63-d1bbfc7deded}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{e1ed3a9f-e462-463c-8f63-d1bbfc7deded}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{e1efdb5e-c2ab-4950-820a-4f0c0e301e0f}", id: false, force: true do |t|
    t.string "RowID",                limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                 limit: nil
    t.string "OutDocSignedByPerson", limit: nil
  end

  add_index "dvtable_{e1efdb5e-c2ab-4950-820a-4f0c0e301e0f}", ["ParentRowID"], name: "dvsys_refdocsetup_outdocsingedbypersons_section"

# Could not dump table "dvtable_{e2f812cf-fe7b-4ae7-acf0-fc8f2989cdba}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{e3335f61-dbd9-447b-a539-4bf721ffd7b0}", id: false, force: true do |t|
    t.string   "RowID",                     limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",               limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",           limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID",      limit: nil
    t.string   "Subject",                   limit: 1024
    t.integer  "State",                                  default: 1
    t.string   "Author",                    limit: nil
    t.datetime "Deadline"
    t.string   "Registrator",               limit: nil
    t.datetime "RegistrationDate"
    t.string   "AssigneeID",                limit: nil
    t.text     "Content"
    t.boolean  "ForAcquaintance"
    t.string   "FileListId",                limit: nil
    t.boolean  "SpecialControl"
    t.string   "ProcessID",                 limit: nil
    t.string   "AssigneeTaskId",            limit: nil
    t.string   "TaskKind",                  limit: 256
    t.text     "RawContent"
    t.text     "HTMLContent"
    t.string   "_ParentCard",               limit: nil
    t.integer  "AssigneeCompletionVariant"
    t.string   "ParentTaskID",              limit: nil
    t.string   "TaskUIClass",               limit: nil
    t.integer  "Type"
    t.string   "TaskKindID",                limit: nil
    t.integer  "Version"
    t.string   "LegacySystemID",            limit: 256
    t.string   "Controller",                limit: nil
    t.string   "BarcodeNumber",             limit: 40
    t.string   "BarcodeNumberID",           limit: nil
    t.string   "TransferLog",               limit: nil
    t.string   "RefsID",                    limit: nil
    t.boolean  "OnlyPrivateAccess",                      default: false
    t.boolean  "AccessToAllManagement"
    t.boolean  "IsCoperformerMode"
    t.string   "ReassignedFrom",            limit: nil
  end

  add_index "dvtable_{e3335f61-dbd9-447b-a539-4bf721ffd7b0}", ["InstanceID"], name: "dvsys_assignment_maininfo_uc_struct", unique: true

  create_table "dvtable_{e3335f61-dbd9-447b-a539-4bf721ffd7b0}_archive", id: false, force: true do |t|
    t.string   "RowID",                     limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",               limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",           limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID",      limit: nil
    t.string   "Subject",                   limit: 1024
    t.integer  "State"
    t.string   "Author",                    limit: nil
    t.datetime "Deadline"
    t.string   "Registrator",               limit: nil
    t.datetime "RegistrationDate"
    t.string   "AssigneeID",                limit: nil
    t.text     "Content"
    t.boolean  "ForAcquaintance"
    t.string   "FileListId",                limit: nil
    t.boolean  "SpecialControl"
    t.string   "ProcessID",                 limit: nil
    t.string   "AssigneeTaskId",            limit: nil
    t.string   "TaskKind",                  limit: 256
    t.text     "RawContent"
    t.text     "HTMLContent"
    t.string   "_ParentCard",               limit: nil
    t.integer  "AssigneeCompletionVariant"
    t.string   "ParentTaskID",              limit: nil
    t.string   "TaskUIClass",               limit: nil
    t.integer  "Type"
    t.string   "TaskKindID",                limit: nil
    t.integer  "Version"
    t.string   "LegacySystemID",            limit: 256
    t.string   "Controller",                limit: nil
    t.string   "BarcodeNumber",             limit: 40
    t.string   "BarcodeNumberID",           limit: nil
    t.string   "TransferLog",               limit: nil
    t.string   "RefsID",                    limit: nil
    t.boolean  "OnlyPrivateAccess"
    t.boolean  "AccessToAllManagement"
    t.boolean  "IsCoperformerMode"
    t.string   "ReassignedFrom",            limit: nil
  end

  add_index "dvtable_{e3335f61-dbd9-447b-a539-4bf721ffd7b0}_archive", ["InstanceID"], name: "dvsys_assignment_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{e3e782cd-8b0e-43c8-bb79-aacf043c1502}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "HistoryKind"
    t.string   "Person",          limit: nil
    t.text     "Comments"
    t.datetime "Date"
    t.string   "TaskID",          limit: nil
  end

  add_index "dvtable_{e3e782cd-8b0e-43c8-bb79-aacf043c1502}", ["InstanceID"], name: "dvsys_ordercard_approvalhistory_section"

  create_table "dvtable_{e3e782cd-8b0e-43c8-bb79-aacf043c1502}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "HistoryKind"
    t.string   "Person",          limit: nil
    t.text     "Comments"
    t.datetime "Date"
    t.string   "TaskID",          limit: nil
  end

  add_index "dvtable_{e3e782cd-8b0e-43c8-bb79-aacf043c1502}_archive", ["InstanceID"], name: "dvsys_ordercard_approvalhistory_archive_section"

  create_table "dvtable_{e46d10a3-4ddc-40a8-b32f-9c3216b69708}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "Name",            limit: 32
    t.string "File",            limit: nil
    t.string "NameUID",         limit: nil
  end

  add_index "dvtable_{e46d10a3-4ddc-40a8-b32f-9c3216b69708}", ["Name", "NameUID"], name: "dvsys_navigatorcard_templates_uc_card_name", unique: true

  create_table "dvtable_{e46db878-6f27-474b-a611-86edb45a23fb}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "FieldName",       limit: 128
    t.boolean "FirstLetterOnly"
  end

  create_table "dvtable_{e56c3f68-41a2-4d1e-be86-6698a720cb50}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "EditAssignee",    limit: nil
  end

  add_index "dvtable_{e56c3f68-41a2-4d1e-be86-6698a720cb50}", ["InstanceID", "ParentRowID"], name: "dvsys_directivecard_editassignees_section"
  add_index "dvtable_{e56c3f68-41a2-4d1e-be86-6698a720cb50}", ["ParentRowID"], name: "dvsys_directivecard_editassignees_idx_parentrowid"

  create_table "dvtable_{e56c3f68-41a2-4d1e-be86-6698a720cb50}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "EditAssignee",    limit: nil
  end

  add_index "dvtable_{e56c3f68-41a2-4d1e-be86-6698a720cb50}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_directivecard_editassignees_archive_section"
  add_index "dvtable_{e56c3f68-41a2-4d1e-be86-6698a720cb50}_archive", ["ParentRowID"], name: "dvsys_directivecard_editassignees_archive_idx_parentrowid"

  create_table "dvtable_{e64f0e9b-7a53-460e-972b-b16ab601240e}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "VarID",           limit: nil
    t.string "VarName",         limit: 128
  end

  add_index "dvtable_{e64f0e9b-7a53-460e-972b-b16ab601240e}", ["InstanceID"], name: "dvsys_workflowtask_variableshistory_section"

  create_table "dvtable_{e64f0e9b-7a53-460e-972b-b16ab601240e}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "VarID",           limit: nil
    t.string "VarName",         limit: 128
  end

  add_index "dvtable_{e64f0e9b-7a53-460e-972b-b16ab601240e}_archive", ["InstanceID"], name: "dvsys_workflowtask_variableshistory_archive_section"

  create_table "dvtable_{e657d465-0462-4220-a773-5c2b04b289d7}", id: false, force: true do |t|
    t.string "RowID",               limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                limit: nil
    t.string "OrderSignedByPerson", limit: nil
  end

  add_index "dvtable_{e657d465-0462-4220-a773-5c2b04b289d7}", ["ParentRowID"], name: "dvsys_refdocsetup_ordersingedbypersons_section"

  create_table "dvtable_{e6987aba-e8f6-4399-8976-7f1ee3c711f0}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "RestrictKind",    limit: 256
    t.string "Numerator",       limit: nil
  end

  add_index "dvtable_{e6987aba-e8f6-4399-8976-7f1ee3c711f0}", ["ParentRowID"], name: "dvsys_refdocsetup_memorandumrestrictedkind_section"

  create_table "dvtable_{e6e8b0b6-141d-45fe-a499-377e537a2919}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "EditAssignee",    limit: nil
  end

  add_index "dvtable_{e6e8b0b6-141d-45fe-a499-377e537a2919}", ["InstanceID", "ParentRowID"], name: "dvsys_directioncard_editassignees_section"
  add_index "dvtable_{e6e8b0b6-141d-45fe-a499-377e537a2919}", ["ParentRowID"], name: "dvsys_directioncard_editassignees_idx_parentrowid"

  create_table "dvtable_{e6e8b0b6-141d-45fe-a499-377e537a2919}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "EditAssignee",    limit: nil
  end

  add_index "dvtable_{e6e8b0b6-141d-45fe-a499-377e537a2919}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_directioncard_editassignees_archive_section"
  add_index "dvtable_{e6e8b0b6-141d-45fe-a499-377e537a2919}_archive", ["ParentRowID"], name: "dvsys_directioncard_editassignees_archive_idx_parentrowid"

# Could not dump table "dvtable_{e6f5105f-8bd8-4500-9780-60d7c1402ddb}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{e6f5105f-8bd8-4500-9780-60d7c1402ddb}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{e7192f4f-d9c6-46d9-b133-5f02b825caba}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "NameCase"
    t.string  "FirstName",       limit: 32
    t.string  "MiddleName",      limit: 32
    t.string  "LastName",        limit: 32
  end

  add_index "dvtable_{e7192f4f-d9c6-46d9-b133-5f02b825caba}", ["ParentRowID"], name: "dvsys_refpartners_namecases_section"

  create_table "dvtable_{e722eee5-64c3-4832-8c32-60bbe53e0a64}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.binary  "Picture"
    t.integer "ImageFormat"
  end

  add_index "dvtable_{e722eee5-64c3-4832-8c32-60bbe53e0a64}", ["ParentRowID"], name: "dvsys_refstaff_pictures_section"

  create_table "dvtable_{e74e5cc1-d8a8-4bb5-80e4-98bef20549e2}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "CreatedBy",       limit: nil
    t.datetime "CreationDate"
    t.string   "Subject",         limit: 800
    t.text     "Body"
    t.string   "CardID",          limit: nil
  end

  add_index "dvtable_{e74e5cc1-d8a8-4bb5-80e4-98bef20549e2}", ["InstanceID"], name: "dvsys_cardmessage_maininfo_uc_struct", unique: true

  create_table "dvtable_{e74e5cc1-d8a8-4bb5-80e4-98bef20549e2}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "CreatedBy",       limit: nil
    t.datetime "CreationDate"
    t.string   "Subject",         limit: 800
    t.text     "Body"
    t.string   "CardID",          limit: nil
  end

  add_index "dvtable_{e74e5cc1-d8a8-4bb5-80e4-98bef20549e2}_archive", ["InstanceID"], name: "dvsys_cardmessage_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{e79a6914-9a7a-467c-93cb-5a2f30bb5c52}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "HistoryKind"
    t.string   "Person",          limit: nil
    t.text     "Comments"
    t.datetime "Date"
    t.string   "Task",            limit: nil
  end

  add_index "dvtable_{e79a6914-9a7a-467c-93cb-5a2f30bb5c52}", ["InstanceID"], name: "dvsys_contract_approvalhistory_section"

  create_table "dvtable_{e79a6914-9a7a-467c-93cb-5a2f30bb5c52}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "HistoryKind"
    t.string   "Person",          limit: nil
    t.text     "Comments"
    t.datetime "Date"
    t.string   "Task",            limit: nil
  end

  add_index "dvtable_{e79a6914-9a7a-467c-93cb-5a2f30bb5c52}_archive", ["InstanceID"], name: "dvsys_contract_approvalhistory_archive_section"

  create_table "dvtable_{e8c65d7f-19be-46e0-9231-603fdbe9d281}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "FieldName",       limit: 128
    t.boolean "FirstLetterOnly"
    t.string  "Prefix",          limit: 16
    t.string  "Suffix",          limit: 16
    t.boolean "IsProperty"
  end

  add_index "dvtable_{e8c65d7f-19be-46e0-9231-603fdbe9d281}", ["ParentRowID"], name: "dvsys_reftypes_digestformat_section"

  create_table "dvtable_{e95f03c1-bbdb-429a-8056-925fce92112c}", id: false, force: true do |t|
    t.string  "RowID",                                 limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",                           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",                       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                                  limit: nil
    t.string  "UniversalBPTemplate",                   limit: nil
    t.string  "UniversalBPStartingFolder",             limit: nil
    t.string  "UniversalBPInstanceFolder",             limit: nil
    t.integer "UniversalApprovalDuration"
    t.integer "UniversalCorrectionDuration"
    t.integer "UniversalSignedDuration"
    t.string  "UniversalApprovalFolder",               limit: nil
    t.boolean "UniversalAlternativeProcessCorrection"
  end

  add_index "dvtable_{e95f03c1-bbdb-429a-8056-925fce92112c}", ["InstanceID"], name: "dvsys_refdocsetup_universalapprovalsetup_uc_struct", unique: true

  create_table "dvtable_{e962ac85-0f53-4439-a1cd-171e46c3ef91}", id: false, force: true do |t|
    t.string  "RowID",            limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "CardFileID",       limit: nil
    t.boolean "CanModify"
    t.boolean "CanCheckout"
    t.boolean "CanDelete"
    t.boolean "CommentRequired"
    t.string  "ResultFolder",     limit: nil
    t.boolean "FieldsToFile"
    t.boolean "FileToFields"
    t.boolean "IsNew"
    t.boolean "IsDeleted"
    t.boolean "OpenFileWithCard"
    t.string  "CardFileIDUID",    limit: nil
  end

  add_index "dvtable_{e962ac85-0f53-4439-a1cd-171e46c3ef91}", ["CardFileID", "InstanceID", "CardFileIDUID"], name: "dvsys_filelist_filereferences_uc_card_cardfileid", unique: true
  add_index "dvtable_{e962ac85-0f53-4439-a1cd-171e46c3ef91}", ["InstanceID"], name: "dvsys_filelist_filereferences_section"

  create_table "dvtable_{e962ac85-0f53-4439-a1cd-171e46c3ef91}_archive", id: false, force: true do |t|
    t.string  "RowID",            limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "CardFileID",       limit: nil
    t.boolean "CanModify"
    t.boolean "CanCheckout"
    t.boolean "CanDelete"
    t.boolean "CommentRequired"
    t.string  "ResultFolder",     limit: nil
    t.boolean "FieldsToFile"
    t.boolean "FileToFields"
    t.boolean "IsNew"
    t.boolean "IsDeleted"
    t.boolean "OpenFileWithCard"
    t.string  "CardFileIDUID",    limit: nil
  end

  add_index "dvtable_{e962ac85-0f53-4439-a1cd-171e46c3ef91}_archive", ["InstanceID"], name: "dvsys_filelist_filereferences_archive_section"

  create_table "dvtable_{ea400589-1f30-4f23-a325-d0df9e38b2bd}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ApproverRowID",   limit: nil
    t.string "FileRowID",       limit: nil
  end

  add_index "dvtable_{ea400589-1f30-4f23-a325-d0df9e38b2bd}", ["InstanceID", "ParentRowID"], name: "dvsys_cardapproval_viewrights_section"
  add_index "dvtable_{ea400589-1f30-4f23-a325-d0df9e38b2bd}", ["ParentRowID"], name: "dvsys_cardapproval_viewrights_idx_parentrowid"

  create_table "dvtable_{ea400589-1f30-4f23-a325-d0df9e38b2bd}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ApproverRowID",   limit: nil
    t.string "FileRowID",       limit: nil
  end

  add_index "dvtable_{ea400589-1f30-4f23-a325-d0df9e38b2bd}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardapproval_viewrights_archive_section"
  add_index "dvtable_{ea400589-1f30-4f23-a325-d0df9e38b2bd}_archive", ["ParentRowID"], name: "dvsys_cardapproval_viewrights_archive_idx_parentrowid"

  create_table "dvtable_{eb1d77dd-45bd-4a5e-82a7-a0e3b1eb1d74}", id: false, force: true do |t|
    t.string   "RowID",            limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "CardID",           limit: nil
    t.string   "HardCardID",       limit: nil
    t.string   "Mode",             limit: nil
    t.string   "Description",      limit: 512
    t.boolean  "Deleted"
    t.boolean  "Recalled"
    t.datetime "CreationDateTime"
    t.string   "HardCardIDUID",    limit: nil
  end

  add_index "dvtable_{eb1d77dd-45bd-4a5e-82a7-a0e3b1eb1d74}", ["HardCardID", "HardCardIDUID"], name: "dvsys_folderscard_shortcuts_uc_global_hardcardid", unique: true
  add_index "dvtable_{eb1d77dd-45bd-4a5e-82a7-a0e3b1eb1d74}", ["ParentRowID"], name: "dvsys_folderscard_shortcuts_section"

  create_table "dvtable_{eb5248c1-8a10-4a2a-91fa-ed5e8481b0da}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "TypeID",          limit: nil
    t.string "TypeIDUID",       limit: nil
  end

  add_index "dvtable_{eb5248c1-8a10-4a2a-91fa-ed5e8481b0da}", ["TypeID", "TypeIDUID"], name: "dvsys_savedviewcard_sections_uc_card_typeid", unique: true

# Could not dump table "dvtable_{ebaf1de7-ab00-44d4-82ac-2cf3c16c93dc}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{ebec7701-ed7b-4307-ae4d-9c6eaa30382d}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "EditAssignee",    limit: nil
  end

  add_index "dvtable_{ebec7701-ed7b-4307-ae4d-9c6eaa30382d}", ["InstanceID", "ParentRowID"], name: "dvsys_nrdcard_editassignees_section"
  add_index "dvtable_{ebec7701-ed7b-4307-ae4d-9c6eaa30382d}", ["ParentRowID"], name: "dvsys_nrdcard_editassignees_idx_parentrowid"

  create_table "dvtable_{ebec7701-ed7b-4307-ae4d-9c6eaa30382d}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "EditAssignee",    limit: nil
  end

  add_index "dvtable_{ebec7701-ed7b-4307-ae4d-9c6eaa30382d}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_nrdcard_editassignees_archive_section"
  add_index "dvtable_{ebec7701-ed7b-4307-ae4d-9c6eaa30382d}_archive", ["ParentRowID"], name: "dvsys_nrdcard_editassignees_archive_idx_parentrowid"

  create_table "dvtable_{ec83f06e-8131-4437-a573-c86b15a2af5c}", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID", limit: nil
    t.datetime "RegistrationDate"
    t.datetime "ExpiryDate"
    t.datetime "EarlyCancelDate"
    t.string   "Registrator",          limit: nil
    t.string   "Curator",              limit: nil
    t.string   "SignedBy",             limit: nil
    t.integer  "State",                            default: 1
    t.text     "GrantedPower"
    t.string   "Representative",       limit: nil
    t.string   "FileListId",           limit: nil
    t.string   "CaseID",               limit: nil
    t.string   "LinksListId",          limit: nil
    t.string   "ProcessID",            limit: nil
    t.datetime "TakingDate"
    t.datetime "ReturningDate"
    t.text     "Note"
    t.string   "CancelProcessID",      limit: nil
    t.boolean  "PreNotificationSent",              default: false
    t.string   "LegacySystemID",       limit: 256
    t.string   "BarcodeNumber",        limit: 40
    t.string   "BarcodeNumberID",      limit: nil
    t.string   "TransferLog",          limit: nil
  end

  add_index "dvtable_{ec83f06e-8131-4437-a573-c86b15a2af5c}", ["InstanceID"], name: "dvsys_warrantcard_maininfo_uc_struct", unique: true

  create_table "dvtable_{ec83f06e-8131-4437-a573-c86b15a2af5c}_archive", id: false, force: true do |t|
    t.string   "RowID",                limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID", limit: nil
    t.datetime "RegistrationDate"
    t.datetime "ExpiryDate"
    t.datetime "EarlyCancelDate"
    t.string   "Registrator",          limit: nil
    t.string   "Curator",              limit: nil
    t.string   "SignedBy",             limit: nil
    t.integer  "State"
    t.text     "GrantedPower"
    t.string   "Representative",       limit: nil
    t.string   "FileListId",           limit: nil
    t.string   "CaseID",               limit: nil
    t.string   "LinksListId",          limit: nil
    t.string   "ProcessID",            limit: nil
    t.datetime "TakingDate"
    t.datetime "ReturningDate"
    t.text     "Note"
    t.string   "CancelProcessID",      limit: nil
    t.boolean  "PreNotificationSent"
    t.string   "LegacySystemID",       limit: 256
    t.string   "BarcodeNumber",        limit: 40
    t.string   "BarcodeNumberID",      limit: nil
    t.string   "TransferLog",          limit: nil
  end

  add_index "dvtable_{ec83f06e-8131-4437-a573-c86b15a2af5c}_archive", ["InstanceID"], name: "dvsys_warrantcard_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{eca400d1-6710-42d4-9aa4-6b906d37fc3e}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                   null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Source",          limit: 128
    t.string "Value",           limit: 2048
  end

  add_index "dvtable_{eca400d1-6710-42d4-9aa4-6b906d37fc3e}", ["InstanceID", "ParentRowID"], name: "dvsys_process_monitoringhistory_section"
  add_index "dvtable_{eca400d1-6710-42d4-9aa4-6b906d37fc3e}", ["ParentRowID"], name: "dvsys_process_monitoringhistory_idx_parentrowid"

  create_table "dvtable_{eca400d1-6710-42d4-9aa4-6b906d37fc3e}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                   null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Source",          limit: 128
    t.string "Value",           limit: 2048
  end

  add_index "dvtable_{eca400d1-6710-42d4-9aa4-6b906d37fc3e}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_process_monitoringhistory_archive_section"
  add_index "dvtable_{eca400d1-6710-42d4-9aa4-6b906d37fc3e}_archive", ["ParentRowID"], name: "dvsys_process_monitoringhistory_archive_idx_parentrowid"

  create_table "dvtable_{eca843ef-2810-4795-a81a-b047f76250ec}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "RefType"
    t.string  "RefID",           limit: nil
    t.string  "RefURL",          limit: 4000
    t.boolean "ReadOnly"
    t.string  "Comment",         limit: 2048
    t.string  "RefRowID",        limit: nil
    t.string  "ModeID",          limit: nil
    t.integer "Rights"
    t.boolean "CommentRequired"
    t.boolean "OpenImmediately"
    t.string  "RefCardID",       limit: nil
    t.string  "RefFolderID",     limit: nil
  end

  add_index "dvtable_{eca843ef-2810-4795-a81a-b047f76250ec}", ["InstanceID"], name: "dvsys_workflowtask_cardreferences2_section"

  create_table "dvtable_{eca843ef-2810-4795-a81a-b047f76250ec}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "RefType"
    t.string  "RefID",           limit: nil
    t.string  "RefURL",          limit: 4000
    t.boolean "ReadOnly"
    t.string  "Comment",         limit: 2048
    t.string  "RefRowID",        limit: nil
    t.string  "ModeID",          limit: nil
    t.integer "Rights"
    t.boolean "CommentRequired"
    t.boolean "OpenImmediately"
    t.string  "RefCardID",       limit: nil
    t.string  "RefFolderID",     limit: nil
  end

  add_index "dvtable_{eca843ef-2810-4795-a81a-b047f76250ec}_archive", ["InstanceID"], name: "dvsys_workflowtask_cardreferences2_archive_section"

# Could not dump table "dvtable_{ecd7a672-22e3-4748-9962-00fc0fe2abbc}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{ecd7a672-22e3-4748-9962-00fc0fe2abbc}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{ecee1974-a2ed-47a5-8d73-243c7710ebe6}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{ed414cb4-b205-4be4-a2fa-5c0d3347ceb3}", id: false, force: true do |t|
    t.string  "RowID",            limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "DeputyID",         limit: nil
    t.string  "SyncTag",          limit: 256
    t.boolean "Performing",                   default: true
    t.boolean "Control"
    t.boolean "Signature"
    t.string  "SignatureComment", limit: 128
    t.boolean "PermanentDeputy"
    t.boolean "DeputyAccess"
    t.string  "DeputyIDUID",      limit: nil
  end

  add_index "dvtable_{ed414cb4-b205-4be4-a2fa-5c0d3347ceb3}", ["DeputyID", "ParentRowID", "DeputyIDUID"], name: "dvsys_refstaff_deputies_uc_section_deputyid", unique: true
  add_index "dvtable_{ed414cb4-b205-4be4-a2fa-5c0d3347ceb3}", ["ParentRowID"], name: "dvsys_refstaff_deputies_section"

  create_table "dvtable_{edb2258a-20c2-412e-bcbd-f28028855e84}", id: false, force: true do |t|
    t.string   "RowID",               limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "ApprovalHistoryKind"
    t.string   "ApprovalPerson",      limit: nil
    t.text     "ApprovalComments"
    t.datetime "ApprovalDate"
    t.string   "ApprovalTaskID",      limit: nil
  end

  add_index "dvtable_{edb2258a-20c2-412e-bcbd-f28028855e84}", ["InstanceID"], name: "dvsys_directivecard_approvalhistory_section"

  create_table "dvtable_{edb2258a-20c2-412e-bcbd-f28028855e84}_archive", id: false, force: true do |t|
    t.string   "RowID",               limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "ApprovalHistoryKind"
    t.string   "ApprovalPerson",      limit: nil
    t.text     "ApprovalComments"
    t.datetime "ApprovalDate"
    t.string   "ApprovalTaskID",      limit: nil
  end

  add_index "dvtable_{edb2258a-20c2-412e-bcbd-f28028855e84}_archive", ["InstanceID"], name: "dvsys_directivecard_approvalhistory_archive_section"

  create_table "dvtable_{ee1ae0b3-e9ad-42b1-bf7b-b01e74208be9}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{ee1ae0b3-e9ad-42b1-bf7b-b01e74208be9}", ["CategoryID", "InstanceID", "CategoryIDUID"], name: "dvsys_cardinc_categories_uc_card_categoryid", unique: true
  add_index "dvtable_{ee1ae0b3-e9ad-42b1-bf7b-b01e74208be9}", ["InstanceID"], name: "dvsys_cardinc_categories_section"

  create_table "dvtable_{ee1ae0b3-e9ad-42b1-bf7b-b01e74208be9}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "CategoryID",      limit: nil
    t.string "CategoryIDUID",   limit: nil
  end

  add_index "dvtable_{ee1ae0b3-e9ad-42b1-bf7b-b01e74208be9}_archive", ["InstanceID"], name: "dvsys_cardinc_categories_archive_section"

  create_table "dvtable_{ee35d1f5-4954-4e8f-ba23-d6930485da05}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text     "Comment"
    t.string   "AuthorID",        limit: nil
    t.datetime "Date"
  end

  add_index "dvtable_{ee35d1f5-4954-4e8f-ba23-d6930485da05}", ["InstanceID", "ParentRowID"], name: "dvsys_versionedfilecard_versioncomments_section"
  add_index "dvtable_{ee35d1f5-4954-4e8f-ba23-d6930485da05}", ["ParentRowID"], name: "dvsys_versionedfilecard_versioncomments_idx_parentrowid"

  create_table "dvtable_{ee35d1f5-4954-4e8f-ba23-d6930485da05}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text     "Comment"
    t.string   "AuthorID",        limit: nil
    t.datetime "Date"
  end

  add_index "dvtable_{ee35d1f5-4954-4e8f-ba23-d6930485da05}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_versionedfilecard_versioncomments_archive_section"
  add_index "dvtable_{ee35d1f5-4954-4e8f-ba23-d6930485da05}_archive", ["ParentRowID"], name: "dvsys_versionedfilecard_versioncomments_archive_idx_parentrowid"

  create_table "dvtable_{ef171a90-d5e5-4951-be31-c603ba94ab5e}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "Field1"
  end

  add_index "dvtable_{ef171a90-d5e5-4951-be31-c603ba94ab5e}", ["InstanceID"], name: "dvsys_navextcreateassignmentbtn_section1_uc_struct", unique: true

  create_table "dvtable_{ef30744a-7a2c-4adc-b275-28ff3c57e754}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Type",            limit: nil
    t.string   "Link",            limit: nil
    t.string   "Comments",        limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "URL",             limit: 512
    t.string   "LinkDesc",        limit: 32
    t.string   "FolderID",        limit: nil
  end

  add_index "dvtable_{ef30744a-7a2c-4adc-b275-28ff3c57e754}", ["InstanceID"], name: "dvsys_carduni_cardreferences_section"

  create_table "dvtable_{ef30744a-7a2c-4adc-b275-28ff3c57e754}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Type",            limit: nil
    t.string   "Link",            limit: nil
    t.string   "Comments",        limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "URL",             limit: 512
    t.string   "LinkDesc",        limit: 32
    t.string   "FolderID",        limit: nil
  end

  add_index "dvtable_{ef30744a-7a2c-4adc-b275-28ff3c57e754}_archive", ["InstanceID"], name: "dvsys_carduni_cardreferences_archive_section"

# Could not dump table "dvtable_{f031ffba-63a8-44ab-a1ac-0a62fdaf939e}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{f031ffba-63a8-44ab-a1ac-0a62fdaf939e}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{f05df61e-2d5e-480f-84eb-a4549f169553}", id: false, force: true do |t|
    t.string "RowID",               limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                limit: nil
    t.string "DirectionTypeSigner", limit: nil
  end

  add_index "dvtable_{f05df61e-2d5e-480f-84eb-a4549f169553}", ["ParentRowID"], name: "dvsys_refdocsetup_directiontypesigners_section"

# Could not dump table "dvtable_{f05ee772-0adc-400e-8403-0e4efb87678e}" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "dvtable_{f05ee772-0adc-400e-8403-0e4efb87678e}_archive" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dvtable_{f06a18e7-582e-4896-9c0c-146025e6d9da}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ApprovalID",      limit: nil
  end

  add_index "dvtable_{f06a18e7-582e-4896-9c0c-146025e6d9da}", ["InstanceID"], name: "dvsys_cardinc_approvals_section"

  create_table "dvtable_{f06a18e7-582e-4896-9c0c-146025e6d9da}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ApprovalID",      limit: nil
  end

  add_index "dvtable_{f06a18e7-582e-4896-9c0c-146025e6d9da}_archive", ["InstanceID"], name: "dvsys_cardinc_approvals_archive_section"

  create_table "dvtable_{f0dc8edd-1f37-4b6a-abf3-bd527808b304}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Department"
    t.string   "Approver",        limit: nil
    t.datetime "StartDate"
    t.datetime "ApprovingDate"
    t.integer  "Decision"
    t.integer  "Order"
    t.string   "Officer",         limit: nil
    t.integer  "ApprovingTime"
    t.text     "Comment"
    t.boolean  "IsFromTemplate"
  end

  add_index "dvtable_{f0dc8edd-1f37-4b6a-abf3-bd527808b304}", ["InstanceID", "ParentRowID"], name: "dvsys_ordercard_approvals_section"
  add_index "dvtable_{f0dc8edd-1f37-4b6a-abf3-bd527808b304}", ["ParentRowID"], name: "dvsys_ordercard_approvals_idx_parentrowid"

  create_table "dvtable_{f0dc8edd-1f37-4b6a-abf3-bd527808b304}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Department"
    t.string   "Approver",        limit: nil
    t.datetime "StartDate"
    t.datetime "ApprovingDate"
    t.integer  "Decision"
    t.integer  "Order"
    t.string   "Officer",         limit: nil
    t.integer  "ApprovingTime"
    t.text     "Comment"
    t.boolean  "IsFromTemplate"
  end

  add_index "dvtable_{f0dc8edd-1f37-4b6a-abf3-bd527808b304}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_ordercard_approvals_archive_section"
  add_index "dvtable_{f0dc8edd-1f37-4b6a-abf3-bd527808b304}_archive", ["ParentRowID"], name: "dvsys_ordercard_approvals_archive_idx_parentrowid"

  create_table "dvtable_{f12c1136-b351-4037-9dc9-21c042a238af}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "DayNumber"
    t.integer "Type"
  end

  add_index "dvtable_{f12c1136-b351-4037-9dc9-21c042a238af}", ["InstanceID", "ParentRowID"], name: "dvsys_cardcalendar_days_section"
  add_index "dvtable_{f12c1136-b351-4037-9dc9-21c042a238af}", ["ParentRowID"], name: "dvsys_cardcalendar_days_idx_parentrowid"

  create_table "dvtable_{f12c1136-b351-4037-9dc9-21c042a238af}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "DayNumber"
    t.integer "Type"
  end

  add_index "dvtable_{f12c1136-b351-4037-9dc9-21c042a238af}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardcalendar_days_archive_section"
  add_index "dvtable_{f12c1136-b351-4037-9dc9-21c042a238af}_archive", ["ParentRowID"], name: "dvsys_cardcalendar_days_archive_idx_parentrowid"

  create_table "dvtable_{f34ade10-7932-4767-bd03-67f164a45de5}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Type",            limit: nil
    t.string   "Link",            limit: nil
    t.string   "Comments",        limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "URL",             limit: 512
    t.string   "LinkDesc",        limit: 256
    t.string   "FolderID",        limit: nil
    t.integer  "ShowMode",                     default: 1
  end

  add_index "dvtable_{f34ade10-7932-4767-bd03-67f164a45de5}", ["InstanceID"], name: "dvsys_referencelist_references_section"

  create_table "dvtable_{f34ade10-7932-4767-bd03-67f164a45de5}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Type",            limit: nil
    t.string   "Link",            limit: nil
    t.string   "Comments",        limit: 2048
    t.datetime "CreationDate"
    t.string   "CreatedBy",       limit: nil
    t.string   "URL",             limit: 512
    t.string   "LinkDesc",        limit: 256
    t.string   "FolderID",        limit: nil
    t.integer  "ShowMode"
  end

  add_index "dvtable_{f34ade10-7932-4767-bd03-67f164a45de5}_archive", ["InstanceID"], name: "dvsys_referencelist_references_archive_section"

  create_table "dvtable_{f3508e3c-6bbf-449c-b17c-0d9eb9804d4d}", id: false, force: true do |t|
    t.string  "RowID",             limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ResponsiblePerson", limit: nil
    t.text    "Subject"
    t.integer "Order"
  end

  add_index "dvtable_{f3508e3c-6bbf-449c-b17c-0d9eb9804d4d}", ["InstanceID"], name: "dvsys_protocolcard_agenda_section"

  create_table "dvtable_{f3508e3c-6bbf-449c-b17c-0d9eb9804d4d}_archive", id: false, force: true do |t|
    t.string  "RowID",             limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ResponsiblePerson", limit: nil
    t.text    "Subject"
    t.integer "Order"
  end

  add_index "dvtable_{f3508e3c-6bbf-449c-b17c-0d9eb9804d4d}_archive", ["InstanceID"], name: "dvsys_protocolcard_agenda_archive_section"

  create_table "dvtable_{f3a08e4e-62de-44bc-a632-fd87eeea811e}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "LNANumerator",    limit: nil
    t.string "LNACategoryType", limit: nil
    t.string "LNALnaFolder",    limit: nil
  end

  add_index "dvtable_{f3a08e4e-62de-44bc-a632-fd87eeea811e}", ["InstanceID"], name: "dvsys_refdocsetup_lnasetup_uc_struct", unique: true

  create_table "dvtable_{f3d0779a-4a31-4e0a-b0d6-9e303c0f012c}", id: false, force: true do |t|
    t.string "RowID",             limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",              limit: nil
    t.string "ContractNumerator", limit: nil
  end

  add_index "dvtable_{f3d0779a-4a31-4e0a-b0d6-9e303c0f012c}", ["InstanceID"], name: "dvsys_refdocsetup_contractplansetup_uc_struct", unique: true

  create_table "dvtable_{f4518325-ad3f-45d5-935e-6bc6e2a22cf4}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.text   "AssignmentText"
  end

  add_index "dvtable_{f4518325-ad3f-45d5-935e-6bc6e2a22cf4}", ["ParentRowID"], name: "dvsys_refdocsetup_assignmentsuggestions_section"

  create_table "dvtable_{f4652b95-3b78-4892-80ce-0211c83fa941}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
    t.string "Registrator",     limit: nil
  end

  add_index "dvtable_{f4652b95-3b78-4892-80ce-0211c83fa941}", ["ParentRowID"], name: "dvsys_refdocsetup_directivetyperegistrators_section"

  create_table "dvtable_{f52f4439-30a9-4c03-bc93-94fd8dd6183b}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "TemplateID",      limit: nil
  end

  add_index "dvtable_{f52f4439-30a9-4c03-bc93-94fd8dd6183b}", ["ParentRowID"], name: "dvsys_folderscard_allowedtemplates_section"

  create_table "dvtable_{f5c00c74-fdce-429e-b483-bde3fc5abd0c}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "DepartmentID",    limit: nil
    t.string "NumberPrefix",    limit: 32
    t.string "NumberSuffix",    limit: 32
    t.string "DepartmentIDUID", limit: nil
  end

  add_index "dvtable_{f5c00c74-fdce-429e-b483-bde3fc5abd0c}", ["DepartmentID", "ParentRowID", "DepartmentIDUID"], name: "dvsys_refnumerators_departments_uc_section_departmentid", unique: true
  add_index "dvtable_{f5c00c74-fdce-429e-b483-bde3fc5abd0c}", ["ParentRowID"], name: "dvsys_refnumerators_departments_section"

  create_table "dvtable_{f65e5f15-f4f4-427e-8dff-ded048ea6ca5}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{f65e5f15-f4f4-427e-8dff-ded048ea6ca5}", ["InstanceID", "ParentRowID"], name: "dvsys_cardinc_enumvalues_section"
  add_index "dvtable_{f65e5f15-f4f4-427e-8dff-ded048ea6ca5}", ["ParentRowID"], name: "dvsys_cardinc_enumvalues_idx_parentrowid"

  create_table "dvtable_{f65e5f15-f4f4-427e-8dff-ded048ea6ca5}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "ValueID"
    t.string  "ValueName",       limit: 128
  end

  add_index "dvtable_{f65e5f15-f4f4-427e-8dff-ded048ea6ca5}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_cardinc_enumvalues_archive_section"
  add_index "dvtable_{f65e5f15-f4f4-427e-8dff-ded048ea6ca5}_archive", ["ParentRowID"], name: "dvsys_cardinc_enumvalues_archive_idx_parentrowid"

  create_table "dvtable_{f6927a03-5bce-4c7e-9c8f-e61c6d9f256e}", id: false, force: true do |t|
    t.string  "RowID",             limit: nil,                                                   null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",        limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",       limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",   limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",              limit: nil
    t.string  "Name",              limit: 128
    t.string  "Comments",          limit: 1024
    t.boolean "IsPersonal"
    t.string  "AccountName",       limit: 128
    t.boolean "RefreshADsGroup"
    t.boolean "ADsNotSynchronize"
    t.string  "AccountSID",        limit: 256
    t.string  "NameUID",           limit: nil
  end

  add_index "dvtable_{f6927a03-5bce-4c7e-9c8f-e61c6d9f256e}", ["Name", "NameUID"], name: "dvsys_refstaff_roles_uc_global_name", unique: true

  create_table "dvtable_{f73d85ec-89bf-4730-849a-10b4fef8fe2c}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ColumnName",      limit: 32
    t.integer "Order"
    t.boolean "Ascending"
    t.boolean "Active"
  end

  add_index "dvtable_{f73d85ec-89bf-4730-849a-10b4fef8fe2c}", ["ParentRowID"], name: "dvsys_navigatorcard_sortingsettings_section"

  create_table "dvtable_{f79d2ca6-bde4-4e67-9c73-fe828378c150}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",            limit: nil
  end

  add_index "dvtable_{f79d2ca6-bde4-4e67-9c73-fe828378c150}", ["InstanceID"], name: "dvsys_simpletaskui_maininfo_uc_struct", unique: true

  create_table "dvtable_{f7a15e7c-7b62-47b6-8084-93e29efb2c04}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text   "Data"
  end

  add_index "dvtable_{f7a15e7c-7b62-47b6-8084-93e29efb2c04}", ["InstanceID", "ParentRowID"], name: "dvsys_process_passdata_uc_struct", unique: true
  add_index "dvtable_{f7a15e7c-7b62-47b6-8084-93e29efb2c04}", ["ParentRowID"], name: "dvsys_process_passdata_idx_parentrowid"

  create_table "dvtable_{f7a15e7c-7b62-47b6-8084-93e29efb2c04}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.text   "Data"
  end

  add_index "dvtable_{f7a15e7c-7b62-47b6-8084-93e29efb2c04}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_process_passdata_archive_uc_struct", unique: true
  add_index "dvtable_{f7a15e7c-7b62-47b6-8084-93e29efb2c04}_archive", ["ParentRowID"], name: "dvsys_process_passdata_archive_idx_parentrowid"

  create_table "dvtable_{f81b2678-2788-4155-906d-c223244de319}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "EmployeeID",      limit: nil
    t.integer "Type"
    t.boolean "IsResponsible"
    t.string  "DepartmentID",    limit: nil
    t.string  "PositionID",      limit: nil
  end

  add_index "dvtable_{f81b2678-2788-4155-906d-c223244de319}", ["InstanceID"], name: "dvsys_cardresolution_employees_section"

  create_table "dvtable_{f81b2678-2788-4155-906d-c223244de319}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Order"
    t.string  "EmployeeID",      limit: nil
    t.integer "Type"
    t.boolean "IsResponsible"
    t.string  "DepartmentID",    limit: nil
    t.string  "PositionID",      limit: nil
  end

  add_index "dvtable_{f81b2678-2788-4155-906d-c223244de319}_archive", ["InstanceID"], name: "dvsys_cardresolution_employees_archive_section"

  create_table "dvtable_{f831372e-8a76-4abc-af15-d86dc5ffbe12}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Version"
    t.string  "AuthorID",        limit: nil
    t.string  "FileID",          limit: nil
    t.integer "VersionNumber"
    t.string  "ExtCardID",       limit: nil
  end

  add_index "dvtable_{f831372e-8a76-4abc-af15-d86dc5ffbe12}", ["InstanceID", "ParentTreeRowID"], name: "dvsys_versionedfilecard_versions_section"

  create_table "dvtable_{f831372e-8a76-4abc-af15-d86dc5ffbe12}_archive", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer "Version"
    t.string  "AuthorID",        limit: nil
    t.string  "FileID",          limit: nil
    t.integer "VersionNumber"
    t.string  "ExtCardID",       limit: nil
  end

  add_index "dvtable_{f831372e-8a76-4abc-af15-d86dc5ffbe12}_archive", ["InstanceID", "ParentTreeRowID"], name: "dvsys_versionedfilecard_versions_archive_section"

  create_table "dvtable_{f875c7c6-a280-402d-bc56-36dee6376eed}", id: false, force: true do |t|
    t.string   "RowID",                      limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "OrderProjectDate"
    t.integer  "State",                                  default: 1
    t.datetime "RegistrationDate"
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID",       limit: nil
    t.integer  "ListCount"
    t.string   "Executer",                   limit: nil
    t.string   "SignedBy",                   limit: nil
    t.text     "Subject"
    t.text     "Content"
    t.string   "CaseID",                     limit: nil
    t.string   "FileListId",                 limit: nil
    t.string   "Registrator",                limit: nil
    t.integer  "InAppendix"
    t.string   "LinkListId",                 limit: nil
    t.string   "LegacySystemID",             limit: 256
    t.string   "BarcodeNumber",              limit: 40
    t.string   "BarcodeNumberID",            limit: nil
    t.string   "TransferLog",                limit: nil
    t.string   "Controller",                 limit: nil
    t.string   "SignedBy_AlternateDirector", limit: nil
    t.integer  "CopiesCount"
    t.boolean  "NoApproving"
    t.string   "ApprovalListID",             limit: nil
    t.string   "OrderType",                  limit: nil
    t.string   "ProjectNumber"
    t.string   "ProjectNumberID",            limit: nil
    t.string   "OrderTypeText",              limit: 256
    t.string   "CurrentDocTemplate",         limit: nil
    t.string   "ExecutionProcessID",         limit: nil
  end

  add_index "dvtable_{f875c7c6-a280-402d-bc56-36dee6376eed}", ["InstanceID"], name: "dvsys_ordercard_maininfo_uc_struct", unique: true

  create_table "dvtable_{f875c7c6-a280-402d-bc56-36dee6376eed}_archive", id: false, force: true do |t|
    t.string   "RowID",                      limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",                limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",            limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.datetime "OrderProjectDate"
    t.integer  "State"
    t.datetime "RegistrationDate"
    t.string   "RegistrationNumber"
    t.string   "RegistrationNumberID",       limit: nil
    t.integer  "ListCount"
    t.string   "Executer",                   limit: nil
    t.string   "SignedBy",                   limit: nil
    t.text     "Subject"
    t.text     "Content"
    t.string   "CaseID",                     limit: nil
    t.string   "FileListId",                 limit: nil
    t.string   "Registrator",                limit: nil
    t.integer  "InAppendix"
    t.string   "LinkListId",                 limit: nil
    t.string   "LegacySystemID",             limit: 256
    t.string   "BarcodeNumber",              limit: 40
    t.string   "BarcodeNumberID",            limit: nil
    t.string   "TransferLog",                limit: nil
    t.string   "Controller",                 limit: nil
    t.string   "SignedBy_AlternateDirector", limit: nil
    t.integer  "CopiesCount"
    t.boolean  "NoApproving"
    t.string   "ApprovalListID",             limit: nil
    t.string   "OrderType",                  limit: nil
    t.string   "ProjectNumber"
    t.string   "ProjectNumberID",            limit: nil
    t.string   "OrderTypeText",              limit: 256
    t.string   "CurrentDocTemplate",         limit: nil
    t.string   "ExecutionProcessID",         limit: nil
  end

  add_index "dvtable_{f875c7c6-a280-402d-bc56-36dee6376eed}_archive", ["InstanceID"], name: "dvsys_ordercard_maininfo_archive_uc_struct", unique: true

  create_table "dvtable_{f896b5ac-d438-48cb-ae74-95c3f880483c}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Recipient",       limit: nil
    t.string   "DocumentNumber"
    t.datetime "SendingDate"
    t.integer  "DocumentType"
    t.string   "RegNumber"
    t.float    "Amount",          limit: 24
    t.string   "SendingNumber"
    t.string   "ParentOutDoc",    limit: nil
  end

  add_index "dvtable_{f896b5ac-d438-48cb-ae74-95c3f880483c}", ["InstanceID"], name: "dvsys_registercard_documentstosend_section"

  create_table "dvtable_{f896b5ac-d438-48cb-ae74-95c3f880483c}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "Recipient",       limit: nil
    t.string   "DocumentNumber"
    t.datetime "SendingDate"
    t.integer  "DocumentType"
    t.string   "RegNumber"
    t.float    "Amount",          limit: 24
    t.string   "SendingNumber"
    t.string   "ParentOutDoc",    limit: nil
  end

  add_index "dvtable_{f896b5ac-d438-48cb-ae74-95c3f880483c}_archive", ["InstanceID"], name: "dvsys_registercard_documentstosend_archive_section"

  create_table "dvtable_{f94300eb-284e-4ab4-88ad-1e1d34d88f70}", id: false, force: true do |t|
    t.string   "RowID",             limit: nil,                                                  null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ViewID",            limit: nil
    t.integer  "Aggregation"
    t.string   "AggregationText",   limit: 64
    t.string   "AggregationColumn", limit: 32
    t.string   "HeaderFont",        limit: 32,  default: "MS Sans Serif"
    t.integer  "HeaderFontSize",                default: 9
    t.integer  "HeaderFontStyle"
    t.string   "RowFont",           limit: 32,  default: "MS Sans Serif"
    t.integer  "RowFontSize",                   default: 9
    t.integer  "RowFontStyle"
    t.integer  "GridLineStyle"
    t.integer  "GridLineMode"
    t.integer  "ViewFlags"
    t.string   "FilterID",          limit: nil
    t.integer  "RowHeight"
    t.string   "PreviewColumn",     limit: 32
    t.integer  "HeaderFontCharset"
    t.integer  "RowFontCharset"
    t.integer  "FolderLevel"
    t.integer  "LinkLevel"
    t.datetime "Timestamp"
  end

  create_table "dvtable_{f94300eb-284e-4ab4-88ad-1e1d34d88f70}_userdependent", id: false, force: true do |t|
    t.string   "RowID",               limit: nil, null: false
    t.string   "UserID",              limit: nil, null: false
    t.binary   "UserLayout"
    t.datetime "UserLayoutTimestamp"
    t.integer  "UserLayoutState"
  end

  create_table "dvtable_{f9841c93-c4e7-48af-90d8-ddf29d1742d3}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean  "IsReceived"
    t.string   "FromEmployee",    limit: nil
    t.string   "ToEmployee",      limit: nil
    t.string   "ToDepartment",    limit: nil
    t.datetime "TransferDate"
    t.boolean  "IsCopy"
    t.string   "Comments",        limit: 2048
  end

  add_index "dvtable_{f9841c93-c4e7-48af-90d8-ddf29d1742d3}", ["InstanceID"], name: "dvsys_carduni_transferlog_section"

  create_table "dvtable_{f9841c93-c4e7-48af-90d8-ddf29d1742d3}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean  "IsReceived"
    t.string   "FromEmployee",    limit: nil
    t.string   "ToEmployee",      limit: nil
    t.string   "ToDepartment",    limit: nil
    t.datetime "TransferDate"
    t.boolean  "IsCopy"
    t.string   "Comments",        limit: 2048
  end

  add_index "dvtable_{f9841c93-c4e7-48af-90d8-ddf29d1742d3}_archive", ["InstanceID"], name: "dvsys_carduni_transferlog_archive_section"

  create_table "dvtable_{f9bf19e6-dd95-47ab-8896-4607aca73aaf}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Department",      limit: nil
  end

  add_index "dvtable_{f9bf19e6-dd95-47ab-8896-4607aca73aaf}", ["ParentRowID"], name: "dvsys_refreports_defaultdepartments_section"

  create_table "dvtable_{f9f1cae0-7ec8-4371-b2a6-77bb57a54a85}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.integer "DocumentType"
    t.boolean "RefRouteOnly"
    t.string  "Route",           limit: nil
    t.string  "PrintTemplate",   limit: nil
  end

  create_table "dvtable_{fa3368cb-12ba-44b7-87c5-70d527382d37}", id: false, force: true do |t|
    t.string  "RowID",                       limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",                  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",                 limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",             limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",                        limit: nil
    t.string  "BarcodeNumberTemplate",       limit: 50
    t.string  "BarcodeNumerator",            limit: nil
    t.integer "BarcodePrintEncoding",                    default: 1
    t.integer "BarcodePrint_X"
    t.integer "BarcodePrint_Y"
    t.integer "BarcodePrint_Height"
    t.integer "BarcodePrint_Width"
    t.integer "BarcodePrint_Angle",                      default: 1
    t.boolean "BarcodePrint_IncludeNumber"
    t.string  "BarcodeBPTemplate",           limit: nil
    t.string  "BarcodeBPInstanceFolder",     limit: nil
    t.string  "BarcodeBPStartingFolder",     limit: nil
    t.string  "BarcodeTransferLogStorage",   limit: nil
    t.string  "BarcodeTransferAdmin",        limit: nil
    t.integer "BarcodeAcceptDuration"
    t.string  "BarcodeNumberPrefix",         limit: 10
    t.integer "BarcodeDocumentAnchor",                   default: 1
    t.integer "BarcodeDocumentIndentX"
    t.integer "BarcodeDocumentIndentY"
    t.integer "BarcodeDocumentPrint_Height"
    t.integer "BarcodeDocumentPrint_Width"
    t.integer "BarcodeDocumentPrint_Angle",              default: 1
    t.integer "BarcodeDocumentPages",                    default: 1
    t.integer "BarcodePaperIndent_X"
    t.integer "BarcodePaperIndent_Y"
    t.integer "BarcodePaperPrint_Width"
    t.integer "BarcodePaperPrint_Height"
    t.integer "BarcodePaperPrint_Angle"
    t.string  "BarcodeProtectionPassword",   limit: 256
  end

  add_index "dvtable_{fa3368cb-12ba-44b7-87c5-70d527382d37}", ["InstanceID"], name: "dvsys_refdocsetup_barcodesetup_uc_struct", unique: true

  create_table "dvtable_{fb2ac41f-1911-4f7c-b631-18cfaeb311bd}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",            limit: nil
    t.string  "Name",            limit: 256
    t.text    "Text"
    t.boolean "Hidden"
    t.string  "NameUID",         limit: nil
  end

  add_index "dvtable_{fb2ac41f-1911-4f7c-b631-18cfaeb311bd}", ["Name", "ParentRowID", "NameUID"], name: "dvsys_savedsearchcard_queries_uc_section_name", unique: true
  add_index "dvtable_{fb2ac41f-1911-4f7c-b631-18cfaeb311bd}", ["ParentRowID"], name: "dvsys_savedsearchcard_queries_section"

  create_table "dvtable_{fb2fe50b-adfc-435f-9a1c-9753fd57d0ce}", id: false, force: true do |t|
    t.string  "RowID",             limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",   limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",              limit: nil
    t.integer "AssignmentType"
    t.integer "AssignmentDocType"
    t.string  "AssignmentKind",    limit: nil
  end

  add_index "dvtable_{fb2fe50b-adfc-435f-9a1c-9753fd57d0ce}", ["ParentRowID"], name: "dvsys_refdocsetup_assignmentkinds_section"

  create_table "dvtable_{fbfe20b6-5fe8-4058-a5b2-2d778e64e508}", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean  "IsReceived"
    t.string   "FromEmployee",    limit: nil
    t.string   "ToEmployee",      limit: nil
    t.string   "ToDepartment",    limit: nil
    t.datetime "TransferDate"
    t.boolean  "IsCopy"
    t.string   "Comments",        limit: 2048
  end

  add_index "dvtable_{fbfe20b6-5fe8-4058-a5b2-2d778e64e508}", ["InstanceID"], name: "dvsys_cardarchive_transferlog_section"

  create_table "dvtable_{fbfe20b6-5fe8-4058-a5b2-2d778e64e508}_archive", id: false, force: true do |t|
    t.string   "RowID",           limit: nil,                                                   null: false
    t.binary   "SysRowTimestamp"
    t.string   "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.boolean  "IsReceived"
    t.string   "FromEmployee",    limit: nil
    t.string   "ToEmployee",      limit: nil
    t.string   "ToDepartment",    limit: nil
    t.datetime "TransferDate"
    t.boolean  "IsCopy"
    t.string   "Comments",        limit: 2048
  end

  add_index "dvtable_{fbfe20b6-5fe8-4058-a5b2-2d778e64e508}_archive", ["InstanceID"], name: "dvsys_cardarchive_transferlog_archive_section"

  create_table "dvtable_{fc138430-de5d-47d2-bbd6-da17d4dcf4cd}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Recipient",       limit: nil
  end

  add_index "dvtable_{fc138430-de5d-47d2-bbd6-da17d4dcf4cd}", ["InstanceID", "ParentRowID"], name: "dvsys_incdoc_recipients_section"
  add_index "dvtable_{fc138430-de5d-47d2-bbd6-da17d4dcf4cd}", ["ParentRowID"], name: "dvsys_incdoc_recipients_idx_parentrowid"

  create_table "dvtable_{fc138430-de5d-47d2-bbd6-da17d4dcf4cd}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "Recipient",       limit: nil
  end

  add_index "dvtable_{fc138430-de5d-47d2-bbd6-da17d4dcf4cd}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_incdoc_recipients_archive_section"
  add_index "dvtable_{fc138430-de5d-47d2-bbd6-da17d4dcf4cd}_archive", ["ParentRowID"], name: "dvsys_incdoc_recipients_archive_idx_parentrowid"

  create_table "dvtable_{fcec4b71-4922-4d42-8b71-508e286f1073}", id: false, force: true do |t|
    t.string  "RowID",           limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "Employee",        limit: nil
    t.integer "Setting"
  end

  create_table "dvtable_{fe27631d-eeea-4e2e-a04c-d4351282fb55}", id: false, force: true do |t|
    t.string  "RowID",              limit: nil,                                                  null: false
    t.binary  "SysRowTimestamp"
    t.string  "InstanceID",         limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentRowID",        limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "ParentTreeRowID",    limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string  "SDID",               limit: nil
    t.string  "Name",               limit: 256
    t.integer "Type",                           default: 1
    t.integer "DefaultStyle",                   default: 1
    t.string  "PropCardID",         limit: nil
    t.string  "Url",                limit: 512
    t.integer "AllowedStyles",                  default: -1
    t.boolean "Deleted"
    t.string  "IconRef",            limit: nil
    t.integer "Restrictions"
    t.string  "DefaultViewID",      limit: nil
    t.string  "RefID",              limit: nil
    t.boolean "ViewCyclingEnabled",             default: true
    t.integer "ViewCycleCount",                 default: 40
    t.integer "Flags"
    t.string  "DefaultTemplateID",  limit: nil
    t.integer "RefreshTimeout"
    t.string  "ExtTypeID",          limit: nil
    t.string  "NameUID",            limit: nil
  end

  add_index "dvtable_{fe27631d-eeea-4e2e-a04c-d4351282fb55}", ["Name", "ParentTreeRowID", "NameUID"], name: "dvsys_folderscard_folders_uc_tree_name", unique: true
  add_index "dvtable_{fe27631d-eeea-4e2e-a04c-d4351282fb55}", ["ParentTreeRowID"], name: "dvsys_folderscard_folders_section"

  create_table "dvtable_{fe4ebb41-697f-45fe-908b-a997aca76ee9}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                   null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ID",              limit: nil
    t.string "TypeID",          limit: nil
    t.string "Caption",         limit: 128
    t.string "Description",     limit: 1024
    t.text   "Data"
  end

  add_index "dvtable_{fe4ebb41-697f-45fe-908b-a997aca76ee9}", ["InstanceID"], name: "dvsys_process_gates_section"

  create_table "dvtable_{fe4ebb41-697f-45fe-908b-a997aca76ee9}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                   null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil,  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ID",              limit: nil
    t.string "TypeID",          limit: nil
    t.string "Caption",         limit: 128
    t.string "Description",     limit: 1024
    t.text   "Data"
  end

  add_index "dvtable_{fe4ebb41-697f-45fe-908b-a997aca76ee9}_archive", ["InstanceID"], name: "dvsys_process_gates_archive_section"

  create_table "dvtable_{ff34d0b5-13b7-42cd-944b-702d42ae1023}", id: false, force: true do |t|
    t.string "RowID",            limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "LinkedAssignment", limit: nil
  end

  add_index "dvtable_{ff34d0b5-13b7-42cd-944b-702d42ae1023}", ["InstanceID", "ParentRowID"], name: "dvsys_durableassignmentcard_linkedassignments_section"
  add_index "dvtable_{ff34d0b5-13b7-42cd-944b-702d42ae1023}", ["ParentRowID"], name: "dvsys_durableassignmentcard_linkedassignments_idx_parentrowid"

  create_table "dvtable_{ff34d0b5-13b7-42cd-944b-702d42ae1023}_archive", id: false, force: true do |t|
    t.string "RowID",            limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",       limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",  limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "LinkedAssignment", limit: nil
  end

  add_index "dvtable_{ff34d0b5-13b7-42cd-944b-702d42ae1023}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_durableassignmentcard_linkedassignments_archive_section"
  add_index "dvtable_{ff34d0b5-13b7-42cd-944b-702d42ae1023}_archive", ["ParentRowID"], name: "dvsys_durableassignmentcard_linkedassignments_archive_idx_parentrowid"

  create_table "dvtable_{ff403c0a-7b21-42f7-af4f-01a47e0d0048}", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "EditAssignee",    limit: nil
  end

  add_index "dvtable_{ff403c0a-7b21-42f7-af4f-01a47e0d0048}", ["InstanceID", "ParentRowID"], name: "dvsys_ordercard_editassignees_section"
  add_index "dvtable_{ff403c0a-7b21-42f7-af4f-01a47e0d0048}", ["ParentRowID"], name: "dvsys_ordercard_editassignees_idx_parentrowid"

  create_table "dvtable_{ff403c0a-7b21-42f7-af4f-01a47e0d0048}_archive", id: false, force: true do |t|
    t.string "RowID",           limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",     limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID", limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "EditAssignee",    limit: nil
  end

  add_index "dvtable_{ff403c0a-7b21-42f7-af4f-01a47e0d0048}_archive", ["InstanceID", "ParentRowID"], name: "dvsys_ordercard_editassignees_archive_section"
  add_index "dvtable_{ff403c0a-7b21-42f7-af4f-01a47e0d0048}_archive", ["ParentRowID"], name: "dvsys_ordercard_editassignees_archive_idx_parentrowid"

  create_table "dvtable_{ffa16af6-55ad-435b-a4af-8a65796a97a1}", id: false, force: true do |t|
    t.string "RowID",                limit: nil,                                                  null: false
    t.binary "SysRowTimestamp"
    t.string "InstanceID",           limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentRowID",          limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "ParentTreeRowID",      limit: nil, default: "00000000-0000-0000-0000-000000000000", null: false
    t.string "SDID",                 limit: nil
    t.string "MemorandumODEmployee", limit: nil
  end

  add_index "dvtable_{ffa16af6-55ad-435b-a4af-8a65796a97a1}", ["ParentRowID"], name: "dvsys_refdocsetup_memorandumodemployees_section"

  create_table "idoc_MonitoringLog", id: false, force: true do |t|
    t.string   "Handler",   limit: nil
    t.datetime "Date",                  null: false
    t.integer  "Level",                 null: false
    t.text     "Message"
    t.binary   "Timestamp",             null: false
  end

  add_index "idoc_MonitoringLog", ["Date"], name: "IX_idoc_MonitoringLog_Date"
  add_index "idoc_MonitoringLog", ["Level"], name: "IX_idoc_MonitoringLog_Level"

  create_table "irpl_Object", id: false, force: true do |t|
    t.string  "ID",         limit: nil,                null: false
    t.string  "CardID",     limit: nil,                null: false
    t.string  "CardTypeID", limit: nil,                null: false
    t.string  "SectionID",  limit: nil
    t.string  "RowID",      limit: nil
    t.boolean "IsLocal",                default: true, null: false
  end

  create_table "irpl_Replica", id: false, force: true do |t|
    t.string   "ID",          limit: nil,                 null: false
    t.boolean  "IsSent",                  default: false, null: false
    t.boolean  "IsConfirmed",             default: false, null: false
    t.datetime "Date",                                    null: false
    t.binary   "Timestamp",                               null: false
    t.string   "TargetZone",  limit: nil,                 null: false
    t.string   "SourceZone",  limit: nil,                 null: false
  end

  create_table "irpl_ReplicaObject", id: false, force: true do |t|
    t.string  "Replica",           limit: nil,                 null: false
    t.string  "Object",            limit: nil,                 null: false
    t.integer "ChangeTime",        limit: 8,                   null: false
    t.integer "ObjectState"
    t.boolean "TransferOwnership",             default: false, null: false
  end

  create_table "irpl_Zone", id: false, force: true do |t|
    t.string  "ID",          limit: nil,                 null: false
    t.string  "Name",        limit: 128,                 null: false
    t.text    "Description"
    t.boolean "IsRoot",                  default: false, null: false
    t.boolean "IsHome",                  default: false, null: false
    t.boolean "IsDeleted"
  end

  create_table "irpl_ZoneConfig", id: false, force: true do |t|
    t.string "Zone",     limit: nil, null: false
    t.string "ConfigID", limit: nil, null: false
    t.text   "Data"
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
