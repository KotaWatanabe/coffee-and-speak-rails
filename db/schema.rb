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

ActiveRecord::Schema.define(version: 2019_05_30_231842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "availabilities", force: :cascade do |t|
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "day"
    t.boolean "morning"
    t.boolean "afternoon"
    t.boolean "evening"
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.boolean "saturday"
    t.boolean "sunday"
    t.index ["teacher_id"], name: "index_availabilities_on_teacher_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.bigint "teacher_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_favourites_on_teacher_id"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "teacher_id"
    t.bigint "availability_id"
    t.boolean "approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "aasm_state"
    t.text "comment"
    t.text "answer"
    t.index ["availability_id"], name: "index_lessons_on_availability_id"
    t.index ["teacher_id"], name: "index_lessons_on_teacher_id"
    t.index ["user_id"], name: "index_lessons_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "teacher_id"
    t.string "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "lesson_id"
    t.index ["lesson_id"], name: "index_payments_on_lesson_id"
    t.index ["teacher_id"], name: "index_payments_on_teacher_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "teacher_id"
    t.bigint "user_id"
    t.text "body"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_reviews_on_teacher_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "teacher_languages", force: :cascade do |t|
    t.bigint "teacher_id"
    t.bigint "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_teacher_languages_on_language_id"
    t.index ["teacher_id"], name: "index_teacher_languages_on_teacher_id"
  end

  create_table "teacher_timeslots", force: :cascade do |t|
    t.bigint "teacher_id"
    t.bigint "timeslot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_teacher_timeslots_on_teacher_id"
    t.index ["timeslot_id"], name: "index_teacher_timeslots_on_timeslot_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.integer "price"
    t.string "area"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.json "schedule"
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "timeslots", force: :cascade do |t|
    t.string "day"
    t.string "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "availabilities", "teachers"
  add_foreign_key "favourites", "teachers"
  add_foreign_key "favourites", "users"
  add_foreign_key "lessons", "availabilities"
  add_foreign_key "lessons", "teachers"
  add_foreign_key "lessons", "users"
  add_foreign_key "payments", "lessons"
  add_foreign_key "payments", "teachers"
  add_foreign_key "payments", "users"
  add_foreign_key "reviews", "teachers"
  add_foreign_key "reviews", "users"
  add_foreign_key "teacher_languages", "languages"
  add_foreign_key "teacher_languages", "teachers"
  add_foreign_key "teacher_timeslots", "teachers"
  add_foreign_key "teacher_timeslots", "timeslots"
  add_foreign_key "teachers", "users"
end
