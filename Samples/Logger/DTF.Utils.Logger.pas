unit DTF.Utils.Logger;

interface

uses
  System.Generics.Collections;

type
  TLogLevel = (None=0, Debug=1, Inform=2, Warnning=3, Error=4);

  ILoggerService = interface
    ['{11EA1D62-545E-4BF2-A3B2-37EE888212E4}']
    procedure Log(ALeve: TLogLevel; AMessage: string);
  end;

  TLogger = class
  private
    FList: TList<ILoggerService>;
  public
    constructor Create;
    destructor Destroy; override;

    procedure RegistService(AService: ILoggerService);

    procedure Log(ALevel: TLogLevel; AMessage: string);

    procedure Debug(AMessage: string);
    procedure Inform(AMessage: string);
    procedure Warning(AMessage: string);
    procedure Error(AMessage: string);
  end;

  TFileLogger = class(TInterfacedObject, ILoggerService)
  const
    DEFAULT_LOG_DIR = '.\Log';
    DEFAULT_FORMAT  = 'YYYYMMDD.log';
  private
    FLogDir: string;
    FFileFormat: string;
  public
    constructor Create;
    destructor Destroy; override;

    property LogDir: string read FLogDir write FLogDir;
    property FileFormat: string read FFileFormat write FFileFormat;

    procedure Log(ALeve: TLogLevel; AMessage: string);
  end;

implementation

uses
  System.IOUtils;

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

procedure TLogger.Log(ALevel: TLogLevel; AMessage: string);
begin
  if FList.Count = 0 then
//    FList.Add()

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
//  FLogDir := '.\
end;

destructor TFileLogger.Destroy;
begin

  inherited;
end;

procedure TFileLogger.Log(ALeve: TLogLevel; AMessage: string);
begin
end;

end.
