program api;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.HandleException,
  Horse.BasicAuthentication,
  System.SysUtils,
  Providers.Conexao in 'src\providers\Providers.Conexao.pas' {DMConexao: TDataModule},
  Services.Funcionario in 'src\services\Services.Funcionario.pas' {ServiceFuncionario: TDataModule},
  Controllers.Funcionario in 'src\controllers\Controllers.Funcionario.pas';

begin
  THorse
    .Use(Jhonson())
    .Use(HandleException)
    .Use(HorseBasicAuthentication(
      function(const AUsername, APassword: string): Boolean
      begin
        Result := AUsername.Equals('user') and APassword.Equals('password');
      end));

  Controllers.Funcionario.Registry;

  THorse.Listen(9000);
end.
