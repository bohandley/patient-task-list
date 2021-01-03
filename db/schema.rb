# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_03_043712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "instructions", force: :cascade do |t|
    t.integer "task_list_id"
    t.integer "patient_id"
    t.date "start_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "selected_tasks", force: :cascade do |t|
    t.bigint "instruction_id", null: false
    t.bigint "task_item_id", null: false
    t.boolean "is_complete"
    t.date "complete_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["instruction_id"], name: "index_selected_tasks_on_instruction_id"
    t.index ["task_item_id"], name: "index_selected_tasks_on_task_item_id"
  end

  create_table "task_items", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "due"
    t.bigint "task_list_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "archive"
    t.index ["task_list_id"], name: "index_task_items_on_task_list_id"
  end

  create_table "task_lists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "archive"
  end

  add_foreign_key "selected_tasks", "instructions"
  add_foreign_key "selected_tasks", "task_items"
  add_foreign_key "task_items", "task_lists"
end
