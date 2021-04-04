program Teste_Diego;

uses
  Forms,
  udmPrincipal in 'udmPrincipal.pas' {dmPrincipal: TDataModule},
  ufrmPrincipal in 'ufrmPrincipal.pas' {frmPrincipal},
  ufrmPadrao in 'ufrmPadrao.pas' {frmPadrao},
  ufrmPadraoCadastro in 'ufrmPadraoCadastro.pas' {frmPadraoCadastro},
  ufrmItens in 'ufrmItens.pas' {frmItens},
  ufrmProdutos in 'ufrmProdutos.pas' {frmProdutos},
  ufrmPedidos in 'ufrmPedidos.pas' {frmPedidos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Teste_Diego';
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
