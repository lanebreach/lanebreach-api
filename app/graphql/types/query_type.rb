Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  # SF 311 Case Queries:
  connection :sf311_cases_connection, Connections::Sf311CasesConnection do
    description 'Returns the SF 311 Cases that took place within the specified date range'

    argument :start_time, Types::DateTimeType
    argument :end_time, Types::DateTimeType
    argument :order_by, types.String, 'Column to order the results by', as: :order_by, default_value: :requested_datetime

    resolve -> (obj, args, ctx) {
      lane_blockages_query = Sf311Case.bike_lane_blockage.includes(:sf311_case_metadatum)

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

    resolve -> (obj, args, ctx) { BikewayNetwork.nearest(args[:lat], args[:long]) }
  end
end
