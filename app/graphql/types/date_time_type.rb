Types::DateTimeType = GraphQL::ScalarType.define do
  name 'DateTime'

  coerce_input ->(value, _ctx) { Time.zone.parse(value) }
  coerce_result ->(value, _ctx) { 
    return value.iso8601 if value.instance_of?(Date)
    value.utc.iso8601
  }
end
