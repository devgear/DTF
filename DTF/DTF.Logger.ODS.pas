unit DTF.Logger.ODS;

interface

uses
  DTF.Logger;

type
  TODSLogger = class(TLogger)
  protected
    procedure DoWriteLog(const ALog: string); override;
  end;

implementation

uses
  WinAPI.Windows;

{ TODSLogger }

procedure TODSLogger.DoWriteLog(const ALog: string);
begin
  OutputDebugString(PChar(ALog));
end;

end.
