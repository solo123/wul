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

ActiveRecord::Schema.define(version: 20130829043233) do

  create_table "invests", force: true do |t|
    t.string   "jkbh"
    t.string   "jybh"
    t.string   "dz"
    t.string   "jkyt"
    t.string   "jkyssm"
    t.string   "xydj"
    t.string   "nhll"
    t.string   "jkje"
    t.string   "hkqx"
    t.string   "hkfs"
    t.datetime "jssj"
    t.string   "bz"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notices", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "creator_id"
    t.integer  "approval_id"
    t.datetime "release_time"
    t.datetime "expiration_time"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
