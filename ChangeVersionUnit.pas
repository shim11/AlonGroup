unit ChangeVersionUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, GifImg, MyFunctions, ShellApi, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Moni.Base, FireDAC.Moni.FlatFile,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Data.DB;

type
  TfmCv = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Image1: TImage;
    lbAppUp: TLabel;
    Timer1: TTimer;
    AlonDb: TFDConnection;
    // AlonDb: TFdConnection;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Gif: GifImg.TGifImage;
    cmdStr, dbName: String;
  end;

var
  fmCv: TfmCv;

implementation

{$R *.dfm}

procedure TfmCv.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TfmCv.FormCreate(Sender: TObject);
begin
  Gif := GifImg.TGifImage.Create;
  Gif.LoadFromFile('c:\cp\200.gif');
  Gif.Animate := True;
  Gif.AnimationSpeed := 100;
  Image1.Picture.Assign(Gif);
  dbName := ParamStr(1);
  cmdStr := ParamStr(2);
  if (dbName <> '') then
    with AlonDb do
    begin
      Connected := False;
      Params.Database := dbName;
      Params.UserName := 'alon';
      Params.Password := 'ag1616';
      DriverName := 'PG';
      Connected := True;
    end;
end;

procedure TfmCv.Timer1Timer(Sender: TObject);
begin
  lbAppUp.Font.Color := lbAppUp.Font.Color + 3;
  if (retStrFieldValue(AlonDb, 'select userapp from tools_logged_users where userid=' + QuotedStr('CP')) = 'RUN') then
  begin
    ShellExecute(Handle, 'open', PWideChar(cmdStr), nil, nil, 1);
    Timer1.Enabled := False;
    close;
  end;
end;

end.
