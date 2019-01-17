Types::Sf311CaseMetadatumType = GraphQL::ObjectType.define do
  name Sf311CaseMetadatum.to_s

  field :sf311_case_id, !types.Int
  field :bikeway_network_id, types.Int
end
