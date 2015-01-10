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

ActiveRecord::Schema.define(version: 20141123130023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "etchings", force: true do |t|
    t.string   "title"
    t.text     "short_description"
    t.integer  "height"
    t.integer  "width"
    t.integer  "plates"
    t.integer  "print_run"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year"
    t.string   "long_description"
    t.boolean  "listed",            default: true
  end

  create_table "prints", force: true do |t|
    t.string   "thumbnail_url"
    t.string   "large_url"
    t.string   "tags"
    t.integer  "etching_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.string   "medium_url"
  end

  add_index "prints", ["etching_id"], name: "index_prints_on_etching_id", using: :btree

end
