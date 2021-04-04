object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 482
  Width = 819
  object cntPrincipal: TIBDatabase
    Connected = True
    DatabaseName = 'C:\Personal\Teste_Diego\TESTE_DIEGO.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    Left = 80
    Top = 64
  end
  object trsPrincpal: TIBTransaction
    Active = True
    DefaultDatabase = cntPrincipal
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 80
    Top = 128
  end
  object qryItens: TIBQuery
    Database = cntPrincipal
    Transaction = trsPrincpal
    SQL.Strings = (
      'SELECT * FROM ITENS')
    Left = 192
    Top = 64
    object qryItensID: TIntegerField
      FieldName = 'ID'
      Origin = '"ITENS"."ID"'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryItensDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Origin = '"ITENS"."DESCRICAO"'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object qryItensVALOR: TIBBCDField
      FieldName = 'VALOR'
      Origin = '"ITENS"."VALOR"'
      ProviderFlags = [pfInUpdate]
      Precision = 18
      Size = 2
    end
  end
  object dspItens: TDataSetProvider
    DataSet = qryItens
    Options = [poAutoRefresh, poPropogateChanges, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 192
    Top = 128
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItens'
    Left = 192
    Top = 192
    object cdsItensID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object cdsItensDESCRICAO: TWideStringField
      FieldName = 'DESCRICAO'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsItensVALOR: TBCDField
      FieldName = 'VALOR'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = '#,###,##0.00'
      EditFormat = '#,###,##0.00'
      Precision = 18
      Size = 2
    end
  end
  object qryProdutos: TIBQuery
    Database = cntPrincipal
    Transaction = trsPrincpal
    SQL.Strings = (
      'SELECT * FROM PRODUTO')
    Left = 280
    Top = 64
    object qryProdutosID: TIntegerField
      FieldName = 'ID'
      Origin = '"PRODUTO"."ID"'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryProdutosDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Origin = '"PRODUTO"."DESCRICAO"'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object qryProdutosVALOR: TIBBCDField
      FieldName = 'VALOR'
      Origin = '"PRODUTO"."VALOR"'
      ProviderFlags = [pfInUpdate]
      Precision = 18
      Size = 2
    end
  end
  object dspProdutos: TDataSetProvider
    DataSet = qryProdutos
    Options = [poAutoRefresh, poPropogateChanges, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 280
    Top = 120
  end
  object cdsProdutos: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspProdutos'
    AfterScroll = cdsProdutosAfterScroll
    Left = 280
    Top = 192
    object cdsProdutosID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object cdsProdutosDESCRICAO: TWideStringField
      FieldName = 'DESCRICAO'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsProdutosVALOR: TBCDField
      FieldName = 'VALOR'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = '#,###,##0.00'
      EditFormat = '#,###,##0.00'
      Precision = 18
      Size = 2
    end
  end
  object qryProduto_Itens: TIBQuery
    Database = cntPrincipal
    Transaction = trsPrincpal
    SQL.Strings = (
      'SELECT PI.*,'
      '       P.DESCRICAO AS PRODUTO,'
      '       I.DESCRICAO AS ITEM,'
      '       I.VALOR AS VALOR_ITEM'
      '  FROM PRODUTO_ITENS PI'
      ' INNER JOIN PRODUTO P ON P.ID = PI.ID_PRODUTO'
      ' INNER JOIN ITENS I ON I.ID = PI.ID_ITENS'
      ' WHERE P.ID = :ID')
    Left = 376
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
    object qryProduto_ItensID: TIntegerField
      FieldName = 'ID'
      Origin = '"PRODUTO_ITENS"."ID"'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryProduto_ItensID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
      Origin = '"PRODUTO_ITENS"."ID_PRODUTO"'
      ProviderFlags = [pfInUpdate]
    end
    object qryProduto_ItensID_ITENS: TIntegerField
      FieldName = 'ID_ITENS'
      Origin = '"PRODUTO_ITENS"."ID_ITENS"'
      ProviderFlags = [pfInUpdate]
    end
    object qryProduto_ItensPRODUTO: TIBStringField
      FieldName = 'PRODUTO'
      Origin = '"PRODUTO"."DESCRICAO"'
      ProviderFlags = []
      Size = 100
    end
    object qryProduto_ItensITEM: TIBStringField
      FieldName = 'ITEM'
      Origin = '"ITENS"."DESCRICAO"'
      ProviderFlags = []
      Size = 100
    end
    object qryProduto_ItensVALOR_ITEM: TIBBCDField
      FieldName = 'VALOR_ITEM'
      Origin = '"ITENS"."VALOR"'
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
  end
  object dspProduto_Itens: TDataSetProvider
    DataSet = qryProduto_Itens
    Options = [poAutoRefresh, poPropogateChanges, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 376
    Top = 120
  end
  object cdsProduto_Itens: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspProduto_Itens'
    Left = 376
    Top = 192
    object cdsProduto_ItensID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object cdsProduto_ItensID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
      ProviderFlags = [pfInUpdate]
    end
    object cdsProduto_ItensID_ITENS: TIntegerField
      FieldName = 'ID_ITENS'
      ProviderFlags = [pfInUpdate]
    end
    object cdsProduto_ItensPRODUTO: TWideStringField
      FieldName = 'PRODUTO'
      ProviderFlags = []
      Size = 100
    end
    object cdsProduto_ItensITEM: TWideStringField
      FieldName = 'ITEM'
      ProviderFlags = []
      Size = 100
    end
    object cdsProduto_ItensVALOR_ITEM: TBCDField
      FieldName = 'VALOR_ITEM'
      ProviderFlags = []
      DisplayFormat = '#,###,##0.00'
      EditFormat = '#,###,##0.00'
      Precision = 18
      Size = 2
    end
  end
  object qryPedidos: TIBQuery
    Database = cntPrincipal
    Transaction = trsPrincpal
    SQL.Strings = (
      'SELECT * FROM PEDIDOS')
    Left = 488
    Top = 64
    object qryPedidosID: TIntegerField
      FieldName = 'ID'
      Origin = '"PEDIDOS"."ID"'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryPedidosVALOR_PROUTOS: TIBBCDField
      FieldName = 'VALOR_PROUTOS'
      Origin = '"PEDIDOS"."VALOR_PROUTOS"'
      ProviderFlags = [pfInUpdate]
      Precision = 18
      Size = 2
    end
    object qryPedidosVALOR_DESCONTO: TIBBCDField
      FieldName = 'VALOR_DESCONTO'
      Origin = '"PEDIDOS"."VALOR_DESCONTO"'
      ProviderFlags = [pfInUpdate]
      Precision = 18
      Size = 2
    end
    object qryPedidosVALOR_TOTAL: TIBBCDField
      FieldName = 'VALOR_TOTAL'
      Origin = '"PEDIDOS"."VALOR_TOTAL"'
      ProviderFlags = [pfInUpdate]
      Precision = 18
      Size = 2
    end
  end
  object dspPedidos: TDataSetProvider
    DataSet = qryPedidos
    Options = [poAutoRefresh, poPropogateChanges, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 488
    Top = 120
  end
  object cdsPedidos: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPedidos'
    AfterScroll = cdsPedidosAfterScroll
    Left = 488
    Top = 192
    object cdsPedidosID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object cdsPedidosVALOR_PROUTOS: TBCDField
      FieldName = 'VALOR_PROUTOS'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = '#,###,##0.00'
      EditFormat = '#,###,##0.00'
      Precision = 18
      Size = 2
    end
    object cdsPedidosVALOR_DESCONTO: TBCDField
      FieldName = 'VALOR_DESCONTO'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = '#,###,##0.00'
      EditFormat = '#,###,##0.00'
      Precision = 18
      Size = 2
    end
    object cdsPedidosVALOR_TOTAL: TBCDField
      FieldName = 'VALOR_TOTAL'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = '#,###,##0.00'
      EditFormat = '#,###,##0.00'
      Precision = 18
      Size = 2
    end
  end
  object qryPedidos_Itens: TIBQuery
    Database = cntPrincipal
    Transaction = trsPrincpal
    SQL.Strings = (
      'SELECT PI.*,'
      
        '       CASE WHEN PI.ID_PRODUTO IS NULL THEN I.DESCRICAO ELSE P.D' +
        'ESCRICAO END AS DESCRICAO,'
      '       P.VALOR AS VALOR_PRODUTO,'
      '       I.VALOR AS VALOR_ITEM       '
      '  FROM PEDIDOS_ITENS PI'
      ' LEFT JOIN PRODUTO P ON P.ID = PI.ID_PRODUTO'
      ' LEFT JOIN ITENS I ON I.ID = PI.ID_ITENS'
      ' WHERE PI.ID_PEDIDO = :ID_PEDIDO'
      ' ORDER BY PI.ID')
    Left = 600
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_PEDIDO'
        ParamType = ptUnknown
      end>
    object qryPedidos_ItensID: TIntegerField
      FieldName = 'ID'
      Origin = '"PEDIDOS_ITENS"."ID"'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryPedidos_ItensID_PEDIDO: TIntegerField
      FieldName = 'ID_PEDIDO'
      Origin = '"PEDIDOS_ITENS"."ID_PEDIDO"'
      ProviderFlags = [pfInUpdate]
    end
    object qryPedidos_ItensID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
      Origin = '"PEDIDOS_ITENS"."ID_PRODUTO"'
      ProviderFlags = [pfInUpdate]
    end
    object qryPedidos_ItensID_ITENS: TIntegerField
      FieldName = 'ID_ITENS'
      Origin = '"PEDIDOS_ITENS"."ID_ITENS"'
      ProviderFlags = [pfInUpdate]
    end
    object qryPedidos_ItensDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      ProviderFlags = []
      Size = 100
    end
    object qryPedidos_ItensVALOR_PRODUTO: TIBBCDField
      FieldName = 'VALOR_PRODUTO'
      Origin = '"PRODUTO"."VALOR"'
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
    object qryPedidos_ItensVALOR_ITEM: TIBBCDField
      FieldName = 'VALOR_ITEM'
      Origin = '"ITENS"."VALOR"'
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
  end
  object dspPedidos_Itens: TDataSetProvider
    DataSet = qryPedidos_Itens
    Options = [poAutoRefresh, poPropogateChanges, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 600
    Top = 120
  end
  object cdsPedidos_Itens: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPedidos_Itens'
    Left = 600
    Top = 192
    object cdsPedidos_ItensID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object cdsPedidos_ItensID_PEDIDO: TIntegerField
      FieldName = 'ID_PEDIDO'
      ProviderFlags = [pfInUpdate]
    end
    object cdsPedidos_ItensID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
      ProviderFlags = [pfInUpdate]
    end
    object cdsPedidos_ItensID_ITENS: TIntegerField
      FieldName = 'ID_ITENS'
      ProviderFlags = [pfInUpdate]
    end
    object cdsPedidos_ItensDESCRICAO: TWideStringField
      FieldName = 'DESCRICAO'
      ProviderFlags = []
      Size = 100
    end
    object cdsPedidos_ItensVALOR_PRODUTO: TBCDField
      FieldName = 'VALOR_PRODUTO'
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
    object cdsPedidos_ItensVALOR_ITEM: TBCDField
      FieldName = 'VALOR_ITEM'
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
  end
  object qryConsitens: TIBQuery
    Database = cntPrincipal
    Transaction = trsPrincpal
    SQL.Strings = (
      'SELECT * FROM ITENS'
      ' WHERE ID = :ID')
    Left = 192
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
    object qryConsitensID: TIntegerField
      FieldName = 'ID'
      Origin = '"ITENS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryConsitensDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Origin = '"ITENS"."DESCRICAO"'
      Size = 100
    end
    object qryConsitensVALOR: TIBBCDField
      FieldName = 'VALOR'
      Origin = '"ITENS"."VALOR"'
      Precision = 18
      Size = 2
    end
  end
  object qryAux: TIBQuery
    Database = cntPrincipal
    Transaction = trsPrincpal
    Left = 360
    Top = 280
  end
  object qryCardapio: TIBQuery
    Database = cntPrincipal
    Transaction = trsPrincpal
    SQL.Strings = (
      'SELECT '#39'LANCHE: '#39' || P.DESCRICAO AS DESCRICAO, P.VALOR'
      '  FROM PRODUTO P'
      'UNION ALL'
      'SELECT '#39'ADICIONAL: '#39' || I.DESCRICAO AS DESCRICAO, I.VALOR'
      '  FROM ITENS I')
    Left = 536
    Top = 328
    object qryCardapioDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      ProviderFlags = []
      Size = 111
    end
    object qryCardapioVALOR: TIBBCDField
      FieldName = 'VALOR'
      Origin = '"PRODUTO"."VALOR"'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '#,###,##0.00'
      Precision = 18
      Size = 2
    end
  end
end
