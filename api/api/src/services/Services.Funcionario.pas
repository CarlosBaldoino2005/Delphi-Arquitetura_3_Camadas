unit Services.Funcionario;

interface

uses
  System.SysUtils, System.Classes, Providers.Conexao, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.ConsoleUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, System.JSON;

type
  TServiceFuncionario = class(TDMConexao)
    qryFuncionarios: TFDQuery;
    qryFuncionariosid: TFDAutoIncField;
    qryFuncionariosnome: TWideStringField;
    qryFuncionariossalario: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
    function ListAll: TFDQuery;
    function GetById(const AId: Int64): TFDQuery;
    function Insert(const AFuncionario: TJSONObject): TFDQuery;
    function Delete: Boolean;
    function Update(const AFuncionario: TJSONObject): Boolean;
  end;

var
  ServiceFuncionario: TServiceFuncionario;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServiceFuncionario }

uses DataSet.Serialize;

function TServiceFuncionario.Delete: Boolean;
begin
  qryFuncionarios.Delete;
  Result := qryFuncionarios.IsEmpty;
end;

function TServiceFuncionario.GetById(const AId: Int64): TFDQuery;
begin
  Result := qryFuncionarios;
  qryFuncionarios.SQL.Add('where id = :id');
  qryFuncionarios.ParamByName('id').AsLargeInt := AId;
  qryFuncionarios.Open();
end;

function TServiceFuncionario.Insert(const AFuncionario: TJSONObject): TFDQuery;
begin
  Result := qryFuncionarios;
  qryFuncionarios.SQL.Add('where 1 <> 1');
  qryFuncionarios.Open();
  qryFuncionarios.LoadFromJSON(AFuncionario, False);
end;

function TServiceFuncionario.ListAll: TFDQuery;
begin
  Result := qryFuncionarios;
  qryFuncionarios.Open();
end;

function TServiceFuncionario.Update(const AFuncionario: TJSONObject): Boolean;
begin
  qryFuncionarios.MergeFromJSONObject(AFuncionario, False);
  Result := True;
end;

end.
