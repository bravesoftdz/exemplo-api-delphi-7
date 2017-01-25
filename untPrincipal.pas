unit untPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, DB, DBClient, MidasLib, Grids,
  DBGrids, uLkJSON, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    edtToken: TEdit;
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    edtCPF: TEdit;
    Label3: TLabel;
    edtNome: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtNumeroRG: TEdit;
    Label6: TLabel;
    dsPropostas: TDataSource;
    cdsProposta: TClientDataSet;
    DBGrid1: TDBGrid;
    cdsPropostaID: TStringField;
    cdsPropostaValorEntrada: TFloatField;
    cdsPropostaValorFinanciado: TFloatField;
    cdsPropostaQuantidadeParcelas: TIntegerField;
    btnMotor: TButton;
    memLogMotorRequest: TMemo;
    cdsHistorico: TClientDataSet;
    dsHistorico: TDataSource;
    edtEndereco: TEdit;
    IdHTTP1: TIdHTTP;
    Label8: TLabel;
    memLogMotorResponse: TMemo;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtConsultaCliente: TEdit;
    btnConsultaCliente: TButton;
    Label13: TLabel;
    memLogConsultaClienteResponse: TMemo;
    Label7: TLabel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnMotorClick(Sender: TObject);
    procedure btnConsultaClienteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function getPropostas: TlkJSONlist;
    function getCliente: TlkJSONobject;
    function getContratos: TlkJSONlist;
    function getContrato: TlkJSONobject;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation


