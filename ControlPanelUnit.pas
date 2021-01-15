unit ControlPanelUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Graphics, Controls, System.UITypes,
  Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient,
  Vcl.StdCtrls, Vcl.ExtCtrls, IdUDPServer, IdSocketHandle,
  IdGlobal, Vcl.Buttons, IOUtils, FireDAC.Phys.PGDef, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, MyFunctions, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  Vcl.ComCtrls, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Moni.Base, FireDAC.Moni.FlatFile,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, JvExDBGrids, JvDBGrid, Vcl.Mask, JvExMask, JvToolEdit,
  JvDBControls, JvExControls, JvDBLookup, JvAppStorage, JvComponentBase, JvFormPlacement, JvAppIniStorage;

type
  TfmControlPanel = class(TForm)
    controlSender: TIdUDPClient;
    Panel2: TPanel;
    controlReceiver: TIdUDPServer;
    dsLoggedUsers: TDataSource;
    dsUsersActivity: TDataSource;
    btnRefresh: TButton;
    TimerRefresh: TTimer;
    btnAinv: TBitBtn;
    btnOrders: TBitBtn;
    Timer2: TTimer;
    PageControl1: TPageControl;
    tsControlPanel: TTabSheet;
    Panel4: TPanel;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    mmChat: TMemo;
    Panel3: TPanel;
    btnSend: TButton;
    edSend: TEdit;
    cbAction: TComboBox;
    btnSendAll: TButton;
    btnChangeVersion: TButton;
    tsTimerSQLJobs: TTabSheet;
    HeaderControl1: THeaderControl;
    AlonDb: TFDConnection;
    tbLoggedUsers: TFDTable;
    tbLoggedUsersuserid: TWideStringField;
    tbLoggedUsersuserport: TIntegerField;
    tbLoggedUsersdateloggedin: TSQLTimeStampField;
    tbLoggedUsersuserapp: TWideStringField;
    tbLoggedUsersapppath: TWideStringField;
    qUsersActivity: TFDQuery;
    qUsersActivityuserid: TWideStringField;
    qUsersActivityactivity: TWideStringField;
    qUsersActivitystart_activity: TSQLTimeStampField;
    btn5Sec: TSpeedButton;
    btn1Hour: TSpeedButton;
    TimerScheduler: TTimer;
    dsScheduler: TDataSource;
    tbScheduler: TFDTable;
    tbSchedulerscheduler: TIntegerField;
    tbSchedulerday: TIntegerField;
    tbSchedulerweekday: TIntegerField;
    tbSchedulerhour: TIntegerField;
    tbSchedulerminute: TIntegerField;
    tbSchedulersql: TWideStringField;
    tbSchedulermodule: TWideStringField;
    Panel5: TPanel;
    DBGrid3: TDBGrid;
    Panel6: TPanel;
    DBNavigator1: TDBNavigator;
    tbSchedulersched_type: TWideStringField;
    tbSchedulerusername: TWideStringField;
    edDelay: TEdit;
    Label1: TLabel;
    JvFormStorage1: TJvFormStorage;
    JvAppIniFileStorage1: TJvAppIniFileStorage;
    Label2: TLabel;
    edPathToApp: TEdit;
    Label3: TLabel;
    TimerAppRun: TTimer;
    Button1: TButton;
    procedure btnSendClick(Sender: TObject);
    procedure controlReceiverUDPRead(Sender: TObject; AData: TBytes; ABinding: TIdSocketHandle);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnSendAllClick(Sender: TObject);
    procedure sendToUser(port: Integer; userId: string);
    procedure TimerRefreshTimer(Sender: TObject);
    procedure sendToAllUsers();
    procedure btnAinvClick(Sender: TObject);
    procedure btnOrdersClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnChangeVersionClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure tbLoggedUsersAfterScroll(DataSet: TDataSet);
    procedure btn5SecClick(Sender: TObject);
    procedure btn1HourClick(Sender: TObject);
    procedure TimerSchedulerTimer(Sender: TObject);
    procedure tbSchedulerAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure JvFormStorage1AfterRestorePlacement(Sender: TObject);
    procedure TimerAppRunTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label3DblClick(Sender: TObject);
  private
    procedure jobExecute(sql, module, username: string);
    procedure doAction(action: String);

    { Private declarations }
  public
    userApp, appPath, updAppPath, currUser: string;
    currPort: Integer;
    timerDelay: Integer;
  end;

var
  fmControlPanel: TfmControlPanel;

implementation

{$R *.dfm}

