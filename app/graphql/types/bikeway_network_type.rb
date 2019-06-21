Types::BikewayNetworkType = GraphQL::ObjectType.define do
  name BikewayNetwork.to_s

  field :barrier, types.String
  field :biap, types.String
  field :buffered, types.String
  field :cnn, types.Float
  field :contraflow, types.String
  field :created_us, types.String
  field :date_creat, Types::DateTimeType
  field :date_last_, Types::DateTimeType
  field :dir, types.String
  field :direct, types.String
  field :dist, types.Float
  field :double, types.Float
  field :facility_t, types.String
  field :from_st, types.String
  field :fy, types.Float
  field :geom, Types::PointType
  field :globalid, types.String
  field :greenwave, types.String
  field :id, types.Int
  field :install_mo, types.Int
  field :install_yr, types.Int
  field :last_edite, types.String
  field :length, types.Float
  field :notes, types.String
  field :number, types.String
  field :objectid, types.Int
  field :qtr, types.Float
  field :raised, types.Float
  field :shape_len, types.Float
  field :sharrow, types.Float
  field :sm_sweeper, types.String
  field :street, types.String
  field :streetname, types.String
  field :surface_tr, types.String
  field :symbology, types.String
  field :time_creat, types.String
  field :time_last_, types.String
  field :to_st, types.String
  field :update_mo, types.Int
  field :update_yr, types.Int  

  field :sf311_case_metadatum, Types::Sf311CaseMetadatumType
end
