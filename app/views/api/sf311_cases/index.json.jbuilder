json.meta do
  json.current_page @lane_blockages.current_page
  json.next_page @lane_blockages.next_page
  json.prev_page @lane_blockages.previous_page
  json.total_pages @lane_blockages.total_pages
  json.total_count @lane_blockages.total_entries
  json.items_per_page @lane_blockages.per_page
end
json.data @lane_blockages do |lane_blockage|
  json.extract! lane_blockage, :id, :service_request_id, :requested_datetime, :closed_date, :updated_datetime, :status_description,
  :status_notes, :agency_responsible, :service_name, :service_subtype, :service_details, :address, :supervisor_district,
  :neighborhoods_sffind_boundaries, :police_district, :lat, :long, :source, :media_url, :description, :street
  
  if lane_blockage.sf311_case_metadatum.present?
    json.meta_data do
      json.bikeway_network_id lane_blockage.sf311_case_metadatum.bikeway_network_id
    end
  else
    json.meta_data nil
  end
end