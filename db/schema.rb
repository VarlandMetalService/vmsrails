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

ActiveRecord::Schema.define(version: 20180516190945) do

  create_table "dept_info_documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  create_table "dept_info_folders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.bigint "parent_id"
    t.bigint "lft"
    t.bigint "rgt"
    t.integer "depth"
    t.string "google_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "maintenance_scheduled_task_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
