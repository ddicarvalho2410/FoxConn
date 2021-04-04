unit ufrmProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, udmPrincipal, ufrmPadraoCadastro, DB, ComCtrls, DBCtrls, ToolWin,
  Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, Mask, DBClient;

type
  TfrmProdutos = class(TfrmPadraoCadastro)
    edtID: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtDescricao: TDBEdit;
    Label3: TLabel;
    edtValor: TDBEdit;
    dtsProdutos_Itens: TDataSource;
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
    pnlItem: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    edtIDItem: TDBEdit;
    edtDescricaoItem: TDBEdit;
    DBGrid1: TDBGrid;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
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
    procedure TotalProduto(pIDProduto: Integer);
  public
    { Public declarations }
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.dfm}

procedure TfrmProdutos.btnIncluirItemClick(Sender: TObject);
begin
  SetEditItem(True);
  dmPrincipal.cdsProduto_Itens.Append;
  edtIDItem.SetFocus;
end;

procedure TfrmProdutos.btnAlterarItemClick(Sender: TObject);
begin
  SetEditItem(True);
  dmPrincipal.cdsProduto_Itens.Edit;
  edtIDItem.SetFocus;
end;

procedure TfrmProdutos.btnExcluirItemClick(Sender: TObject);
begin
  if (MessageDlg('Confirma exclusão do item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    dmPrincipal.cdsProduto_Itens.Delete;
    dmPrincipal.cdsProduto_Itens.ApplyUpdates(-1);
    dmPrincipal.cdsProduto_Itens.Refresh;

    TotalProduto(dmPrincipal.cdsProdutosID.AsInteger);
  end;
end;

procedure TfrmProdutos.btnSalvarItemClick(Sender: TObject);
begin
  inherited;
  if (MessageDlg('Confirma inclusão/alteração do item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    dmPrincipal.cdsProduto_ItensID_PRODUTO.AsInteger := dmPrincipal.cdsProdutosID.AsInteger;

    dmPrincipal.cdsProduto_Itens.Post;
    dmPrincipal.cdsProduto_Itens.ApplyUpdates(-1);
    dmPrincipal.cdsProduto_Itens.Refresh;

    TotalProduto(dmPrincipal.cdsProdutosID.AsInteger);

    dmPrincipal.cdsProdutosAfterScroll(dmPrincipal.cdsProdutos);

    SetEditItem(False);
  end;
end;

procedure TfrmProdutos.btnCancelarItemClick(Sender: TObject);
begin
  if (MessageDlg('Cancela inclusão/alteração do item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    dmPrincipal.cdsProduto_Itens.Cancel;
    SetEditItem(False);
  end;
end;

procedure TfrmProdutos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dtsCadastro.DataSet.Edit;
  edtDescricao.SetFocus;
end;

procedure TfrmProdutos.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if (MessageDlg('Cancela inclusão/alteração?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    dtsCadastro.DataSet.Cancel;
    inherited;
  end;
end;

procedure TfrmProdutos.btnExcluirClick(Sender: TObject);
begin
  if (MessageDlg('Confirma exclusão?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    dtsCadastro.DataSet.Delete;
    TClientDataSet(dtsCadastro.DataSet).ApplyUpdates(-1);
    TClientDataSet(dtsCadastro.DataSet).Refresh;
    inherited;
  end;
end;

procedure TfrmProdutos.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dtsCadastro.DataSet.Append;
  edtDescricao.SetFocus;
end;

procedure TfrmProdutos.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

procedure TfrmProdutos.btnSalvarClick(Sender: TObject);
begin
  if (MessageDlg('Confirma inclusão/alteração?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    dtsCadastro.DataSet.Post;
    TClientDataSet(dtsCadastro.DataSet).ApplyUpdates(-1);
    TClientDataSet(dtsCadastro.DataSet).Refresh;
    inherited;
  end;
end;

procedure TfrmProdutos.edtIDItemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_RETURN then
  begin
    dmPrincipal.qryConsitens.Close;
    dmPrincipal.qryConsitens.ParamByName('ID').AsInteger := strtointDef(edtIDItem.Text,0);
    dmPrincipal.qryConsitens.Open;

    if dmPrincipal.qryConsitens.IsEmpty then
    begin
      MessageDlg('Item não cadastrado.', mtWarning, [mbOK], 0);
      edtIDItem.SetFocus;
    end
    else
    begin
      dmPrincipal.cdsProduto_ItensID_ITENS.AsInteger := dmPrincipal.qryConsitensID.AsInteger;
      dmPrincipal.cdsProduto_ItensITEM.AsString      := dmPrincipal.qryConsitensDESCRICAO.AsString;
    end;
  end;
end;

procedure TfrmProdutos.Pesquisar;
begin
  dmPrincipal.cdsProdutos.Close;
  dmPrincipal.qryProdutos.SQL.Clear;
  dmPrincipal.qryProdutos.SQL.Add('SELECT * FROM PRODUTO');
  if Trim(edtPesquisa.Text) <> '' then
  begin
    if cboIndice.ItemIndex = 0 then //DESCRICAO
    begin
      dmPrincipal.qryProdutos.SQL.Add(' WHERE DESCRICAO LIKE ' + QuotedStr('%' + Trim(edtPesquisa.Text) + '%'));
      dmPrincipal.qryProdutos.SQL.Add(' ORDER BY DESCRICAO');
    end;
    if cboIndice.ItemIndex = 1 then //ID
    begin
      dmPrincipal.qryProdutos.SQL.Add(' WHERE ID = ' + Trim(edtPesquisa.Text));
      dmPrincipal.qryProdutos.SQL.Add(' ORDER BY ID');
    end;
  end;

  try
    dmPrincipal.cdsProdutos.Open;
  except
    on e:exception do
      MessageDlg('Erro ao pesquisar item:' + e.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmProdutos.SetEditItem(pEdit: Boolean);
begin
  btnIncluirItem.Enabled  := not pEdit;
  btnAlterarItem.Enabled  := not pEdit;
  btnExcluirItem.Enabled  := not pEdit;

  btnSalvarItem.Enabled   := pEdit;
  btnCancelarItem.Enabled := pEdit;
  pnlItem.Enabled         := pEdit;
end;

procedure TfrmProdutos.TotalProduto(pIDProduto: Integer);
begin
  dmPrincipal.qryAux.Close;
  dmPrincipal.qryAux.SQL.Clear;
  dmPrincipal.qryAux.SQL.Add('SELECT SUM(I.VALOR) AS TOTAL');
  dmPrincipal.qryAux.SQL.Add('  FROM PRODUTO_ITENS PI');
  dmPrincipal.qryAux.SQL.Add(' INNER JOIN ITENS I ON I.ID = PI.ID_ITENS');
  dmPrincipal.qryAux.SQL.Add(' WHERE PI.ID_PRODUTO = ' + inttostr(pIDProduto));
  dmPrincipal.qryAux.Open;

  dmPrincipal.cdsProdutos.Edit;
  dmPrincipal.cdsProdutosVALOR.AsFloat := dmPrincipal.qryAux.FieldByName('TOTAL').AsFloat;
  dmPrincipal.cdsProdutos.Post;
  dmPrincipal.cdsProdutos.ApplyUpdates(-1);
end;

end.
