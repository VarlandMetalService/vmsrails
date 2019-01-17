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

ActiveRecord::Schema.define(version: 20190116214051) do

  create_table "assigned_permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "permission_id"
    t.bigint "user_id"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_assigned_permissions_on_permission_id"
    t.index ["user_id"], name: "index_assigned_permissions_on_user_id"
  end

  create_table "classifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "specification_id"
    t.string "name"
    t.text "description"
    t.string "vms_process_code"
    t.string "color"
    t.float "minimum_alloy_percentage", limit: 24
    t.float "maximum_alloy_percentage", limit: 24
    t.float "minimum_thickness", limit: 24
    t.float "maximum_thickness", limit: 24
    t.string "thickness_unit"
    t.integer "salt_spray_white_spec"
    t.integer "salt_spray_red_spec"
    t.integer "bake_setpoint"
    t.integer "bake_variation_limit"
    t.string "bake_temperature_unit"
    t.integer "bake_soak_length"
    t.integer "bake_within_limit"
    t.boolean "bake_requires_inert_atmosphere"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.boolean "not_capable"
    t.index ["deleted_at"], name: "index_classifications_on_deleted_at"
  end

  create_table "clock_edits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "clock_record_id"
    t.integer "user_id"
    t.string "ip_address"
    t.integer "reason_id"
    t.datetime "deleted_at"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clock_periods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean "finalized"
  end

  create_table "clock_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "record_type"
    t.string "ip_address"
    t.datetime "timestamp"
    t.datetime "deleted_at"
    t.integer "clock_period_id"
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "commentable_type"
    t.integer "commentable_id"
    t.text "body"
    t.string "attachment"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dept_info_documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "folder_id"
    t.string "name"
    t.string "google_id"
    t.boolean "is_starred"
    t.text "description"
    t.text "contents"
    t.string "content_type"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dept_info_folders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name", null: false
    t.bigint "parent_id"
    t.bigint "lft"
    t.bigint "rgt"
    t.integer "depth"
    t.string "google_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "document_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employee_notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "employee"
    t.integer "entered_by"
    t.date "note_on"
    t.string "ip_address"
    t.text "notes"
    t.text "follow_up"
    t.date "follow_up_on"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "note_type"
    t.index ["deleted_at"], name: "index_employee_notes_on_deleted_at"
  end

  create_table "inline_attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "maintenance_scheduled_task_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "equipment_type_name"
    t.string "equipment_name"
    t.string "task_name"
    t.string "equipment_type_description"
    t.string "equipment_serial_number"
    t.string "equipment_description_1"
    t.string "equipment_description_2"
    t.string "equipment_description_3"
    t.string "equipment_description_4"
    t.string "equipment_manufacturer"
    t.string "equipment_model"
    t.date "equipment_in_service_date"
    t.string "equipment_department"
    t.string "equipment_location"
    t.string "task_description"
    t.string "task_url"
    t.integer "scheduled_task_frequency"
    t.string "scheduled_task_description"
    t.date "last_maintenance_date"
    t.string "last_maintenance_initials"
    t.string "code_name"
    t.string "code_description"
  end

  create_table "materials_vat_history_notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "vat_id"
    t.datetime "notes_timestamp"
    t.text "notes"
    t.integer "user_id"
  end

  create_table "materials_vats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "code"
    t.string "description"
    t.string "account"
    t.integer "department"
  end

  create_table "opto_controllers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "ip_address"
    t.string "name"
    t.string "series"
    t.integer "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "opto_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "controller_id"
    t.string "type"
    t.datetime "controller_timestamp"
    t.integer "lane"
    t.integer "station"
    t.integer "shop_order"
    t.integer "load"
    t.integer "barrel"
    t.string "customer"
    t.string "process"
    t.string "part"
    t.string "sub"
    t.float "reading", limit: 24
    t.float "limit", limit: 24
    t.text "json_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "permission"
    t.string "description"
    t.integer "label_set"
  end

  create_table "photos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text "image_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "print_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id"
    t.integer "workstation_id"
    t.integer "document_type_id"
    t.integer "print_queue_id"
    t.string "file"
    t.boolean "is_complete"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
  end

  create_table "print_queue_rules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id"
    t.integer "workstation_group_id"
    t.integer "document_type_id"
    t.integer "print_queue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "print_queues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "printer"
    t.string "options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "printers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "command"
  end

  create_table "qc_rejected_parts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "so_num"
    t.integer "user_id"
    t.date "date"
    t.integer "reject_tag_num"
    t.string "from_tag"
    t.string "defect"
    t.string "loads_approved"
    t.integer "approved_by"
    t.string "cause_category"
    t.string "load_nums"
    t.string "barrel_nums"
    t.string "tank_nums"
    t.text "cause"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "s2box"
    t.boolean "s3box"
    t.string "weight"
    t.integer "supervisor_id"
    t.string "sec1_loads"
    t.text "defect_description"
  end

  create_table "salt_spray_test_checks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "c_type"
    t.datetime "date"
    t.integer "user_id"
    t.integer "salt_spray_test_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "salt_spray_tests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "so_num"
    t.integer "load_num"
    t.integer "user_id"
    t.string "process_code"
    t.text "process"
    t.integer "load_weight"
    t.string "customer"
    t.string "dept"
    t.string "part_tag"
    t.string "sub_tag"
    t.string "part_area"
    t.string "part_density"
    t.integer "white_spec", default: 1
    t.integer "red_spec", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "deleted_at"
    t.boolean "is_sample"
    t.integer "sample_code"
  end

  create_table "shift_notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "shift_time"
    t.integer "user_id"
    t.string "dept"
    t.string "shift_type"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "organization"
    t.string "name"
    t.text "description"
    t.string "revision"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.datetime "archived_at"
    t.text "notes"
    t.index ["archived_at"], name: "index_specifications_on_archived_at"
    t.index ["deleted_at"], name: "index_specifications_on_deleted_at"
  end

  create_table "thickness_blocks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id"
    t.integer "so_num"
    t.integer "load_num"
    t.integer "block_num"
    t.boolean "is_rework"
    t.string "directory"
    t.string "product"
    t.string "application"
    t.string "customer"
    t.string "process"
    t.string "part"
    t.string "sub"
    t.float "load_weight", limit: 24
    t.float "piece_weight", limit: 24
    t.float "part_area", limit: 24
    t.float "part_density", limit: 24
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "thickness_checks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "block_id"
    t.datetime "check_timestamp"
    t.integer "check_num"
    t.float "thickness", limit: 24
    t.float "alloy_percentage", limit: 24
    t.float "x", limit: 24
    t.float "y", limit: 24
    t.float "z", limit: 24
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timeclock_reason_codes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "description"
    t.boolean "requires_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "employee_number", null: false
    t.string "username", limit: 20, null: false
    t.string "first_name", null: false
    t.string "middle_initial", limit: 1
    t.string "last_name", null: false
    t.string "suffix", limit: 10
    t.string "nickname", null: false
    t.string "initials", limit: 5, null: false
    t.string "email", null: false
    t.string "avatar_bg_color", limit: 7, default: "#000000", null: false
    t.string "avatar_text_color", limit: 7, default: "#ffffff", null: false
    t.boolean "is_admin", default: false
    t.boolean "is_disabled", default: false
    t.string "remember_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.string "city"
    t.string "state", limit: 2
    t.integer "zip_code"
    t.string "phone_number", limit: 10
    t.integer "pin"
  end

  create_table "workstation_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "description"
  end

  create_table "workstation_groups_workstations", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "workstation_id"
    t.bigint "workstation_group_id"
    t.index ["workstation_group_id"], name: "index_workstation_groups_workstations_on_workstation_group_id"
    t.index ["workstation_id"], name: "index_workstation_groups_workstations_on_workstation_id"
  end

  create_table "workstations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ip_address"
  end

  add_foreign_key "workstation_groups_workstations", "workstation_groups"
  add_foreign_key "workstation_groups_workstations", "workstations"
end
