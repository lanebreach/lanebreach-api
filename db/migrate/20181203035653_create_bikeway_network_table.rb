class CreateBikewayNetworkTable < ActiveRecord::Migration[5.2]
  def change
    create_table "bikeway_networks", primary_key: "gid", id: :serial, force: :cascade do |t|
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
  end
end
