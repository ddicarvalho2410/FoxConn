object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Teste_Diego'
  ClientHeight = 710
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object grdCardapio: TDBGrid
    Left = 0
    Top = 41
    Width = 1008
    Height = 669
    Align = alClient
    DataSource = dsCardapio
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = grdCardapioDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Caption = 'Descri'#231#227'o'
        Width = 825
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Title.Caption = 'Valor'
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1008
    Height = 41
    Align = alTop
    Caption = 'Card'#225'pio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitWidth = 744
  end
  object MainMenu1: TMainMenu
    Left = 408
    Top = 224
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Itens1: TMenuItem
        Caption = 'Itens'
        OnClick = Itens1Click
      end
      object Produtos1: TMenuItem
        Caption = 'Produtos'
        OnClick = Produtos1Click
      end
    end
    object Pedidos1: TMenuItem
      Caption = 'Pedidos'
      object Lanamentos1: TMenuItem
        Caption = 'Lan'#231'amentos'
        OnClick = Lanamentos1Click
      end
    end
  end
  object dsCardapio: TDataSource
    DataSet = dmPrincipal.qryCardapio
    Left = 320
    Top = 272
  end
end
