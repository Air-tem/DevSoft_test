object Form1: TForm1
  Left = 480
  Top = 463
  Caption = #1050#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088
  ClientHeight = 48
  ClientWidth = 696
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 369
    Height = 21
    TabOrder = 0
    Text = '(1+(3 * { 2 + 6*2 }  ) / 4+(2+5)*3)*4'
  end
  object Button1: TButton
    Left = 392
    Top = 8
    Width = 75
    Height = 25
    Caption = '='
    TabOrder = 1
    OnClick = Button1Click
  end
  object RichEdit1: TRichEdit
    Left = 488
    Top = 8
    Width = 185
    Height = 21
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    Zoom = 100
  end
end
