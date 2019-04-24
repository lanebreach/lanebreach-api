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

ActiveRecord::Schema.define(version: 2019_04_11_041012) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "bikeway_networks", id: :integer, default: -> { "nextval('bikeway_networks_gid_seq'::regclass)" }, force: :cascade do |t|
    t.string "barrier", limit: 254
    t.string "biap", limit: 254
    t.string "buffered", limit: 254
    t.decimal "cnn"
    t.string "contraflow", limit: 254
    t.date "date_creat"
    t.string "time_creat", limit: 254
    t.string "created_us", limit: 254
    t.string "dir", limit: 254
    t.string "direct", limit: 254
    t.decimal "double"
    t.string "facility_t", limit: 254
    t.string "from_st", limit: 254
    t.decimal "fy"
    t.string "globalid", limit: 254
    t.string "greenwave", limit: 254
    t.decimal "install_mo"
    t.decimal "install_yr"
    t.date "date_last_"
    t.string "time_last_", limit: 254
    t.string "last_edite", limit: 254
    t.decimal "length"
    t.string "notes", limit: 254
    t.string "number", limit: 254
    t.decimal "objectid"
    t.decimal "qtr"
    t.string "raised", limit: 254
    t.decimal "shape_len"
    t.decimal "sharrow"
    t.string "sm_sweeper", limit: 254
    t.string "street", limit: 254
    t.string "streetname", limit: 254
    t.string "surface_tr", limit: 254
    t.string "symbology", limit: 254
    t.string "to_st", limit: 254
    t.decimal "update_mo"
    t.decimal "update_yr"
    t.geometry "geom", limit: {:srid=>4326, :type=>"multi_line_string"}
  end

  create_table "sf311_case_metadata", force: :cascade do |t|
    t.bigint "sf311_case_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "bikeway_network_id"
    t.index ["bikeway_network_id"], name: "index_sf311_case_metadata_on_bikeway_network_id"
    t.index ["sf311_case_id"], name: "index_sf311_case_metadata_on_sf311_case_id"
  end

  create_table "sf311_cases", force: :cascade do |t|
    t.integer "service_request_id"
    t.datetime "requested_datetime"
    t.datetime "closed_date"
    t.datetime "updated_datetime"
    t.string "status_description"
    t.string "status_notes"
    t.string "agency_responsible"
    t.string "service_name"
    t.string "service_subtype"
    t.string "service_details"
    t.string "address"
    t.integer "supervisor_district"
    t.string "neighborhoods_sffind_boundaries"
    t.string "police_district"
    t.float "lat"
    t.float "long"
    t.geography "point", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.string "point_city"
    t.string "source"
    t.string "point_state"
    t.string "point_address"
    t.string "point_zip"
    t.string "media_url_description"
    t.string "media_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "street"
    t.string "description"
    t.index ["requested_datetime"], name: "index_sf311_cases_on_requested_datetime"
    t.index ["service_request_id"], name: "index_sf311_cases_on_service_request_id", unique: true
  end

  create_table "sf_mta_ridership_counts", force: :cascade do |t|
    t.string "counter_location"
    t.string "days"
    t.integer "hour_of_collection_time"
    t.string "month_of_collection_time"
    t.integer "year_of_collection_time"
    t.integer "total_bike_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "sf311_case_metadata", "bikeway_networks"
  add_foreign_key "sf311_case_metadata", "sf311_cases"
end
