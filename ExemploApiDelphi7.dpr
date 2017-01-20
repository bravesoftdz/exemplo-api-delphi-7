program ExemploApiDelphi7;

uses
  Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  uLkJSON in 'uLkJSON.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
