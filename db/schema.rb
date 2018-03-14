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

ActiveRecord::Schema.define(version: 20180201204332) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attempts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "exercise_id"
    t.string "attempted_answer"
    t.boolean "attempt_successful"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_attempts_on_exercise_id"
    t.index ["user_id"], name: "index_attempts_on_user_id"
  end

  create_table "chapters", force: :cascade do |t|
    t.bigint "course_id"
    t.string "title_en"
    t.string "description_en"
    t.integer "position_in_course"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_chapters_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title_en"
    t.string "description_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "examples", force: :cascade do |t|
    t.bigint "lesson_id"
    t.text "content_en"
    t.string "img_url"
    t.integer "position_in_lesson"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_examples_on_lesson_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.bigint "lesson_id"
    t.text "question_en"
    t.string "answer"
    t.integer "position_in_lesson"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_exercises_on_lesson_id"
  end

  create_table "learning_statuses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.bigint "chapter_id"
    t.bigint "lesson_id"
    t.bigint "exercise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_learning_statuses_on_chapter_id"
    t.index ["course_id"], name: "index_learning_statuses_on_course_id"
    t.index ["exercise_id"], name: "index_learning_statuses_on_exercise_id"
    t.index ["lesson_id"], name: "index_learning_statuses_on_lesson_id"
    t.index ["user_id"], name: "index_learning_statuses_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.bigint "chapter_id"
    t.string "title_en"
    t.text "content_en"
    t.integer "position_in_chapter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_lessons_on_chapter_id"
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
    t.string "first_name"
    t.string "last_name"
    t.string "pseudo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attempts", "exercises"
  add_foreign_key "attempts", "users"
  add_foreign_key "chapters", "courses"
  add_foreign_key "examples", "lessons"
  add_foreign_key "exercises", "lessons"
  add_foreign_key "learning_statuses", "chapters"
  add_foreign_key "learning_statuses", "courses"
  add_foreign_key "learning_statuses", "exercises"
  add_foreign_key "learning_statuses", "lessons"
  add_foreign_key "learning_statuses", "users"
  add_foreign_key "lessons", "chapters"
end