procedure TfmControlPanel.btnSendAllClick(Sender: TObject);
begin
  sendToAllUsers();
end;

procedure TfmControlPanel.sendToAllUsers();
var
  q: TFDQuery;
  userId: string;
  port: Integer;
begin
  q := TFDQuery.Create(nil);
  try
    with q do
    begin
      Connection := AlonDb;
      Active := False;
      sql.Clear;
      sql.Add('select userport, userid from  tools_logged_users where userapp = ' + QuotedStr(userApp) +
        'order by userid');
      Active := True;
      First;
      while not Eof do
      begin
        port := Fields[0].AsInteger;
        userId := Fields[1].AsString;
        sendToUser(port, userId);
        Next;
      end;
    end;
  finally
    q.Free;
  end;
end;

procedure TfmControlPanel.btnSendClick(Sender: TObject);
begin
  doAction(cbAction.Text);
end;

procedure TfmControlPanel.doAction(action: String);
begin
  timerDelay := StrToInt(edDelay.Text);
  if (action = ACTIVITY_VERSION) then
    sendToAllUsers()
  else if (action = ACTIVITY_RESTART) then
  begin
    appPath := retStrFieldValue(AlonDb, 'select apppath from tools_logged_users where userapp = ' + QuotedStr(userApp));
    RunSqlP(AlonDb, 'delete from tools_logged_users where userId = ' + QuotedStr('CP') + ' and userapp=' +
      QuotedStr('RUN'));
    sendToUser(currPort, currUser);
    Timer2.Enabled := True;
    TimerAppRun.Enabled := True;
  end
  else if (action = ACTIVITY_START) then
  begin
    runApp(edPathToApp.Text);
  end
  else
    sendToUser(currPort, currUser);
end;

procedure TfmControlPanel.btnChangeVersionClick(Sender: TObject);
var
  AppName: String;
begin
  cbAction.Text := ACTIVITY_VERSION;
  appPath := retStrFieldValue(AlonDb, 'select apppath from tools_logged_users where userapp = ' + QuotedStr(userApp));
  AppName := ExtractFileName(ChangeFileExt(appPath, ''));
  updAppPath := ExtractFilePath(appPath) + 'Update\' + AppName + '.exe';
  if FileExists(updAppPath) then
  begin
    RunSqlP(AlonDb, 'delete from tools_logged_users where userId = ' + QuotedStr('CP') + ' and userapp=' +
      QuotedStr('RUN'));
    sendToAllUsers;
    Timer2.Enabled := True;
  end
  else
    mmChat.Lines.Add(FormatDateTime('mm/dd/yyyy tt', now) + '-> There is no update in ' + updAppPath);
end;

procedure TfmControlPanel.Timer2Timer(Sender: TObject);
var
  sqlStr: String;
begin
  if (cbAction.Text = ACTIVITY_VERSION) then
    sqlStr := 'select userid from tools_logged_users where userapp = ' + QuotedStr(userApp)
  else
    sqlStr := 'select userid from tools_logged_users where userapp = ' + QuotedStr(userApp) + ' and userId = ' +
      QuotedStr(currUser);

  if (retStrFieldValue(AlonDb, sqlStr) = '') then
    if (timerDelay > 0) then
      Inc(timerDelay, -1)
    else
    begin
      timerDelay := TIMER_DELAY;
      Timer2.Enabled := False;
      if (cbAction.Text = ACTIVITY_VERSION) then
      begin
        TFile.Move(appPath, appPath + '.' + DateToFileName(now));
        TFile.Move(updAppPath, appPath);
      end;
      RunSqlP(AlonDb, 'insert into tools_logged_users (userId,userapp) values (' + QuotedStr('CP') + ',' +
        QuotedStr('RUN') + ')');
    end;
end;

procedure TfmControlPanel.TimerAppRunTimer(Sender: TObject);
var
  pathToApp: String;
begin
  pathToApp := edPathToApp.Text;
  if (pathToApp > '') then
    if (not isAppRun(PWideChar(pathToApp))) then
    begin
      ExecAndWait(pathToApp,1,ExtractFilePath(pathToApp));
      TimerAppRun.Enabled := False;
    end;
end;

