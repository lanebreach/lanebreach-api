Connections::Sf311CasesConnection = Types::Sf311CaseType.define_connection do
  name 'Sf311CaseConnection'

  field :totalCount do
    type types.Int

    resolve -> (obj, _args, _ctx) {
      obj.nodes.count
    }
  end
end
