Types::PointType = GraphQL::ScalarType.define do
  name 'Point'
  description 'The Point type represents a geo point with a latitude-longitude value pair.'

  coerce_input ->(value, _ctx) { value }
  coerce_result ->(value, _ctx) { RGeo::GeoJSON.encode(value) }
end