procedure TfmControlPanel.sendToUser(port: Integer; userId: string);
begin
  controlSender.port := port;
  controlSender.Connect;
  controlReceiver.Active := True;
  if (cbAction.Text = ACTIVITY_MESSAGE) then
  begin
    mmChat.Lines.Add(FormatDateTime('mm/dd/yyyy tt', now) + '-> ' + userId + ': ' + edSend.Text);
    controlSender.Send(ACTIVITY_MESSAGE + edSend.Text);
  end
  else
  begin
    mmChat.Lines.Add(FormatDateTime('mm/dd/yyyy tt', now) + '-> ' + userId + ': ' + cbAction.Text);
    controlSender.Send(cbAction.Text);
  end;
  controlSender.Disconnect;
  controlReceiver.Active := False;
end;

procedure TfmControlPanel.tbLoggedUsersAfterScroll(DataSet: TDataSet);
begin
  currUser := tbLoggedUsersuserid.AsString;
  currPort := tbLoggedUsersuserport.AsInteger;
  qUsersActivity.Filtered := False;
  qUsersActivity.Filter := 'userid=' + QuotedStr(currUser);
  qUsersActivity.Filtered := True;
end;

procedure TfmControlPanel.tbSchedulerAfterInsert(DataSet: TDataSet);
var
  cnt: Integer;
begin
  cnt := retIntFieldValue(AlonDb, 'select max(scheduler) from tools_scheduler');
  tbSchedulerscheduler.Value := cnt + 1;
end;

procedure TfmControlPanel.TimerRefreshTimer(Sender: TObject);
begin
  if (AlonDb.Connected) then
  begin
    tbLoggedUsers.Refresh;
    qUsersActivity.Refresh;
  end;
end;

procedure TfmControlPanel.TimerSchedulerTimer(Sender: TObject);
var
  hourNow, minuteNow, sec, mSec: Word;
  yearNow, monthNow, dayNow, weekDayNow: Word;
  // minuteT, hourT, dayT, weekDayT: Word;
begin
  DecodeDateFully(now, yearNow, monthNow, dayNow, weekDayNow);
  DecodeTime(now, hourNow, minuteNow, sec, mSec);
  with tbScheduler do
  begin
    First;
    while not Eof do
    begin
      if (tbSchedulersched_type.AsString = MONTHLY) then
      begin
        if (tbSchedulerday.AsInteger = dayNow) and (tbSchedulerhour.AsInteger = hourNow) and
          (tbSchedulerminute.AsInteger = minuteNow) then
        begin
          jobExecute(tbSchedulersql.AsString, tbSchedulermodule.AsString, tbSchedulerusername.AsString);
        end;
      end;
      if (tbSchedulersched_type.AsString = WEEKLY) then
      begin
        if (tbSchedulerweekday.AsInteger = weekDayNow) and (tbSchedulerhour.AsInteger = hourNow) and
          (tbSchedulerminute.AsInteger = minuteNow) then
        begin
          jobExecute(tbSchedulersql.AsString, tbSchedulermodule.AsString, tbSchedulerusername.AsString);
        end;
      end;
      if (tbSchedulersched_type.AsString = DAILY) then
      begin
        if (tbSchedulerhour.AsInteger = hourNow) and (tbSchedulerminute.AsInteger = minuteNow) then
        begin
          jobExecute(tbSchedulersql.AsString, tbSchedulermodule.AsString, tbSchedulerusername.AsString);
        end;
      end;
      if (tbSchedulersched_type.AsString = HOURLY) then
      begin
        if (tbSchedulerminute.AsInteger = minuteNow) then
        begin
          jobExecute(tbSchedulersql.AsString, tbSchedulermodule.AsString, tbSchedulerusername.AsString);
        end;
      end;
      Next;
    end;
  end;
end;

