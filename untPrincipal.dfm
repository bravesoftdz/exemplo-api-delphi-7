object frmPrincipal: TfrmPrincipal
  Left = 239
  Top = 124
  Width = 870
  Height = 563
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Exemplo de Api com Delphi 7'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 65
    Align = alTop
    TabOrder = 0
    object Label7: TLabel
      Left = 46
      Top = 37
      Width = 49
      Height = 13
      Caption = 'Endereco '
    end
    object Label1: TLabel
      Left = 8
      Top = 13
      Width = 84
      Height = 13
      Caption = 'Token de Acesso'
    end
    object edtToken: TEdit
      Left = 98
      Top = 9
      Width = 601
      Height = 21
      TabOrder = 0
    end
    object edtEndereco: TEdit
      Left = 98
      Top = 33
      Width = 601
      Height = 21
      TabOrder = 1
      Text = 'https://api.meucrediario.com.br/v1'
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 517
    Width = 862
    Height = 19
    Panels = <>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 65
    Width = 862
    Height = 452
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Motor de Credito'
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 854
        Height = 424
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object Label2: TLabel
          Left = 26
          Top = 38
          Width = 23
          Height = 13
          Alignment = taRightJustify
          Caption = 'CPF:'
        end
        object Label3: TLabel
          Left = 18
          Top = 62
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Nome:'
        end
        object Label4: TLabel
          Left = 8
          Top = 6
          Width = 160
          Height = 20
          Caption = 'Cadastro do Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 30
          Top = 86
          Width = 19
          Height = 13
          Alignment = taRightJustify
          Caption = 'RG:'
        end
        object Label6: TLabel
          Left = 360
          Top = 6
          Width = 82
          Height = 20
          Caption = 'Propostas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 8
          Top = 174
          Width = 120
          Height = 20
          Caption = 'JSON Request'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 8
          Top = 286
          Width = 133
          Height = 20
          Caption = 'JSON Response'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object edtCPF: TEdit
          Left = 56
          Top = 35
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object edtNome: TEdit
          Left = 56
          Top = 59
          Width = 289
          Height = 21
          TabOrder = 1
        end
        object edtNumeroRG: TEdit
          Left = 56
          Top = 83
          Width = 81
          Height = 21
          TabOrder = 2
        end
        object DBGrid1: TDBGrid
          Left = 360
          Top = 32
          Width = 473
          Height = 97
          DataSource = dsPropostas
          Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 3
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'ID'
              Title.Caption = 'Identificador'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ValorEntrada'
              Title.Caption = 'Valor de Entrada'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ValorFinanciado'
              Title.Caption = 'Valor Financiado'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'QuantidadeParcelas'
              Title.Caption = 'Quantidade de Parcelas'
              Visible = True
            end>
        end
        object btnMotor: TButton
          Left = 8
          Top = 144
          Width = 827
          Height = 25
          Caption = 'Consultar Motor'
          TabOrder = 4
          OnClick = btnMotorClick
        end
        object memLogMotorRequest: TMemo
          Left = 8
          Top = 200
          Width = 825
          Height = 81
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 5
        end
        object memLogMotorResponse: TMemo
          Left = 8
          Top = 312
          Width = 825
          Height = 105
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 6
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Consulta de Cliente'
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 854
        Height = 424
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object Label10: TLabel
          Left = 8
          Top = 6
          Width = 139
          Height = 20
          Caption = 'Dados do Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object Label11: TLabel
          Left = 26
          Top = 38
          Width = 23
          Height = 13
          Alignment = taRightJustify
          Caption = 'CPF:'
        end
        object Label13: TLabel
          Left = 8
          Top = 96
          Width = 133
          Height = 20
          Caption = 'JSON Response'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object edtConsultaCliente: TEdit
          Left = 56
          Top = 35
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object btnConsultaCliente: TButton
          Left = 8
          Top = 64
          Width = 827
          Height = 25
          Caption = 'Consultar Cliente'
          TabOrder = 1
          OnClick = btnConsultaClienteClick
        end
        object memLogConsultaClienteResponse: TMemo
          Left = 8
          Top = 128
          Width = 825
          Height = 281
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 2
        end
      end
    end
  end
  object dsPropostas: TDataSource
    DataSet = cdsProposta
    Left = 148
    Top = 193
  end
  object cdsProposta: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 60
    Top = 193
    object cdsPropostaID: TStringField
      FieldName = 'ID'
    end
    object cdsPropostaValorEntrada: TFloatField
      FieldName = 'ValorEntrada'
    end
    object cdsPropostaValorFinanciado: TFloatField
      FieldName = 'ValorFinanciado'
    end
    object cdsPropostaQuantidadeParcelas: TIntegerField
      FieldName = 'QuantidadeParcelas'
    end
  end
  object cdsHistorico: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 60
    Top = 249
  end
  object dsHistorico: TDataSource
    DataSet = cdsHistorico
    Left = 148
    Top = 249
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 60
    Top = 313
  end
end
