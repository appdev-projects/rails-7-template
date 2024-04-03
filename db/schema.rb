# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_04_02_203041) do
  create_table "curriculums", force: :cascade do |t|
    t.string "name"
    t.string "grade_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "programs", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "school_id", null: false
    t.integer "curriculum_id", null: false
    t.integer "student_id", null: false
    t.string "season"
    t.string "days"
    t.string "times"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["curriculum_id"], name: "index_programs_on_curriculum_id"
    t.index ["school_id"], name: "index_programs_on_school_id"
    t.index ["student_id"], name: "index_programs_on_student_id"
    t.index ["user_id"], name: "index_programs_on_user_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "school_id", null: false
    t.string "parent_first_name"
    t.string "parent_last_name"
    t.string "parent_relationship"
    t.integer "parent_phone_number"
    t.string "emergency_first_name"
    t.string "emergency_last_name"
    t.integer "emergency_phone"
    t.boolean "pre_survey"
    t.boolean "post_survey"
    t.boolean "interest_survey"
    t.boolean "iep_or_504"
    t.boolean "progress_report_1"
    t.boolean "progress_report_2"
    t.boolean "progress_report_3"
    t.boolean "progress_report_4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_students_on_school_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.boolean "admin"
    t.boolean "facilitator"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "programs", "curriculums"
  add_foreign_key "programs", "schools"
  add_foreign_key "programs", "students"
  add_foreign_key "programs", "users"
  add_foreign_key "students", "schools"
end
