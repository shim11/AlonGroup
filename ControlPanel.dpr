program ControlPanel;

uses
  Vcl.Forms,
  ControlPanelUnit in 'ControlPanelUnit.pas' {fmControlPanel};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmControlPanel, fmControlPanel);
  Application.Run;
end.
