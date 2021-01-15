program ChangeVersion;

uses
  Vcl.Forms,
  ChangeVersionUnit in 'ChangeVersionUnit.pas' {fmCv};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.CreateForm(TfmCv, fmCv);
  Application.Run;
end.
