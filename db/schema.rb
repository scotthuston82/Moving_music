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

ActiveRecord::Schema.define(version: 20180220210548) do

  create_table "bookings", force: :cascade do |t|
    t.integer "musician_id"
    t.integer "client_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.text "client_review"
    t.text "musician_review"
    t.integer "party_size"
    t.string "age_range"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "confirmed", default: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "kind"
    t.string "profile_picture"
    t.text "bio"
    t.float "hourly_rate_in_cents"
    t.float "lat"
    t.float "long"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
  end

end
