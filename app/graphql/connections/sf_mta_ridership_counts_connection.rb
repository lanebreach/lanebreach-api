Connections::SfMtaRidershipCountsConnection = Types::SfMtaRidershipCountType.define_connection do
  name 'SfMtaRidershipCountsConnection'

  field :totalCount do
    type types.Int

    resolve -> (obj, _args, _ctx) {
      obj.nodes.count
    }
  end
end
