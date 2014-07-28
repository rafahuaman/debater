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

ActiveRecord::Schema.define(version: 20140728110337) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "argument_posts", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "debate_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "position"
    t.integer  "parent_id"
  end

  add_index "argument_posts", ["debate_id", "user_id", "created_at"], name: "index_argument_posts_on_debate_id_and_user_id_and_created_at", using: :btree
  add_index "argument_posts", ["parent_id"], name: "index_argument_posts_on_parent_id", using: :btree

  create_table "chambers", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "chambers", ["user_id"], name: "index_chambers_on_user_id", using: :btree

  create_table "debates", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "affirmative"
    t.text     "negative"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "chamber_id"
  end

  add_index "debates", ["chamber_id"], name: "index_debates_on_chamber_id", using: :btree
  add_index "debates", ["user_id", "created_at"], name: "index_debates_on_user_id_and_created_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "votes", force: true do |t|
    t.string   "type"
    t.integer  "subject_id"
    t.integer  "value"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
