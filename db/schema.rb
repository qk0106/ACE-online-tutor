# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150702050630) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "posts"
    t.datetime "last_updated"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "course_id"
  end

  add_index "categories", ["course_id"], name: "index_categories_on_course_id"

  create_table "courses", force: :cascade do |t|
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crawlers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "qnaadds", force: :cascade do |t|
    t.text     "question"
    t.text     "answer"
    t.string   "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "qna_id"
  end

  add_index "qnaadds", ["qna_id"], name: "index_qnaadds_on_qna_id"

  create_table "qnas", force: :cascade do |t|
    t.text     "question"
    t.text     "answer"
    t.string   "answered_by"
    t.datetime "date_post"
    t.datetime "date_answered"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "subject_id"
  end

  add_index "qnas", ["subject_id"], name: "index_qnas_on_subject_id"

  create_table "subjects", force: :cascade do |t|
    t.string   "post"
    t.string   "name"
    t.datetime "posted_date"
    t.datetime "answered_date"
    t.string   "answered_by"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "category_id"
  end

  add_index "subjects", ["category_id"], name: "index_subjects_on_category_id"

end
