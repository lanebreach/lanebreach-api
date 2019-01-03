class AddSf311CasesData < ActiveRecord::Migration[5.2]
  def change
    create_table :sf311_cases do |t|
      t.integer :service_request_id
      t.datetime :requested_datetime
      t.datetime :closed_date
      t.datetime :updated_datetime
      t.string :status_description
      t.string :status_notes
      t.string :agency_responsible
      t.string :service_name
      t.string :service_subtype
      t.string :service_details
      t.string :address
      t.integer :supervisor_district
      t.string :neighborhoods_sffind_boundaries
      t.string :police_district
      t.float :lat
      t.float :long
      t.st_point :point, geographic: true
      t.string :point_city
      t.string :source
      t.string :point_state
      t.string :point_address
      t.string :point_zip
      t.string :media_url_description
      t.string :media_url
      t.timestamps
    end
  end
end
