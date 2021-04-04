unit ufrmPadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TfrmPadrao = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    FFormEdit: Boolean;
  published
    procedure SetFormEdit(const Value: Boolean); virtual;
  public
    property FormEdit: Boolean read FFormEdit write SetFormEdit;
  end;

var
  frmPadrao: TfrmPadrao;

implementation

{$R *.dfm}

{ TfrmPadrao }

procedure TfrmPadrao.FormCreate(Sender: TObject);
begin
  fFormEdit := False;
end;

procedure TfrmPadrao.SetFormEdit(const Value: Boolean);
begin
  FFormEdit := Value;
end;

end.
