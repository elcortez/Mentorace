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

ActiveRecord::Schema.define(version: 20180120115850) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chapters", force: :cascade do |t|
    t.bigint "course_id"
    t.string "title"
    t.string "description"
    t.integer "position_in_course"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_chapters_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercise_attempts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "unit_exercise_id"
    t.string "attempted_answer"
    t.boolean "attempt_successful"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_exercise_id"], name: "index_exercise_attempts_on_unit_exercise_id"
    t.index ["user_id"], name: "index_exercise_attempts_on_user_id"
  end

  create_table "unit_examples", force: :cascade do |t|
    t.bigint "unit_id"
    t.text "content"
    t.integer "position_in_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_unit_examples_on_unit_id"
  end

  create_table "unit_exercises", force: :cascade do |t|
    t.bigint "unit_id"
    t.text "question"
    t.string "answer"
    t.integer "position_in_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_unit_exercises_on_unit_id"
  end

  create_table "unit_images", force: :cascade do |t|
    t.string "img_url"
    t.integer "unit_id"
    t.integer "position_in_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "unit_lessons", force: :cascade do |t|
    t.bigint "unit_id"
    t.text "content"
    t.integer "position_in_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_unit_lessons_on_unit_id"
  end

  create_table "units", force: :cascade do |t|
    t.bigint "chapter_id"
    t.string "title"
    t.integer "position_in_chapter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_units_on_chapter_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "chapters", "courses"
  add_foreign_key "exercise_attempts", "unit_exercises"
  add_foreign_key "exercise_attempts", "users"
  add_foreign_key "unit_examples", "units"
  add_foreign_key "unit_exercises", "units"
  add_foreign_key "unit_lessons", "units"
  add_foreign_key "units", "chapters"
end
