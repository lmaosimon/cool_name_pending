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

ActiveRecord::Schema.define(version: 2019_04_27_163641) do

  create_table "courses", force: :cascade do |t|
    t.string "course_name"
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.string "instructor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "section"
    t.string "start_time"
    t.string "end_time"
    t.string "email"
    t.integer "user_id"
    t.boolean "assigned", default: false
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "courses_grader_applications", id: false, force: :cascade do |t|
    t.integer "grader_application_id", null: false
    t.integer "course_id", null: false
  end

  create_table "grader_applications", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "qualifications"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "courses_id"
    t.integer "user_id"
    t.string "assignment"
    t.index ["courses_id"], name: "index_grader_applications_on_courses_id"
    t.index ["user_id"], name: "index_grader_applications_on_user_id"
  end

  create_table "recommendations", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "course"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "section"
    t.integer "user_id"
    t.index ["user_id"], name: "index_recommendations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "status"
    t.boolean "admin", default: false
    t.integer "grader_applications_id"
    t.integer "course_id"
    t.index ["course_id"], name: "index_users_on_course_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["grader_applications_id"], name: "index_users_on_grader_applications_id"
  end

end
