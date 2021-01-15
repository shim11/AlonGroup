object fmControlPanel: TfmControlPanel
  Left = 0
  Top = 0
  Caption = 'Control Panel'
  ClientHeight = 648
  ClientWidth = 915
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 915
    Height = 41
    Align = alTop
    TabOrder = 0
    object btn5Sec: TSpeedButton
      Left = 271
      Top = 6
      Width = 50
      Height = 22
      Caption = '5 sec'
      OnClick = btn5SecClick
    end
    object btn1Hour: TSpeedButton
      Left = 320
      Top = 6
      Width = 50
      Height = 22
      Caption = '1 hour'
      OnClick = btn1HourClick
    end
    object Label1: TLabel
      Left = 384
      Top = 11
      Width = 63
      Height = 13
      Caption = 'Delay restart'
    end
    object Label2: TLabel
      Left = 483
      Top = 11
      Width = 20
      Height = 13
      Caption = 'sec.'
    end
    object Label3: TLabel
      Left = 521
      Top = 11
      Width = 56
      Height = 13
      Caption = 'Path to app'
      OnDblClick = Label3DblClick
    end
    object btnRefresh: TButton
      Left = 13
      Top = 6
      Width = 47
      Height = 25
      Caption = 'Refresh'
      TabOrder = 0
      OnClick = btnRefreshClick
    end
    object btnAinv: TBitBtn
      Left = 80
      Top = 6
      Width = 75
      Height = 25
      Caption = 'AINV'
      Style = bsNew
      TabOrder = 1
      OnClick = btnAinvClick
    end
    object btnOrders: TBitBtn
      Left = 154
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Orders'
      Style = bsNew
      TabOrder = 2
      OnClick = btnOrdersClick
    end
    object edDelay: TEdit
      Left = 451
      Top = 8
      Width = 31
      Height = 21
      TabOrder = 3
      Text = '5'
    end
    object edPathToApp: TEdit
      Left = 584
      Top = 8
      Width = 322
      Height = 21
      TabOrder = 4
    end
    object Button1: TButton
      Left = 833
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 5
      OnClick = Button1Click
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 41
    Width = 915
    Height = 607
    ActivePage = tsControlPanel
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 1
    object tsControlPanel: TTabSheet
      Caption = 'Control Panel'
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 907
        Height = 576
        Align = alClient
        BorderStyle = bsSingle
        Caption = 'Panel4'
        TabOrder = 0
        object Panel1: TPanel
          Left = 1
          Top = 1
          Width = 901
          Height = 530
          Align = alClient
          TabOrder = 0
          object DBGrid1: TDBGrid
            Left = 6
            Top = -3
            Width = 363
            Height = 185
            Align = alCustom
            DataSource = dsLoggedUsers
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'userid'
                Width = 127
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'userport'
                Width = 57
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'dateloggedin'
                Width = 120
                Visible = True
              end>
          end
          object DBGrid2: TDBGrid
            Left = 1
            Top = 188
            Width = 899
            Height = 341
            Align = alBottom
            DataSource = dsUsersActivity
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'userid'
                Width = 112
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'start_activity'
                Width = 133
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'activity'
                Width = 601
                Visible = True
              end>
          end
          object mmChat: TMemo
            Left = 375
            Top = -3
            Width = 522
            Height = 185
            Align = alCustom
            TabOrder = 2
          end
        end
        object Panel3: TPanel
          Left = 1
          Top = 531
          Width = 901
          Height = 40
          Align = alBottom
          TabOrder = 1
          object btnSend: TButton
            Left = 605
            Top = 6
            Width = 75
            Height = 25
            Caption = 'Send'
            TabOrder = 0
            OnClick = btnSendClick
          end
          object edSend: TEdit
            Left = 0
            Top = 7
            Width = 350
            Height = 21
            TabOrder = 1
            Text = 'Hi, how are you?'
          end
          object cbAction: TComboBox
            Left = 360
            Top = 8
            Width = 231
            Height = 21
            TabOrder = 2
            Items.Strings = (
              '@close'
              '@message'
              '@updateversion'
              '@restart'
              '@start')
          end
          object btnSendAll: TButton
            Left = 694
            Top = 6
            Width = 75
            Height = 25
            Caption = 'Send to All'
            TabOrder = 3
            OnClick = btnSendAllClick
          end
          object btnChangeVersion: TButton
            Left = 790
            Top = 6
            Width = 99
            Height = 25
            Caption = 'Change Version'
            TabOrder = 4
            OnClick = btnChangeVersionClick
          end
        end
      end
    end
    object tsTimerSQLJobs: TTabSheet
      Caption = 'Timer SQL Jobs'
      ImageIndex = 1
      object HeaderControl1: THeaderControl
        Left = 0
        Top = 0
        Width = 907
        Height = 17
        Sections = <>
      end
      object Panel5: TPanel
        Left = 0
        Top = 17
        Width = 907
        Height = 559
        Align = alClient
        TabOrder = 1
        object DBGrid3: TDBGrid
          Left = 1
          Top = 1
          Width = 905
          Height = 516
          Align = alClient
          DataSource = dsScheduler
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'scheduler'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'sched_type'
              PickList.Strings = (
                'MONTHLY'
                'WEEKLY'
                'DAILY'
                'HOURLY')
              Width = 89
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'username'
              Width = 91
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'day'
              Width = 33
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'weekday'
              Width = 59
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'hour'
              Width = 47
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'minute'
              Width = 49
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'module'
              PickList.Strings = (
                'Restart')
              Width = 133
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'sql'
              Width = 292
              Visible = True
            end>
        end
        object Panel6: TPanel
          Left = 1
          Top = 517
          Width = 905
          Height = 41
          Align = alBottom
          Caption = 'Panel6'
          TabOrder = 1
          object DBNavigator1: TDBNavigator
            Left = 1
            Top = 1
            Width = 903
            Height = 39
            DataSource = dsScheduler
            Align = alClient
            TabOrder = 0
          end
        end
      end
    end
  end
  object controlSender: TIdUDPClient
    Host = 'localhost'
    Port = 0
    Left = 648
    Top = 16
  end
  object controlReceiver: TIdUDPServer
    Bindings = <>
    DefaultPort = 1299
    Left = 728
    Top = 16
  end
  object dsLoggedUsers: TDataSource
    AutoEdit = False
    DataSet = tbLoggedUsers
    Left = 544
    Top = 80
  end
  object dsUsersActivity: TDataSource
    AutoEdit = False
    DataSet = qUsersActivity
    Left = 624
    Top = 80
  end
  object TimerRefresh: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = TimerRefreshTimer
    Left = 320
    Top = 32
  end
  object Timer2: TTimer
    Enabled = False
    OnTimer = Timer2Timer
    Left = 392
    Top = 32
  end
  object AlonDb: TFDConnection
    ConnectionName = 'AlonDb'
    Params.Strings = (
      'Server=localhost'
      'DriverID=PG')
    ResourceOptions.AssignedValues = [rvAutoConnect]
    ResourceOptions.AutoConnect = False
    LoginPrompt = False
    Left = 428
    Top = 108
  end
  object tbLoggedUsers: TFDTable
    AfterOpen = tbLoggedUsersAfterScroll
    AfterScroll = tbLoggedUsersAfterScroll
    AfterRefresh = tbLoggedUsersAfterScroll
    IndexFieldNames = 'userid;userapp'
    Connection = AlonDb
    UpdateOptions.UpdateTableName = 'tools_logged_users'
    TableName = 'tools_logged_users'
    Left = 544
    Top = 128
    object tbLoggedUsersuserid: TWideStringField
      FieldName = 'userid'
      Origin = 'userid'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 32
    end
    object tbLoggedUsersuserport: TIntegerField
      FieldName = 'userport'
      Origin = 'userport'
    end
    object tbLoggedUsersdateloggedin: TSQLTimeStampField
      FieldName = 'dateloggedin'
      Origin = 'dateloggedin'
    end
    object tbLoggedUsersuserapp: TWideStringField
      FieldName = 'userapp'
      Origin = 'userapp'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 32
    end
    object tbLoggedUsersapppath: TWideStringField
      FieldName = 'apppath'
      Origin = 'apppath'
      Size = 255
    end
  end
  object qUsersActivity: TFDQuery
    AutoCalcFields = False
    IndexesActive = False
    Connection = AlonDb
    FormatOptions.AssignedValues = [fvSortOptions]
    FormatOptions.SortOptions = [soDescending, soNoSymbols]
    SQL.Strings = (
      'select * from tools_users_activity '
      'order by start_activity desc')
    Left = 624
    Top = 128
    object qUsersActivityuserid: TWideStringField
      FieldName = 'userid'
      Origin = 'userid'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 32
    end
    object qUsersActivityactivity: TWideStringField
      FieldName = 'activity'
      Origin = 'activity'
      Size = 255
    end
    object qUsersActivitystart_activity: TSQLTimeStampField
      FieldName = 'start_activity'
      Origin = 'start_activity'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
  end
  object TimerScheduler: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = TimerSchedulerTimer
    Left = 456
    Top = 32
  end
  object dsScheduler: TDataSource
    DataSet = tbScheduler
    Left = 752
    Top = 88
  end
  object tbScheduler: TFDTable
    AfterInsert = tbSchedulerAfterInsert
    IndexFieldNames = 'scheduler'
    Connection = AlonDb
    UpdateOptions.UpdateTableName = 'tools_scheduler'
    TableName = 'tools_scheduler'
    Left = 752
    Top = 136
    object tbSchedulerscheduler: TIntegerField
      FieldName = 'scheduler'
      Origin = 'scheduler'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tbSchedulerday: TIntegerField
      FieldName = 'day'
      Origin = '"day"'
    end
    object tbSchedulerweekday: TIntegerField
      FieldName = 'weekday'
      Origin = 'weekday'
    end
    object tbSchedulerhour: TIntegerField
      FieldName = 'hour'
      Origin = '"hour"'
    end
    object tbSchedulerminute: TIntegerField
      FieldName = 'minute'
      Origin = '"minute"'
    end
    object tbSchedulersql: TWideStringField
      FieldName = 'sql'
      Origin = 'sql'
      Size = 1024
    end
    object tbSchedulermodule: TWideStringField
      FieldName = 'module'
      Origin = 'module'
      Size = 255
    end
    object tbSchedulersched_type: TWideStringField
      FieldName = 'sched_type'
      Origin = 'sched_type'
      FixedChar = True
      Size = 16
    end
    object tbSchedulerusername: TWideStringField
      FieldName = 'username'
      Origin = 'username'
      Size = 32
    end
  end
  object TimerAppRun: TTimer
    Enabled = False
    Interval = 300000
    OnTimer = TimerAppRunTimer
    Left = 536
    Top = 40
  end
end
