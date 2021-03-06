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

ActiveRecord::Schema.define(version: 2022_05_16_020016) do

  create_table "lessons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "plans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "week_id", null: false
    t.integer "num_week_id", null: false
    t.time "st_time", null: false
    t.date "started_on", null: false
    t.date "updated_on"
    t.bigint "student_id", null: false
    t.bigint "lesson_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_plans_on_lesson_id"
    t.index ["student_id"], name: "index_plans_on_student_id"
  end

  create_table "schedules", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "one_week_id", null: false
    t.bigint "two_week_id", null: false
    t.bigint "three_week_id", null: false
    t.bigint "four_week_id", null: false
    t.index ["four_week_id"], name: "index_schedules_on_four_week_id"
    t.index ["one_week_id"], name: "index_schedules_on_one_week_id"
    t.index ["three_week_id"], name: "index_schedules_on_three_week_id"
    t.index ["two_week_id"], name: "index_schedules_on_two_week_id"
  end

  create_table "student_schedules", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "schedule_id", null: false
    t.date "started_on", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["schedule_id"], name: "index_student_schedules_on_schedule_id"
    t.index ["student_id"], name: "index_student_schedules_on_student_id"
  end

  create_table "student_time_tables", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "time_table_id", null: false
    t.date "started_on", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_student_time_tables_on_student_id"
    t.index ["time_table_id"], name: "index_student_time_tables_on_time_table_id"
  end

  create_table "students", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "kana_name", null: false
    t.date "birth_on", null: false
    t.date "withdrawal_on"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "time_tables", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "week_id", null: false
    t.time "st_time", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "plans", "lessons"
  add_foreign_key "plans", "students"
  add_foreign_key "schedules", "lessons", column: "four_week_id"
  add_foreign_key "schedules", "lessons", column: "one_week_id"
  add_foreign_key "schedules", "lessons", column: "three_week_id"
  add_foreign_key "schedules", "lessons", column: "two_week_id"
  add_foreign_key "student_schedules", "schedules"
  add_foreign_key "student_schedules", "students"
  add_foreign_key "student_time_tables", "students"
  add_foreign_key "student_time_tables", "time_tables"
end
