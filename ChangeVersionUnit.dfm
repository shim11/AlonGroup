object fmCv: TfmCv
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 308
  ClientWidth = 215
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  GlassFrame.Left = 1
  GlassFrame.Right = 1
  GlassFrame.Bottom = 1
  GlassFrame.SheetOfGlass = True
  OldCreateOrder = False
  Position = poDesigned
  Scaled = False
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 215
    Height = 308
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 0
    object Image1: TImage
      Left = 4
      Top = 7
      Width = 200
      Height = 200
      Stretch = True
    end
    object lbAppUp: TLabel
      Left = 31
      Top = 222
      Width = 146
      Height = 19
      Caption = 'Application updating'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Button1: TButton
      Left = 65
      Top = 257
      Width = 80
      Height = 25
      Caption = 'Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 176
    Top = 248
  end
  object AlonDb: TFDConnection
    ConnectionName = 'AlonDb'
    Params.Strings = (
      'Server=localhost'
      'Database=Alon2Db')
    ResourceOptions.AssignedValues = [rvAutoConnect]
    ResourceOptions.AutoConnect = False
    LoginPrompt = False
    Left = 12
    Top = 244
  end
end
