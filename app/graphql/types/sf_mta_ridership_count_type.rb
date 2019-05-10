Types::SfMtaRidershipCountType = GraphQL::ObjectType.define do
  name SfMtaRidershipCount.to_s

  field :counter_location, types.String
  field :days, types.String
  field :hour_of_collection_time, types.String
  field :month_of_collection_time, types.String
  field :total_bike_count, types.Int
  field :year_of_collection_time, types.Int
end
