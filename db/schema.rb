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

ActiveRecord::Schema.define(version: 20131025020218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "city_data", force: true do |t|
    t.string   "zip_code"
    t.string   "neighborhood"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservations", force: true do |t|
    t.integer  "user_id"
    t.integer  "spot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "date"
    t.integer  "renter_id"
    t.boolean  "notification", default: false
  end

  add_index "reservations", ["date"], name: "index_reservations_on_date", using: :btree

  create_table "spots", force: true do |t|
    t.integer  "user_id"
    t.integer  "price"
    t.string   "image"
    t.text     "description"
    t.string   "location_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street"
    t.string   "zip_code"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "start_date"
    t.text     "end_date"
  end

  add_index "spots", ["zip_code"], name: "index_spots_on_zip_code", using: :btree

  create_table "users", force: true do |t|
    t.integer  "spot_id"
    t.string   "password_digest"
    t.string   "password_confirmation"
    t.string   "email"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "notification",          default: false
  end

end
