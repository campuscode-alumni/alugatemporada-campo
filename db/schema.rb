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

ActiveRecord::Schema.define(version: 20180310033738) do

  create_table "price_ranges", force: :cascade do |t|
    t.string "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal "daily_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "property_id"
    t.index ["property_id"], name: "index_price_ranges_on_property_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "title"
    t.integer "maximum_guests"
    t.integer "minimum_rent"
    t.integer "maximum_rent"
    t.decimal "daily_rate"
    t.string "rent_purpose"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "main_photo"
    t.text "description"
    t.string "neighborhood"
    t.boolean "accessibility"
    t.boolean "allow_pets"
    t.boolean "allow_smokers"
    t.integer "rooms"
    t.integer "property_location_id"
    t.integer "price_range_id"
    t.index ["price_range_id"], name: "index_properties_on_price_range_id"
    t.index ["property_location_id"], name: "index_properties_on_property_location_id"
  end

  create_table "property_locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
