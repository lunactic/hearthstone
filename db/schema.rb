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

ActiveRecord::Schema.define(version: 20131019164115) do

  create_table "cards", force: true do |t|
    t.string   "name"
    t.string   "card_class"
    t.string   "card_type"
    t.string   "rarity"
    t.integer  "cost"
    t.integer  "attack"
    t.integer  "health"
    t.integer  "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stat_entries", force: true do |t|
    t.string   "hero"
    t.string   "opp_hero"
    t.string   "game_mode"
    t.string   "result"
    t.boolean  "first"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
