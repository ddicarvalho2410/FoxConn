unit ufrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, udmPrincipal, DB, Grids, DBGrids, ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Pedidos1: TMenuItem;
    Itens1: TMenuItem;
    Produtos1: TMenuItem;
    Lanamentos1: TMenuItem;
    grdCardapio: TDBGrid;
    dsCardapio: TDataSource;
    Panel1: TPanel;
    procedure Itens1Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure Lanamentos1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure grdCardapioDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  ufrmItens, ufrmProdutos, ufrmPedidos;

{$R *.dfm}

procedure TfrmPrincipal.FormActivate(Sender: TObject);
begin
  dmPrincipal.qryCardapio.Close;
  dmPrincipal.qryCardapio.Open;
end;

procedure TfrmPrincipal.grdCardapioDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (gdSelected in State) or (gdFocused in State) then
    TDBGrid(Sender).Canvas.Brush.Color := clGradientInactiveCaption
  else
  begin
    if copy(dmPrincipal.qryCardapioDESCRICAO.AsString,1,1) = 'L'then
      TDBGrid(Sender).Canvas.Brush.Color := $00BBFFBB
    else
      TDBGrid(Sender).Canvas.Brush.Color := $00A6FFFF;
  end;

  TDBGrid(Sender).Canvas.FillRect(Rect); // pinta a célula
  TDBGrid(Sender).DefaultDrawDataCell(rect,Column.Field,State); // pinta o texto padrão
end;

procedure TfrmPrincipal.Itens1Click(Sender: TObject);
begin
  try
    frmItens := TfrmItens.Create(Self);
    frmItens.ShowModal;
  finally
    FreeAndNil(frmItens);
  end;
end;

procedure TfrmPrincipal.Lanamentos1Click(Sender: TObject);
begin
  try
    frmPedidos := TfrmPedidos.Create(Self);
    frmPedidos.ShowModal;
  finally
    FreeAndNil(frmPedidos);
  end;
end;

procedure TfrmPrincipal.Produtos1Click(Sender: TObject);
begin
  try
    frmProdutos := TfrmProdutos.Create(Self);
    frmProdutos.ShowModal;
  finally
    FreeAndNil(frmProdutos);
  end;
end;

end.
