object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Client API'
  ClientHeight = 326
  ClientWidth = 678
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblNome: TLabel
    Left = 24
    Top = 60
    Width = 31
    Height = 13
    Caption = 'Nome:'
  end
  object lblSalario: TLabel
    Left = 453
    Top = 60
    Width = 36
    Height = 13
    Caption = 'Sal'#225'rio:'
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 128
    Width = 678
    Height = 198
    Align = alBottom
    DataSource = dsFuncionarios
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Title.Caption = 'Id'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome'
        Title.Caption = 'Nome'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'salario'
        Title.Caption = 'Sal'#225'rio'
        Width = 60
        Visible = True
      end>
  end
  object edtNome: TEdit
    Left = 24
    Top = 79
    Width = 423
    Height = 21
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 678
    Height = 41
    Align = alTop
    TabOrder = 2
    ExplicitLeft = 256
    ExplicitTop = 160
    ExplicitWidth = 185
    object btnListar: TButton
      Left = 1
      Top = 1
      Width = 75
      Height = 39
      Align = alLeft
      Caption = 'Listar'
      TabOrder = 0
      OnClick = btnListarClick
    end
    object btnExcluir: TButton
      Left = 76
      Top = 1
      Width = 75
      Height = 39
      Align = alLeft
      Caption = 'Excluir'
      TabOrder = 1
      OnClick = btnExcluirClick
      ExplicitLeft = 280
      ExplicitTop = 16
      ExplicitHeight = 25
    end
  end
  object edtSalario: TEdit
    Left = 453
    Top = 79
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 3
  end
  object btnIncluir: TButton
    Left = 580
    Top = 77
    Width = 75
    Height = 25
    Caption = 'Incluir'
    TabOrder = 4
    OnClick = btnIncluirClick
  end
  object dsFuncionarios: TDataSource
    DataSet = mtFuncionarios
    Left = 480
    Top = 216
  end
  object mtFuncionarios: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 480
    Top = 264
  end
end
