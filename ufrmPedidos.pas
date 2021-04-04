unit ufrmPedidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, udmPrincipal, ufrmPadraoCadastro, DB, ComCtrls, DBCtrls, ToolWin,
  Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, Mask, DBClient;

type
  TfrmPedidos = class(TfrmPadraoCadastro)
    edtID: TDBEdit;
    Label1: TLabel;
    Label3: TLabel;
    edtValor: TDBEdit;
    dtsPedidos_Itens: TDataSource;
    pnlItens: TPanel;
    ToolBar2: TToolBar;
    DBNavigator1: TDBNavigator;
    ToolButton3: TToolButton;
    btnIncluirItem: TBitBtn;
    btnAlterarItem: TBitBtn;
    btnExcluirItem: TBitBtn;
    ToolButton4: TToolButton;
    btnSalvarItem: TBitBtn;
    btnCancelarItem: TBitBtn;
    pnlitem: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    edtIDItem: TEdit;
    edtDescricaoItem: TEdit;
    rdgTipo: TRadioGroup;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    DBEdit2: TDBEdit;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtIDItemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncluirItemClick(Sender: TObject);
    procedure btnAlterarItemClick(Sender: TObject);
    procedure btnExcluirItemClick(Sender: TObject);
    procedure btnSalvarItemClick(Sender: TObject);
    procedure btnCancelarItemClick(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar;
    procedure SetEditItem(pEdit: Boolean);
    procedure TotalPedido(pIDPedido: Integer);
  public
    { Public declarations }
  end;

var
  frmPedidos: TfrmPedidos;

implementation

{$R *.dfm}

procedure TfrmPedidos.btnIncluirItemClick(Sender: TObject);
begin
  SetEditItem(True);
  dmPrincipal.cdsPedidos_Itens.Append;
  edtIDItem.SetFocus;
end;

procedure TfrmPedidos.btnAlterarItemClick(Sender: TObject);
begin
  SetEditItem(True);
  dmPrincipal.cdsPedidos_Itens.Append;
  rdgTipo.SetFocus;
end;

procedure TfrmPedidos.btnExcluirItemClick(Sender: TObject);
begin
  if (MessageDlg('Confirma exclusão do item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    dmPrincipal.cdsPedidos_Itens.Delete;
    dmPrincipal.cdsPedidos_Itens.ApplyUpdates(-1);
    dmPrincipal.cdsPedidos_Itens.Refresh;

    TotalPedido(dmPrincipal.cdsPedidosID.AsInteger);
  end;
end;

procedure TfrmPedidos.btnSalvarItemClick(Sender: TObject);
begin
  inherited;
  if (MessageDlg('Confirma inclusão/alteração do item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    dmPrincipal.cdsPedidos_ItensID_PEDIDO.AsInteger := dmPrincipal.cdsPedidosID.AsInteger;

    dmPrincipal.cdsPedidos_Itens.Post;
    dmPrincipal.cdsPedidos_Itens.ApplyUpdates(-1);
    dmPrincipal.cdsPedidos_Itens.Refresh;

    TotalPedido(dmPrincipal.cdsPedidosID.AsInteger);

    SetEditItem(False);
  end;
end;

procedure TfrmPedidos.btnCancelarItemClick(Sender: TObject);
begin
  if (MessageDlg('Cancela inclusão/alteração do item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    dmPrincipal.cdsProduto_Itens.Cancel;
    SetEditItem(False);
  end;
end;

procedure TfrmPedidos.btnCancelarClick(Sender: TObject);
begin
  dtsCadastro.DataSet.Cancel;
  inherited;
end;

procedure TfrmPedidos.btnExcluirClick(Sender: TObject);
begin
  if (MessageDlg('Confirma exclusão?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    dtsCadastro.DataSet.Delete;
    TClientDataSet(dtsCadastro.DataSet).ApplyUpdates(-1);
    TClientDataSet(dtsCadastro.DataSet).Refresh;
    inherited;
  end;
end;

procedure TfrmPedidos.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dtsCadastro.DataSet.Append;
  dmPrincipal.cdsPedidosVALOR_PROUTOS.AsFloat  := 0;
  dmPrincipal.cdsPedidosVALOR_DESCONTO.AsFloat := 0;
  dmPrincipal.cdsPedidosVALOR_TOTAL.AsFloat    := 0;

  dmPrincipal.cdsPedidos.Post;
  dmPrincipal.cdsPedidos.ApplyUpdates(-1);
  dmPrincipal.cdsPedidos.Refresh;

  btnIncluirItem.Click;
end;

procedure TfrmPedidos.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

procedure TfrmPedidos.edtIDItemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_RETURN then
  begin
    dmPrincipal.qryAux.Close;
    dmPrincipal.qryAux.SQL.Clear;
    dmPrincipal.qryAux.SQL.Add('SELECT *');
    if rdgTipo.ItemIndex = 0 then
      dmPrincipal.qryAux.SQL.Add('  FROM PRODUTO')
    else
      dmPrincipal.qryAux.SQL.Add('  FROM ITENS');

    dmPrincipal.qryAux.SQL.Add(' WHERE ID = :ID');
    dmPrincipal.qryAux.ParamByName('ID').AsInteger := StrToIntDef(edtIDItem.Text,0);
    dmPrincipal.qryAux.Open;

    if dmPrincipal.qryAux.IsEmpty then
    begin
      MessageDlg('Item não cadastrado.', mtWarning, [mbOK], 0);
      edtIDItem.SetFocus;
    end
    else
    begin
      if rdgTipo.ItemIndex = 0 then
        dmPrincipal.cdsPedidos_ItensID_PRODUTO.AsInteger := dmPrincipal.qryAux.FieldByName('ID').AsInteger
      else
        dmPrincipal.cdsPedidos_ItensID_ITENS.AsInteger := dmPrincipal.qryAux.FieldByName('ID').AsInteger;

      edtDescricaoItem.Text := dmPrincipal.qryAux.FieldByName('DESCRICAO').AsString;
      dmPrincipal.cdsPedidos_ItensDESCRICAO.AsString := dmPrincipal.qryAux.FieldByName('DESCRICAO').AsString;
    end;
  end;
end;

procedure TfrmPedidos.Pesquisar;
begin
  dmPrincipal.cdsPedidos.Close;
  dmPrincipal.qryPedidos.SQL.Clear;
  dmPrincipal.qryPedidos.SQL.Add('SELECT * FROM PEDIDOS');
  if Trim(edtPesquisa.Text) <> '' then
  begin
    if cboIndice.ItemIndex = 0 then //ID
    begin
      dmPrincipal.qryPedidos.SQL.Add(' WHERE ID = ' + Trim(edtPesquisa.Text));
      dmPrincipal.qryPedidos.SQL.Add(' ORDER BY ID');
    end;
  end;

  try
    dmPrincipal.cdsPedidos.Open;
  except
    on e:exception do
      MessageDlg('Erro ao pesquisar item:' + e.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmPedidos.SetEditItem(pEdit: Boolean);
begin
  btnIncluirItem.Enabled  := not pEdit;
  btnAlterarItem.Enabled  := not pEdit;
  btnExcluirItem.Enabled  := not pEdit;

  btnSalvarItem.Enabled   := pEdit;
  btnCancelarItem.Enabled := pEdit;
  pnlitem.Enabled         := pEdit;
end;

procedure TfrmPedidos.TotalPedido(pIDPedido: Integer);
begin
  dmPrincipal.cdsPedidos.Edit;

  dmPrincipal.qryAux.Close;
  dmPrincipal.qryAux.SQL.Clear;
  dmPrincipal.qryAux.SQL.Add('SELECT SUM(COALESCE(P.VALOR,0)) + SUM(COALESCE(I.VALOR,0)) AS TOTAL');
  dmPrincipal.qryAux.SQL.Add('  FROM PEDIDOS_ITENS PI');
  dmPrincipal.qryAux.SQL.Add('  LEFT JOIN PRODUTO P ON P.ID = PI.ID_PRODUTO');
  dmPrincipal.qryAux.SQL.Add('  LEFT JOIN ITENS I ON I.ID = PI.ID_ITENS');
  dmPrincipal.qryAux.SQL.Add(' WHERE PI.ID_PEDIDO = :ID_PEDIDO');
  dmPrincipal.qryAux.ParamByName('ID_PEDIDO').AsInteger := pIDPedido;
  dmPrincipal.qryAux.Open;

  dmPrincipal.cdsPedidosVALOR_PROUTOS.AsFloat := dmPrincipal.qryAux.FieldByName('TOTAL').AsFloat;

  dmPrincipal.qryAux.Close;
  dmPrincipal.qryAux.SQL.Clear;
  dmPrincipal.qryAux.SQL.Add('SELECT COUNT(1) AS QTD_PRODUTOS');
  dmPrincipal.qryAux.SQL.Add('  FROM PEDIDOS_ITENS PI');
  dmPrincipal.qryAux.SQL.Add(' WHERE PI.ID_PEDIDO = :ID_PEDIDO');
  dmPrincipal.qryAux.SQL.Add('   AND PI.ID_PRODUTO IS NOT NULL');
  dmPrincipal.qryAux.ParamByName('ID_PEDIDO').AsInteger := pIDPedido;
  dmPrincipal.qryAux.Open;

  dmPrincipal.cdsPedidosVALOR_DESCONTO.AsFloat := 0;

  if dmPrincipal.qryAux.FieldByName('QTD_PRODUTOS').AsInteger = 2 then
    dmPrincipal.cdsPedidosVALOR_DESCONTO.AsFloat := dmPrincipal.cdsPedidosVALOR_PROUTOS.AsFloat * 0.03
  else if (dmPrincipal.qryAux.FieldByName('QTD_PRODUTOS').AsInteger >= 3) and
          (dmPrincipal.qryAux.FieldByName('QTD_PRODUTOS').AsInteger < 5)
  then
    dmPrincipal.cdsPedidosVALOR_DESCONTO.AsFloat := dmPrincipal.cdsPedidosVALOR_PROUTOS.AsFloat * 0.05
  else if (dmPrincipal.qryAux.FieldByName('QTD_PRODUTOS').AsInteger >= 5) then
    dmPrincipal.cdsPedidosVALOR_DESCONTO.AsFloat := dmPrincipal.cdsPedidosVALOR_PROUTOS.AsFloat * 0.1;

  dmPrincipal.cdsPedidosVALOR_TOTAL.AsFloat := dmPrincipal.cdsPedidosVALOR_PROUTOS.AsFloat - dmPrincipal.cdsPedidosVALOR_DESCONTO.AsFloat;

  dmPrincipal.cdsPedidos.Post;
  dmPrincipal.cdsPedidos.ApplyUpdates(-1);
end;

end.
