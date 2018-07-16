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

ActiveRecord::Schema.define(version: 20180716204437) do

  create_table "classifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "specification_id"
    t.string "name"
    t.string "description"
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
    t.index ["deleted_at"], name: "index_classifications_on_deleted_at"
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

  create_table "shift_notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "shift_time"
    t.integer "user_id"
    t.string "dept"
    t.string "shift_type"
    t.text "message"
    t.text "response"
    t.integer "response_uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "organization"
    t.string "name"
    t.string "description"
    t.string "revision"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.datetime "archived_at"
    t.index ["archived_at"], name: "index_specifications_on_archived_at"
    t.index ["deleted_at"], name: "index_specifications_on_deleted_at"
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
  end

end
