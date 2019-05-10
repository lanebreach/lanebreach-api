Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  # SF 311 Case Queries:
  connection :sf311_cases_connection, Connections::Sf311CasesConnection do
    description 'Returns the SF 311 Cases that satisfy the specified conditions'

    argument :start_time, Types::DateTimeType
    argument :end_time, Types::DateTimeType
    argument :order_by, types.String, 'Column to order the results by', as: :order_by, default_value: :requested_datetime

    resolve -> (obj, args, ctx) {
      lane_blockages_query = Sf311Case.includes(:sf311_case_metadatum)

      if args[:start_time]
        lane_blockages_query =
          lane_blockages_query.where('requested_datetime >= ?', args[:start_time])
      end

      if args[:end_time]
        lane_blockages_query =
          lane_blockages_query.where('requested_datetime <= ?', args[:end_time])
      end

      lane_blockages_query.order(args[:order_by])
    }
  end

  # Bikeway Networks Queries:
  field :nearest_bikeway_network, types[Types::BikewayNetworkType] do
    description 'Find the nearest bikeway network'

    argument :lat, !types.Float
    argument :long, !types.Float
    argument :max_distance, types.Float

    resolve -> (obj, args, ctx) { BikewayNetwork.nearest(args[:lat], args[:long], args[:max_distance]) }
  end

  # SF MTA Ridership Counts
  connection :sf_mta_ridership_counts_connection, Connections::SfMtaRidershipCountsConnection do
    description 'Returns the SF MTA Ridership Counts that satisfy the specified conditions'

    argument :counter_location, types.String
    argument :days, types.Int
    argument :hour_of_collection, types.Int
    argument :month_of_collection, types.String
    argument :year_of_collection, types.Int
    argument :total_bike_count, types.Int

    argument :order_by, types.String, 'Column to order the results by', as: :order_by, default_value: :total_bike_count
    argument :sort_order, types.String, 'Ascending or descending ordering of sorted results', as: :sort_order, default_value: :desc

    resolve -> (obj, args, ctx) {
      ridership_count_query = SfMtaRidershipCount.order("#{args[:order_by]} #{args[:sort_order]}")

      ridership_count_query = ridership_count_query.where(counter_location: args[:counter_location]) if args[:counter_location]
      ridership_count_query = ridership_count_query.where(days: args[:days].upcase) if args[:days]
      ridership_count_query = ridership_count_query.where(hour_of_collection_time: args[:hour_of_collection_time]) if args[:hour_of_collection_time]
      ridership_count_query = ridership_count_query.where(month_of_collection_time: args[:month_of_collection_time].capitalize) if args[:month_of_collection_time]
      ridership_count_query = ridership_count_query.where(year_of_collection_time: args[:year_of_collection_time]) if args[:year_of_collection_time]
      ridership_count_query = ridership_count_query.where(total_bike_count: args[:total_bike_count]) if args[:total_bike_count]

      ridership_count_query
    }
  end
end
