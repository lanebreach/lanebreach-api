Types::Sf311CaseType = GraphQL::ObjectType.define do
  name Sf311Case.to_s

  field :service_request_id, !types.ID
  field :address, types.String
  field :agency_responsible, types.String
  field :closed_date, Types::DateTimeType
  field :lat, !types.Float
  field :long, !types.Float
  field :media_url, types.String
  field :media_url_description, types.String
  field :neighborhoods_sffind_boundaries, types.String
  field :point, Types::PointType
  field :point_address, types.String
  field :point_city, types.String
  field :point_state, types.String
  field :point_zip, types.String
  field :police_district, types.String
  field :requested_datetime, Types::DateTimeType
  field :service_details, types.String
  field :service_name, types.String
  field :service_subtype, types.String
  field :source, !types.String
  field :status_description, types.String
  field :status_notes, types.String
  field :supervisor_district, types.Int
  field :updated_datetime, Types::DateTimeType

  field :sf311_case_metadatum, Types::Sf311CaseMetadatumType
end
