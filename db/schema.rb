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

ActiveRecord::Schema.define(version: 20150224192956) do

  create_table "groups", force: true do |t|
    t.string   "groupName"
    t.string   "picture"
    t.string   "email"
    t.string   "description"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "groupPassword"
    t.string   "grouppicture_file_name"
    t.string   "grouppicture_content_type"
    t.integer  "grouppicture_file_size"
    t.datetime "grouppicture_updated_at"
  end

  create_table "readers", force: true do |t|
    t.string   "readerName"
    t.string   "email"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "readerpicture_file_name"
    t.string   "readerpicture_content_type"
    t.integer  "readerpicture_file_size"
    t.datetime "readerpicture_updated_at"
  end

  create_table "reviews", force: true do |t|
    t.text     "title"
    t.string   "author"
    t.string   "category"
    t.string   "rating"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reader_id"
    t.string   "bookcover_file_name"
    t.string   "bookcover_content_type"
    t.integer  "bookcover_file_size"
    t.datetime "bookcover_updated_at"
  end

  add_index "reviews", ["reader_id"], name: "index_reviews_on_reader_id"

end
