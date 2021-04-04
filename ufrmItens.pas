unit ufrmItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, udmPrincipal, ufrmPadraoCadastro, DB, ComCtrls, DBCtrls, ToolWin,
  Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, Mask, DBClient;

type
  TfrmItens = class(TfrmPadraoCadastro)
    edtID: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtDescricao: TDBEdit;
    Label3: TLabel;
    edtValor: TDBEdit;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar;
  public
    { Public declarations }
  end;

var
  frmItens: TfrmItens;

implementation

{$R *.dfm}

procedure TfrmItens.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dtsCadastro.DataSet.Edit;
  edtDescricao.SetFocus;
end;

procedure TfrmItens.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if (MessageDlg('Cancela inclusão/alteração?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    dtsCadastro.DataSet.Cancel;
    inherited;
  end;
end;

procedure TfrmItens.btnExcluirClick(Sender: TObject);
begin
  if (MessageDlg('Confirma exclusão?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    dtsCadastro.DataSet.Delete;
    TClientDataSet(dtsCadastro.DataSet).ApplyUpdates(-1);
    TClientDataSet(dtsCadastro.DataSet).Refresh;
    inherited;
  end;
end;

procedure TfrmItens.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dtsCadastro.DataSet.Append;
  edtDescricao.SetFocus;
end;

procedure TfrmItens.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

procedure TfrmItens.btnSalvarClick(Sender: TObject);
begin
  if (MessageDlg('Confirma inclusão/alteração?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    dtsCadastro.DataSet.Post;
    TClientDataSet(dtsCadastro.DataSet).ApplyUpdates(-1);
    TClientDataSet(dtsCadastro.DataSet).Refresh;
    inherited;
  end;
end;

procedure TfrmItens.Pesquisar;
begin
  dmPrincipal.cdsItens.Close;
  dmPrincipal.qryItens.SQL.Clear;
  dmPrincipal.qryItens.SQL.Add('SELECT * FROM ITENS');
  if Trim(edtPesquisa.Text) <> '' then
  begin
    if cboIndice.ItemIndex = 0 then //DESCRICAO
    begin
      dmPrincipal.qryItens.SQL.Add(' WHERE DESCRICAO LIKE ' + QuotedStr('%' + Trim(edtPesquisa.Text) + '%'));
      dmPrincipal.qryItens.SQL.Add(' ORDER BY DESCRICAO');
    end;
    if cboIndice.ItemIndex = 1 then //ID
    begin
      dmPrincipal.qryItens.SQL.Add(' WHERE ID = ' + Trim(edtPesquisa.Text));
      dmPrincipal.qryItens.SQL.Add(' ORDER BY ID');
    end;
  end;

  try
    dmPrincipal.cdsItens.Open;
  except
    on e:exception do
      MessageDlg('Erro ao pesquisar item:' + e.Message, mtError, [mbOK], 0);
  end;
end;

end.
