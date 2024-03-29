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

ActiveRecord::Schema.define(version: 20140116053929) do

  create_table "attachments", force: true do |t|
    t.integer "campaign_id"
    t.string  "type"
    t.string  "name"
  end

  create_table "books", force: true do |t|
    t.string "title"
  end

  create_table "campaigns", force: true do |t|
    t.string "name"
  end

  create_table "covers", force: true do |t|
    t.integer "book_id"
    t.string  "color"
  end

  create_table "manufacturers", force: true do |t|
    t.string "name"
  end

  create_table "vehicles", force: true do |t|
    t.integer "manufacturer_id"
    t.string  "name"
  end

end
