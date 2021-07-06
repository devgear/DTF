unit DTF.Logger;

interface

uses
  DTF.Service.Types;

type
  TLogLevel = (llTrace, llDebug, llInfo, llWarnig, llError, llFatal);
  TLogger = class abstract(TDTFServiceProvider, IDTFLogService)
  private
    FLogLevel: TLogLevel;
  protected
    procedure DoWriteLog(const ALog: string); virtual; abstract;
  public
    constructor Create; virtual;

    procedure Log(const ALevel: TLogLevel; ALog: string); virtual;
    procedure Info(const ALog: string); virtual;

    property LogLevel: TLogLevel read FLogLevel write FLogLevel;
  end;

  TLogService = TLogger;

function Logger: TLogger;

implementation

uses
  DTF.App, System.SysUtils;

function Logger: TLogger;
begin
  Result := App.Log;
end;

{ TLogger }

procedure TLogger.Log(const ALevel: TLogLevel; ALog: string);
const
  cLogLevelStrs: array [TLogLevel] of String = ('TRC', 'DBG', 'INF', 'WRN', 'ERR', 'FTL');
var
  Log, Level: string;
begin
  if ALevel < FLogLevel then
    Exit;

  Log := FormatDateTime('HH:NN:SS', Now) + ' [' + cLogLevelStrs[ALevel] + '] ' + ALog;
  DoWriteLog(Log);
end;

constructor TLogger.Create;
begin
  FLogLevel := llInfo;
end;

procedure TLogger.Info(const ALog: string);
begin
  Log(llInfo, ALog);
end;

end.
