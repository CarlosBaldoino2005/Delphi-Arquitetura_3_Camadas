unit Controllers.Funcionario;

interface

procedure Registry;

implementation

uses Horse, Services.Funcionario, System.JSON, DataSet.Serialize, System.SysUtils,
  Data.DB;

procedure SalvarFuncionario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServiceFuncionario;
begin
  LService := TServiceFuncionario.Create(nil);
  try
    Res
      .Send<TJSONObject>(LService.Insert(Req.Body<TJSONObject>).ToJSONObject())
      .Status(THTTPStatus.Created);
  finally
    LService.Free;
  end;
end;

procedure ListarFuncionarios(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServiceFuncionario;
begin
  LService := TServiceFuncionario.Create(nil);
  try
    Res.Send<TJSONArray>(LService.ListAll.ToJSONArray());
  finally
    LService.Free;
  end;
end;

procedure ObterFuncionario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdFuncionario: Int64;
  LService: TServiceFuncionario;
begin
  LService := TServiceFuncionario.Create(nil);
  try
    LIdFuncionario := Req.Params.Items['id'].ToInt64;
    if LService.GetById(LIdFuncionario).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Funcionário não existe');
    Res.Send<TJSONObject>(LService.qryFuncionarios.ToJSONObject());
  finally
    LService.Free;
  end;
end;

procedure DeletarFuncionario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdFuncionario: Int64;
  LService: TServiceFuncionario;
begin
  LService := TServiceFuncionario.Create(nil);
  try
    LIdFuncionario := Req.Params.Items['id'].ToInt64;
    if LService.GetById(LIdFuncionario).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Funcionário não existe');
    if LService.Delete then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure AlterarFuncionario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdFuncionario: Int64;
  LService: TServiceFuncionario;
begin
  LService := TServiceFuncionario.Create(nil);
  try
    LIdFuncionario := Req.Params.Items['id'].ToInt64;
    if LService.GetById(LIdFuncionario).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Funcionário não existe');
    if LService.Update(Req.Body<TJSONObject>) then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/funcionarios', ListarFuncionarios);
  THorse.Get('/funcionarios/:id', ObterFuncionario);
  THorse.Post('/funcionarios', SalvarFuncionario);
  THorse.Put('/funcionarios/:id', AlterarFuncionario);
  THorse.Delete('/funcionarios/:id', DeletarFuncionario);
end;

end.