{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  cdsProposta.CreateDataSet;

  cdsProposta.Append;
  cdsPropostaID.AsString := '0+1';
  cdsPropostaValorEntrada.AsFloat := 0;
  cdsPropostaValorFinanciado.AsFloat := 200;
  cdsPropostaQuantidadeParcelas.AsInteger := 1;
  cdsProposta.Post;

  cdsProposta.Append;
  cdsPropostaID.AsString := '0+2';
  cdsPropostaValorEntrada.AsFloat := 0;
  cdsPropostaValorFinanciado.AsFloat := 200;
  cdsPropostaQuantidadeParcelas.AsInteger := 2;
  cdsProposta.Post;

  cdsProposta.Append;
  cdsPropostaID.AsString := '0+3';
  cdsPropostaValorEntrada.AsFloat := 0;
  cdsPropostaValorFinanciado.AsFloat := 200;
  cdsPropostaQuantidadeParcelas.AsInteger := 3;
  cdsProposta.Post;

  edtCPF.Text := '123.123.123-87';
  edtConsultaCliente.Text := edtCPF.Text;
  edtNome.Text := 'CLIENTE TESTE';
  edtNumeroRG.Text := '123456';
end;

procedure TfrmPrincipal.btnMotorClick(Sender: TObject);
var request  : TlkJSONobject;
    json : TStringStream;
begin
  btnMotor.Enabled := false;

  memLogMotorRequest.Clear;
  memLogMotorResponse.Clear;
  Application.ProcessMessages;

  try
    try
      // Monta o JSON de Request
      request := TlkJSONobject.Create(false);
      request.Add('propostas', getPropostas());
      request.Add('cliente', getCliente());
      request.Add('contratos', getContratos());

      memLogMotorRequest.Lines.Text := TlkJSON.GenerateText(request);
      json := TStringStream.Create(memLogMotorRequest.Lines.Text);
      Application.ProcessMessages;

      IdHTTP1.Request.CustomHeaders.Clear;
      IdHTTP1.Request.CustomHeaders.AddValue('x-api-key', edtToken.Text);
      IdHTTP1.Request.ContentType := 'application/json';

      memLogMotorResponse.Lines.Text := IdHTTP1.Post(edtEndereco.Text+'/motor', json);
    except
      on E: Exception do
        MessageDlg(e.Message, mtError, [mbOk], 0);
    end;
  finally
    btnMotor.Enabled := True;
  end;
end;

function TfrmPrincipal.getPropostas: TlkJSONlist;
var proposta  : TlkJSONobject;
    propostas : TlkJSONlist;
begin
  // Adiciona as propostas
  propostas := TlkJSONlist.Create;
  cdsProposta.First;
  while not cdsProposta.Eof do
    begin
      proposta := TlkJSONobject.Create;
      proposta.Add('identificador', cdsPropostaID.AsString);
      proposta.Add('valorentrada', cdsPropostaValorEntrada.AsFloat);
      proposta.Add('valorfinanciado', cdsPropostaValorFinanciado.AsFloat);
      proposta.Add('quantidadeparcelas', cdsPropostaQuantidadeParcelas.AsInteger);

      propostas.Add(proposta);
      cdsProposta.Next;
    end;

  result := propostas;
end;


function TfrmPrincipal.getCliente: TlkJSONobject;
var cliente, identificacao, conjuge,
    endereco, contato, trabalho, social, referencia : TlkJSONobject;
    referencias : TlkJSONlist;
begin
  // Dados do cliente
  identificacao := TlkJSONobject.Create(false);
  identificacao.Add('cpf', edtCPF.Text);
  identificacao.Add('nome', edtNome.Text);
  identificacao.Add('rg', edtNumeroRG.Text);
  identificacao.Add('rgorgao', '');
  identificacao.Add('rgorgaouf', '');
  identificacao.Add('rgdtemis', '');
  identificacao.Add('nascimento', '');
  identificacao.Add('sexo', '');
  identificacao.Add('nomepai', '');
  identificacao.Add('nomemae', '');
  identificacao.Add('estadocivil', '');

  conjuge := TlkJSONobject.Create(false);
  conjuge.Add('nome', '');
  conjuge.Add('nascimento', '');
  conjuge.Add('telefone', TlkJSONnumber.Generate(1111111111));

  endereco := TlkJSONobject.Create(false);
  endereco.Add('cep', '');
  endereco.Add('endereco', '');
  endereco.Add('endnumero', '');
  endereco.Add('complemento', '');
  endereco.Add('bairro', '');
  endereco.Add('anosmoradia', TlkJSONnumber.Generate(2));

  contato := TlkJSONobject.Create(false);
  contato.Add('telresidencial', TlkJSONnumber.Generate(1122222222));
  contato.Add('telcelular', TlkJSONnumber.Generate(11999999999));
  contato.Add('telcomercial', TlkJSONnumber.Generate(1133333333));
  contato.Add('email', '1@1.com');

  trabalho := TlkJSONobject.Create(false);
  trabalho.Add('ocupacao', TlkJSONnumber.Generate(1111111111));
  trabalho.Add('empresa', '');
  trabalho.Add('tempoempresa', TlkJSONnumber.Generate(3)); // Anos
  trabalho.Add('salario', TlkJSONnumber.Generate(150.50));

  social := TlkJSONobject.Create(false);
  social.Add('dependentes', TlkJSONnumber.Generate(3));
  social.Add('moradia' , 'ALUGADA');
  social.Add('situacaocarro', 'FINANCIADO');
  social.Add('situacaomoto', 'NAO');
  social.Add('escolaridade', 'SUPERIOR_INCOMPLETO');

  referencias := TlkJSONlist.Create;
  referencia := TlkJSONobject.Create(false);
  referencia.Add('nome', 'NOME REFEFERENCIA 1');
  referencia.Add('relacao', 'FILHO');
  referencia.Add('telresidencial', TlkJSONnumber.Generate(1111111111));
  referencia.Add('telcelular', TlkJSONnumber.Generate(11999999999));
  referencia.Add('telcomercial', TlkJSONnumber.Generate(1133333333));
  referencias.Add(referencia);

  referencia := TlkJSONobject.Create(false);
  referencia.Add('nome', 'NOME REFEFERENCIA 2');
  referencia.Add('relacao', 'AMIGO');
  referencia.Add('telresidencial', TlkJSONnumber.Generate(1111111111));
  referencia.Add('telcelular', TlkJSONnumber.Generate(11999999999));
  referencia.Add('telcomercial', TlkJSONnumber.Generate(1133333333));
  referencias.Add(referencia);

  cliente := TlkJSONobject.Create(false);
  cliente.Add('identificacao', identificacao);
  cliente.Add('conjuge', conjuge);
  cliente.Add('endereco', endereco);
  cliente.Add('contato', contato);
  cliente.Add('trabalho', trabalho);
  cliente.Add('social', social);
  cliente.Add('referencias', referencias);
  
  result := cliente;
end;


function TfrmPrincipal.getContratos: TlkJSONlist;
var contratos : TlkJSONlist;
begin
  contratos := TlkJSONlist.Create;
  contratos.Add(getContrato());

  result := contratos;            
end;

function TfrmPrincipal.getContrato: TlkJSONobject;
var contrato, parcela : TlkJSONobject;
    parcelas : TlkJSONlist;
begin
  contrato := TlkJSONobject.Create(false);
  contrato.Add('contrato', 'CF00234');
  contrato.Add('data', '2016-08-05');
  contrato.Add('hora', '11:17:00');
  contrato.Add('valortotal', TlkJSONnumber.Generate(400.5));
  contrato.Add('valorentrada', TlkJSONnumber.Generate(100.5));
  contrato.Add('valorfinanciado', TlkJSONnumber.Generate(300));

  parcelas := TlkJSONlist.Create;

  parcela := TlkJSONobject.Create(false);
  parcela.Add('valorvencimento', TlkJSONnumber.Generate(100));
  parcela.Add('datavencimento', '2016-09-05');
  parcela.Add('dataultimopagamento', '2016-09-03');
  parcela.Add('totalpago', TlkJSONnumber.Generate(100));
  parcela.Add('capitalaberto', 0);
  parcelas.Add(parcela);

  parcela := TlkJSONobject.Create(false);
  parcela.Add('valorvencimento', TlkJSONnumber.Generate(100));
  parcela.Add('datavencimento', '2016-10-05');
  parcela.Add('dataultimopagamento', '2016-10-05');
  parcela.Add('totalpago', TlkJSONnumber.Generate(60));
  parcela.Add('capitalaberto', 40);
  parcelas.Add(parcela);

  parcela := TlkJSONobject.Create(false);
  parcela.Add('valorvencimento', TlkJSONnumber.Generate(100));
  parcela.Add('datavencimento', '2016-10-05');
  parcela.Add('totalpago', TlkJSONnumber.Generate(0));
  parcela.Add('capitalaberto', 100);
  parcelas.Add(parcela);


  contrato.Add('parcelas', parcelas);
  result := contrato;
end;

procedure TfrmPrincipal.btnConsultaClienteClick(Sender: TObject);
begin
  btnConsultaCliente.Enabled := false;
  memLogConsultaClienteResponse.Clear;
  Application.ProcessMessages;

  try
    try
      IdHTTP1.Request.CustomHeaders.Clear;
      IdHTTP1.Request.CustomHeaders.AddValue('x-api-key', edtToken.Text);
      IdHTTP1.Request.ContentType := 'application/json';

      memLogConsultaClienteResponse.Lines.Text := IdHTTP1.Get(edtEndereco.Text+'/cliente/'+edtConsultaCliente.Text);
    except
      on E: Exception do
        MessageDlg(e.Message, mtError, [mbOk], 0);
    end;
  finally
    btnConsultaCliente.Enabled := True;
  end;
end;

end.
