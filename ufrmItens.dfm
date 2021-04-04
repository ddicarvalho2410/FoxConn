inherited frmItens: TfrmItens
  Caption = 'Itens'
  ClientHeight = 378
  ClientWidth = 640
  ExplicitWidth = 646
  ExplicitHeight = 406
  PixelsPerInch = 96
  TextHeight = 15
  inherited pgcCadastro: TPageControl
    Width = 640
    Height = 378
    ActivePage = tbsConsulta
    inherited tbsConsulta: TTabSheet
      inherited pnlPesquisa: TPanel
        Width = 632
        inherited edtPesquisa: TEdit
          Width = 311
        end
        inherited cboIndice: TComboBox
          Items.Strings = (
            'Descri'#231#227'o'
            'ID')
        end
        inherited btnPesquisar: TBitBtn
          Left = 516
          OnClick = btnPesquisarClick
        end
      end
      inherited pnlGrid: TPanel
        Width = 632
        Height = 273
        ExplicitLeft = -104
        ExplicitTop = 81
        inherited grdPesquisa: TDBGrid
          Width = 630
          Height = 271
          Columns = <
            item
              Expanded = False
              FieldName = 'ID'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRICAO'
              Title.Caption = 'Descri'#231#227'o'
              Width = 383
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR'
              Title.Caption = 'Valor'
              Visible = True
            end>
        end
      end
    end
    inherited tbsCadastro: TTabSheet
      inherited ToolBar1: TToolBar
        Width = 632
        inherited nvgCadastro: TDBNavigator
          Hints.Strings = ()
        end
        inherited btnExcluir: TBitBtn
          OnClick = btnExcluirClick
        end
      end
      inherited pnlCadastro: TPanel
        Width = 632
        Height = 315
        ExplicitTop = 36
        object Label1: TLabel
          Left = 91
          Top = 72
          Width = 12
          Height = 15
          Caption = 'ID'
        end
        object Label2: TLabel
          Left = 91
          Top = 128
          Width = 55
          Height = 15
          Caption = 'Descri'#231#227'o'
        end
        object Label3: TLabel
          Left = 91
          Top = 184
          Width = 29
          Height = 15
          Caption = 'Valor'
        end
        object edtID: TDBEdit
          Left = 91
          Top = 88
          Width = 150
          Height = 23
          TabStop = False
          DataField = 'ID'
          DataSource = dtsCadastro
          ReadOnly = True
          TabOrder = 0
        end
        object edtDescricao: TDBEdit
          Left = 91
          Top = 144
          Width = 450
          Height = 23
          DataField = 'DESCRICAO'
          DataSource = dtsCadastro
          TabOrder = 1
        end
        object edtValor: TDBEdit
          Left = 91
          Top = 200
          Width = 150
          Height = 23
          DataField = 'VALOR'
          DataSource = dtsCadastro
          TabOrder = 2
        end
      end
    end
  end
  inherited dtsCadastro: TDataSource
    DataSet = dmPrincipal.cdsItens
  end
end
