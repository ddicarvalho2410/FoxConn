unit ufrmPadraoCadastro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmPadrao, Grids, DBGrids, ExtCtrls, DBCtrls, ToolWin, ComCtrls, StdCtrls, Buttons, DB,
  udmPrincipal;

type
  TfrmPadraoCadastro = class(TfrmPadrao)
    pgcCadastro: TPageControl;
    tbsConsulta: TTabSheet;
    tbsCadastro: TTabSheet;
    ToolBar1: TToolBar;
    pnlPesquisa: TPanel;
    pnlGrid: TPanel;
    grdPesquisa: TDBGrid;
    lblPesquisa: TLabel;
    edtPesquisa: TEdit;
    lblIndice: TLabel;
    cboIndice: TComboBox;
    btnPesquisar: TBitBtn;
    dtsCadastro: TDataSource;
    nvgCadastro: TDBNavigator;
    btnCancelar: TBitBtn;
    btnSalvar: TBitBtn;
    btnExcluir: TBitBtn;
    btnAlterar: TBitBtn;
    btnIncluir: TBitBtn;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    pnlCadastro: TPanel;
    procedure grdPesquisaDblClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboIndiceCloseUp(Sender: TObject);
  private
  published
    procedure SetFormEdit(const Value: Boolean); override;
  public

  end;

var
  frmPadraoCadastro: TfrmPadraoCadastro;

implementation

{$R *.dfm}

procedure TfrmPadraoCadastro.btnAlterarClick(Sender: TObject);
begin
  inherited;
  FormEdit := True;
end;

procedure TfrmPadraoCadastro.btnCancelarClick(Sender: TObject);
begin
  inherited;
  FormEdit := False;
end;

procedure TfrmPadraoCadastro.btnIncluirClick(Sender: TObject);
begin
  inherited;
  FormEdit := True;
end;

procedure TfrmPadraoCadastro.btnSalvarClick(Sender: TObject);
begin
  inherited;
  FormEdit := False;
end;

procedure TfrmPadraoCadastro.cboIndiceCloseUp(Sender: TObject);
begin
  inherited;
  btnPesquisar.Click;
end;

procedure TfrmPadraoCadastro.FormCreate(Sender: TObject);
begin
  inherited;
  pgcCadastro.TabIndex := 0;
end;

procedure TfrmPadraoCadastro.FormShow(Sender: TObject);
begin
  inherited;
  if cboIndice.ItemIndex = -1 then
    cboIndice.ItemIndex := 0;

  btnPesquisar.Click;

  FormEdit := False;
end;

procedure TfrmPadraoCadastro.grdPesquisaDblClick(Sender: TObject);
begin
  inherited;
  if dtsCadastro.dataset.RecordCount > 0 then
    pgcCadastro.TabIndex := 1;
end;

procedure TfrmPadraoCadastro.SetFormEdit(const Value: Boolean);
begin
  Inherited;

  nvgCadastro.Enabled := not Value;

  btnIncluir.Enabled  := not Value;
  btnAlterar.Enabled  := not Value;
  btnExcluir.Enabled  := not Value;

  btnSalvar.Enabled   := Value;
  btnCancelar.Enabled := Value;

  pnlCadastro.Enabled := Value;

  Application.ProcessMessages;
end;

end.
