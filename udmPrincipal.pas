unit udmPrincipal;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBCustomDataSet, DBClient, Provider,
  IBQuery, IniFiles, Forms, Windows;

type
  TdmPrincipal = class(TDataModule)
    cntPrincipal: TIBDatabase;
    trsPrincpal: TIBTransaction;
    qryItens: TIBQuery;
    dspItens: TDataSetProvider;
    cdsItens: TClientDataSet;
    qryItensID: TIntegerField;
    qryItensVALOR: TIBBCDField;
    cdsItensID: TIntegerField;
    cdsItensVALOR: TBCDField;
    qryProdutos: TIBQuery;
    dspProdutos: TDataSetProvider;
    cdsProdutos: TClientDataSet;
    qryProdutosID: TIntegerField;
    qryProdutosDESCRICAO: TIBStringField;
    qryProdutosVALOR: TIBBCDField;
    cdsProdutosID: TIntegerField;
    cdsProdutosDESCRICAO: TWideStringField;
    cdsProdutosVALOR: TBCDField;
    qryProduto_Itens: TIBQuery;
    dspProduto_Itens: TDataSetProvider;
    cdsProduto_Itens: TClientDataSet;
    qryProduto_ItensID: TIntegerField;
    qryProduto_ItensID_PRODUTO: TIntegerField;
    qryProduto_ItensID_ITENS: TIntegerField;
    qryProduto_ItensPRODUTO: TIBStringField;
    qryProduto_ItensITEM: TIBStringField;
    cdsProduto_ItensID: TIntegerField;
    cdsProduto_ItensID_PRODUTO: TIntegerField;
    cdsProduto_ItensID_ITENS: TIntegerField;
    cdsProduto_ItensPRODUTO: TWideStringField;
    cdsProduto_ItensITEM: TWideStringField;
    qryPedidos: TIBQuery;
    dspPedidos: TDataSetProvider;
    cdsPedidos: TClientDataSet;
    qryPedidos_Itens: TIBQuery;
    dspPedidos_Itens: TDataSetProvider;
    cdsPedidos_Itens: TClientDataSet;
    qryPedidosID: TIntegerField;
    qryPedidosVALOR_PROUTOS: TIBBCDField;
    qryPedidosVALOR_DESCONTO: TIBBCDField;
    qryPedidosVALOR_TOTAL: TIBBCDField;
    cdsPedidosID: TIntegerField;
    cdsPedidosVALOR_PROUTOS: TBCDField;
    cdsPedidosVALOR_DESCONTO: TBCDField;
    cdsPedidosVALOR_TOTAL: TBCDField;
    qryConsitens: TIBQuery;
    qryConsitensID: TIntegerField;
    qryConsitensDESCRICAO: TIBStringField;
    qryConsitensVALOR: TIBBCDField;
    qryProduto_ItensVALOR_ITEM: TIBBCDField;
    cdsProduto_ItensVALOR_ITEM: TBCDField;
    qryAux: TIBQuery;
    qryPedidos_ItensID: TIntegerField;
    qryPedidos_ItensID_PEDIDO: TIntegerField;
    qryPedidos_ItensID_PRODUTO: TIntegerField;
    qryPedidos_ItensID_ITENS: TIntegerField;
    qryPedidos_ItensDESCRICAO: TIBStringField;
    qryPedidos_ItensVALOR_PRODUTO: TIBBCDField;
    qryPedidos_ItensVALOR_ITEM: TIBBCDField;
    cdsPedidos_ItensID: TIntegerField;
    cdsPedidos_ItensID_PEDIDO: TIntegerField;
    cdsPedidos_ItensID_PRODUTO: TIntegerField;
    cdsPedidos_ItensID_ITENS: TIntegerField;
    cdsPedidos_ItensDESCRICAO: TWideStringField;
    cdsPedidos_ItensVALOR_PRODUTO: TBCDField;
    cdsPedidos_ItensVALOR_ITEM: TBCDField;
    qryItensDESCRICAO: TIBStringField;
    cdsItensDESCRICAO: TWideStringField;
    qryCardapio: TIBQuery;
    qryCardapioDESCRICAO: TIBStringField;
    qryCardapioVALOR: TIBBCDField;
    procedure cdsProdutosAfterScroll(DataSet: TDataSet);
    procedure cdsPedidosAfterScroll(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetParam(pModulo, pParametro: String; pDefault: String = ''): String;
  end;

var
  dmPrincipal: TdmPrincipal;

implementation

{$R *.dfm}

procedure TdmPrincipal.cdsPedidosAfterScroll(DataSet: TDataSet);
begin
  cdsPedidos_Itens.Close;
  qryPedidos_Itens.ParamByName('ID_PEDIDO').AsInteger := cdsPedidosID.AsInteger;
  cdsPedidos_Itens.Open;
end;

procedure TdmPrincipal.cdsProdutosAfterScroll(DataSet: TDataSet);
begin
  cdsProduto_Itens.Close;
  qryProduto_Itens.ParamByName('ID').AsInteger := cdsProdutosID.AsInteger;
  cdsProduto_Itens.Open;
end;

procedure TdmPrincipal.DataModuleCreate(Sender: TObject);
var
  vLocal: String;
begin
  vLocal := GetParam('BD','LOCAL');
  if vLocal <> EmptyStr then
  begin
    cntPrincipal.Connected := False;
    cntPrincipal.DatabaseName := vLocal;
  end
  else
    Application.terminate;

end;

function TdmPrincipal.GetParam(pModulo, pParametro, pDefault: String): String;
var
  xIni: TiniFile;
begin
  try
    if FileExists('./Teste_Diego.ini') then
    begin
      xIni := TiniFile.Create('./Teste_Diego.ini');
      Result := xIni.ReadString(pModulo,pParametro,pDefault);
    end
    else
    begin
      MessageBox(0, 'Arquivo Teste_Diego.ini não econtrado.', 'Teste_Diego', MB_ICONERROR or MB_OK);
    end;
  finally
    FreeAndNil(xIni);
  end;

end;

end.
