program VCL;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}
uses
  // Horse Units
  Horse.Commons in '..\..\src\Horse.Commons.pas',
  Horse.Constants in '..\..\src\Horse.Constants.pas',
  Horse.Core.Group.Contract in '..\..\src\Horse.Core.Group.Contract.pas',
  Horse.Core.Group in '..\..\src\Horse.Core.Group.pas',
  Horse.Core in '..\..\src\Horse.Core.pas',
  Horse.Core.Route.Contract in '..\..\src\Horse.Core.Route.Contract.pas',
  Horse.Core.Route in '..\..\src\Horse.Core.Route.pas',
  Horse.Core.RouterTree in '..\..\src\Horse.Core.RouterTree.pas',
  Horse.Exception in '..\..\src\Horse.Exception.pas',
  Horse.HTTP in '..\..\src\Horse.HTTP.pas',
  Horse in '..\..\src\Horse.pas',
  Horse.Provider.Abstract in '..\..\src\Horse.Provider.Abstract.pas',
  Horse.Provider.Apache in '..\..\src\Horse.Provider.Apache.pas',
  Horse.Provider.CGI in '..\..\src\Horse.Provider.CGI.pas',
  Horse.Provider.Console in '..\..\src\Horse.Provider.Console.pas',
  Horse.Provider.Daemon in '..\..\src\Horse.Provider.Daemon.pas',
  ThirdParty.Posix.Syslog in '..\..\src\ThirdParty.Posix.Syslog.pas',
  Web.WebConst in '..\..\src\Web.WebConst.pas',
  Horse.Provider.VCL in '..\..\src\Horse.Provider.VCL.pas',
  Horse.Provider.ISAPI in '..\..\src\Horse.Provider.ISAPI.pas',
  Horse.WebModule in '..\..\src\Horse.WebModule.pas' {HorseWebModule: TWebModule},
  Horse.Proc in '..\..\src\Horse.Proc.pas',
  // Project Units
  System.Classes,
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  Tests.Api.Vcl in 'tests\Tests.Api.Vcl.pas',
  Controllers.Api in 'controllers\Controllers.Api.pas',
  Tests.Commons in 'tests\Tests.Commons.pas';

var
  runner: ITestRunner;
  results: IRunResults;
  logger: ITestLogger;
  nunitLogger: ITestLogger;

begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  exit;
{$ENDIF}
  try
    TDUnitX.CheckCommandLine;

    runner := TDUnitX.CreateRunner;
    runner.UseRTTI := True;

    logger := TDUnitXConsoleLogger.Create(true);
    runner.AddLogger(logger);

    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);
    runner.FailsOnNoAsserts := False;

    results := runner.Execute;
    if (not results.AllPassed) then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    if (TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause) then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
end.
