unit DTF.Logger;

interface

uses
  DTF.Service.Types;

type
  TLogLevel = (llTrace, llDebug, llInfo, llWarnig, llError, llFatal);
  TLogger = class abstract(TDTFServiceProvider, IDTFLogService)
  protected
    procedure DoWriteLog(const ALevel: TLogLevel; ALog: string); virtual; abstract;
  public
    procedure Log(const ALevel: TLogLevel; ALog: string); virtual;
    procedure Info(const ALog: string); virtual;
  end;

  TLogService = TLogger;

function Logger: TLogger;

implementation

uses
  DTF.App;

function Logger: TLogger;
begin
  Result := App.Log;
end;

{ TLogger }

procedure TLogger.Log(const ALevel: TLogLevel; ALog: string);
begin

end;

procedure TLogger.Info(const ALog: string);
begin
  Log(llInfo, ALog);
end;

end.
