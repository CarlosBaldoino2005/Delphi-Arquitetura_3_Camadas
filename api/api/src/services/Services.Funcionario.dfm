inherited ServiceFuncionario: TServiceFuncionario
  Width = 319
  inherited FDConnection: TFDConnection
    Connected = True
  end
  object qryFuncionarios: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select id, nome, salario '
      '  from funcionarios')
    Left = 200
    Top = 56
    object qryFuncionariosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryFuncionariosnome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 100
    end
    object qryFuncionariossalario: TFloatField
      FieldName = 'salario'
      Origin = 'salario'
    end
  end
end
