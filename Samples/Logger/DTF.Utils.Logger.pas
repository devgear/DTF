{ TODO : Thread safe 하도록 처리 }
{ TODO : TLogger class method 지원? }
{ TODO : TLogger.d('test') }
{ TODO : 기타 포맷으로 overload }

unit DTF.Utils.Logger;

interface

uses
  System.Generics.Collections;

type
  TLogLevel = (None=0, Debug=1, Inform=2, Warnning=3, Error=4);

  ILoggerService = interface
    ['{11EA1D62-545E-4BF2-A3B2-37EE888212E4}']
    procedure Log(ALeve: TLogLevel; AMessage: string);
    procedure Setup;
  end;

  TLogger = class
  private
    FList: TList<ILoggerService>;
    FActive: Boolean;
    procedure SetActive(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    property Active: Boolean read FActive write SetActive;

    procedure RegistService(AService: ILoggerService);

    procedure Log(ALevel: TLogLevel; AMessage: string);

    procedure Debug(AMessage: string);
    procedure Inform(AMessage: string);
    procedure Warning(AMessage: string);
    procedure Error(AMessage: string);
  end;

  TFileLogger = class(TInterfacedObject, ILoggerService)
  const
    DEFAULT_LOG_DIR = '.\log';
    DEFAULT_FORMAT  = 'YYYYMMDD';
    DEFAULT_PREFIX  = 'HH:NN:SS ';
  private
    FLogDir: string;
    FFileFormat: string;
    FPrefixForamt: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Setup;

    property LogDir: string read FLogDir write FLogDir;
    property FileFormat: string read FFileFormat write FFileFormat;
    property PrefixFormat: string read FPrefixForamt write FPrefixForamt;

    procedure Log(ALeve: TLogLevel; AMessage: string);
  end;

implementation

uses
  System.IOUtils, System.SysUtils;

{ TLogger }

constructor TLogger.Create;
begin
  FList := TLIst<ILoggerService>.Create;
end;

destructor TLogger.Destroy;
begin
  FList.Free;

  inherited;
end;

procedure TLogger.RegistService(AService: ILoggerService);
begin
  FList.Add(AService);
end;

procedure TLogger.SetActive(const Value: Boolean);
begin
  if FActive = Value then
    Exit;
  if Value and (FList.Count = 0) then
    FList.Add(TFileLogger.Create);

  FActive := Value;
end;

procedure TLogger.Log(ALevel: TLogLevel; AMessage: string);
var
  Service: ILoggerService;
begin
  for Service in FList do
    Service.Log(ALevel, AMessage);
end;

procedure TLogger.Debug(AMessage: string);
begin
  Log(TLogLevel.Debug, AMessage);
end;

procedure TLogger.Inform(AMessage: string);
begin
  Log(TLogLevel.Debug, AMessage);
end;

procedure TLogger.Warning(AMessage: string);
begin
  Log(TLogLevel.Debug, AMessage);
end;

procedure TLogger.Error(AMessage: string);
begin
  Log(TLogLevel.Debug, AMessage);
end;

{ TFileLogger }

constructor TFileLogger.Create;
begin
  FLogDir := DEFAULT_LOG_DIR;
  FFileFormat := DEFAULT_FORMAT;
  FPrefixForamt := DEFAULT_PREFIX;
end;

destructor TFileLogger.Destroy;
begin

  inherited;
end;

procedure TFileLogger.Setup;
begin

end;

procedure TFileLogger.Log(ALeve: TLogLevel; AMessage: string);
var
  F: TextFile;
  Path: string;
  LogMsg: string;
begin
//  TFile.write
  if not TDirectory.Exists(FLogDir) then
    TDirectory.CreateDirectory(FLogDir);

  Path := TPath.Combine(FLogDir, FormatDateTime(FFileFormat, Now)) + '.log';
  LogMsg := FormatDateTime(FPrefixForamt, Now) + AMessage;

  AssignFile(F, Path);
  if TFile.Exists(Path) then
    Append(F)
  else
    Rewrite(F);
  WriteLn(F, LogMsg);
  CloseFile(F);
end;

end.