procedure TfmControlPanel.jobExecute(sql, module, username: string);
begin
  if (sql <> '') then
  begin
    RunSqlP(AlonDb, sql);
  end
  else if (module <> '') then
  begin
    if (module = 'Restart') then
    begin
      currUser := username;
      currPort := retIntFieldValue(AlonDb, 'select userport from tools_logged_users where userId = ' +
        QuotedStr(currUser));
      cbAction.Text := ACTIVITY_RESTART;
      doAction(ACTIVITY_RESTART);
    end
    else if (module = 'Backup') then
    begin
      BackupPostgresDatabase('C:\DbBackup\', AlonDb.Params.Database);
    end;
  end;
end;

procedure TfmControlPanel.JvFormStorage1AfterRestorePlacement(Sender: TObject);
begin
  if (btnAinv.Font.Color = clRed) then
  begin
    btnAinvClick(nil);
  end
  else
  begin
    btnOrdersClick(nil);
  end;
end;

procedure TfmControlPanel.Label3DblClick(Sender: TObject);
begin
TimerAppRun.OnTimer(nil);
end;

procedure TfmControlPanel.btn1HourClick(Sender: TObject);
begin
  Timer2.Enabled := False;
  btn1Hour.Font.Style := btnAinv.Font.Style + [fsBold];
  btn1Hour.Font.Color := clRed;
  btn5Sec.Font.Style := btnOrders.Font.Style - [fsBold];
  btn5Sec.Font.Color := clBlack;
  TimerRefresh.Enabled := False;
  TimerRefresh.Interval := 3600000;
  TimerRefresh.Enabled := True;
  TimerRefreshTimer(nil);
end;

procedure TfmControlPanel.btn5SecClick(Sender: TObject);
begin
  Timer2.Enabled := False;
  btn5Sec.Font.Style := btnAinv.Font.Style + [fsBold];
  btn5Sec.Font.Color := clRed;
  btn1Hour.Font.Style := btnOrders.Font.Style - [fsBold];
  btn1Hour.Font.Color := clBlack;
  TimerRefresh.Enabled := False;
  TimerRefresh.Interval := 5000;
  TimerRefresh.Enabled := True;
  TimerRefreshTimer(nil);
end;

procedure TfmControlPanel.btnAinvClick(Sender: TObject);
begin
  Timer2.Enabled := False;
  with AlonDb do
  begin
    Connected := False;
    Params.Database := 'AlonDb';
    Params.username := 'alon';
    Params.Password := 'ag1616';
    DriverName := 'PG';
    Connected := True;
    tbLoggedUsers.Connection := AlonDb;
    qUsersActivity.Connection := AlonDb;
    tbLoggedUsers.Active := True;
    tbScheduler.Active := True;
    qUsersActivity.Active := True;
    userApp := USER_APP_AINV;
    btnAinv.Font.Style := btnAinv.Font.Style + [fsBold];
    btnAinv.Font.Color := clRed;
    btnOrders.Font.Style := btnOrders.Font.Style - [fsBold];
    btnOrders.Font.Color := clBlack;
    TimerScheduler.Enabled := True;
    btn1HourClick(nil);
    RunSqlP(AlonDb, 'delete from tools_logged_users where userId = ' + QuotedStr('CP'));
  end;
end;

procedure TfmControlPanel.btnOrdersClick(Sender: TObject);
begin
  Timer2.Enabled := False;
  with AlonDb do
  begin
    Connected := False;
    Params.Database := 'Alon2Db';
    Params.username := 'alon';
    Params.Password := 'ag1616';
    DriverName := 'PG';
    Connected := True;
    tbLoggedUsers.Connection := AlonDb;
    qUsersActivity.Connection := AlonDb;
    tbLoggedUsers.Active := True;
    tbScheduler.Active := True;
    qUsersActivity.Active := True;
    userApp := USER_APP_ORDR;
    btnOrders.Font.Style := btnOrders.Font.Style + [fsBold];
    btnOrders.Font.Color := clRed;
    btnAinv.Font.Style := btnAinv.Font.Style - [fsBold];
    btnAinv.Font.Color := clBlack;
    btn1HourClick(nil);
    TimerScheduler.Enabled := True;
    RunSqlP(AlonDb, 'delete from tools_logged_users where userId = ' + QuotedStr('CP'));
  end;
end;

procedure TfmControlPanel.btnRefreshClick(Sender: TObject);
begin
  Timer2.Enabled := False;
  tbLoggedUsers.Refresh;
  qUsersActivity.Refresh;
end;

procedure TfmControlPanel.controlReceiverUDPRead(Sender: TObject; AData: TBytes; ABinding: TIdSocketHandle);
var
  arr: TBytes;
  str: string;
begin
  arr := AData;
  str := copy(PChar(arr), 0, Length(arr));
  // ShowMessage(str);
  mmChat.Lines.Add(FormatDateTime('mm/dd/yyyy tt', now) + '->' + str);
end;

procedure TfmControlPanel.FormCreate(Sender: TObject);
begin
  PATH_TO_PG := '';
//  ExecAndWait('java -jar  ws.bat',1,'');
end;

procedure TfmControlPanel.FormShow(Sender: TObject);
begin
  // tbLoggedUsers.Active := True;
  // tbUsersActivity.Active := True;
end;
 procedure TfmControlPanel.Button1Click(Sender: TObject);
begin
  runJavaModule('ReportList','c:\Amazon\production\reports\','','');

//runJavaModule('','','','');
  ExeAndWait('java -jar  ws.jar',1);
//   ExeAndWait('ws.bat',1);

end;


end.
