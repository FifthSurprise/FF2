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

ActiveRecord::Schema.define(version: 20140417191955) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: true do |t|
    t.text     "question"
    t.text     "answer"
    t.integer  "stack_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recalls", force: true do |t|
    t.integer  "user_id"
    t.integer  "card_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "easiness_factor"
    t.integer  "quality_of_last_recall"
    t.integer  "repetition_interval"
    t.integer  "number_repetitions"
    t.datetime "next_repetition"
    t.datetime "last_studied"
  end

  create_table "stacks", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  create_table "user_stacks", force: true do |t|
    t.integer  "user_id"
    t.integer  "stack_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
