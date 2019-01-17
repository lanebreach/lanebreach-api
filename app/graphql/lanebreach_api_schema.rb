class LanebreachApiSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  default_max_page_size(25)
end
