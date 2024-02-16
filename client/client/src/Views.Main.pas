unit Views.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmMain = class(TForm)
    DBGrid1: TDBGrid;
    dsFuncionarios: TDataSource;
    mtFuncionarios: TFDMemTable;
    edtNome: TEdit;
    Panel1: TPanel;
    btnListar: TButton;
    btnExcluir: TButton;
    lblNome: TLabel;
    edtSalario: TEdit;
    lblSalario: TLabel;
    btnIncluir: TButton;
    procedure btnListarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses RESTRequest4D, System.JSON;

procedure TFrmMain.btnExcluirClick(Sender: TObject);
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New.BaseURL('http://localhost:9000')
    .Resource('funcionarios')
    .ResourceSuffix(mtFuncionarios.FieldByName('id').AsString)
    .BasicAuthentication('user', 'password')
    .Delete;
  if LResponse.StatusCode = 204 then
    mtFuncionarios.Delete;
end;

procedure TFrmMain.btnIncluirClick(Sender: TObject);
var
  LFuncionario: TJSONObject;
begin
  LFuncionario := TJSONObject.Create
    .AddPair('nome', edtNome.Text)
    .AddPair('salario', TJSONNumber.Create(edtSalario.Text));

  TRequest.New.BaseURL('http://localhost:9000')
    .Resource('funcionarios')
    .DataSetAdapter(mtFuncionarios)
    .BasicAuthentication('user', 'password')
    .AddBody(LFuncionario)
    .Post;
end;

procedure TFrmMain.btnListarClick(Sender: TObject);
begin
  TRequest.New.BaseURL('http://localhost:9000')
    .Resource('funcionarios')
    .DataSetAdapter(mtFuncionarios)
    .BasicAuthentication('user', 'password')
    .Get;
end;

end.
