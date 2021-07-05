unit DTF.Logger.FileLog;

interface

uses
  DTF.Logger;

type
  TFileLogger = class(TLogger)
  private
    FFileFormat: string;
    FDir: string;

    procedure SetFileFormat(const Value: string);
    procedure SetDir(const Value: string);
  protected
    procedure DoWriteLog(const ALevel: TLogLevel; ALog: string);
  public
    constructor Create;
    destructor Destroy; override;
    property FileFormat: string read FFileFormat write SetFileFormat;
    property Dir: string read FDir write SetDir;
  end;

implementation

uses
  System.IOUtils;

{ TFileLogger }

constructor TFileLogger.Create;
begin
  FDir := TPath.GetLibraryPath + 'log';
  FFileFormat := 'YYYYMMDD.log';
end;

destructor TFileLogger.Destroy;
begin

  inherited;
end;

procedure TFileLogger.DoWriteLog(const ALevel: TLogLevel; ALog: string);
begin

end;

procedure TFileLogger.SetDir(const Value: string);
begin
  FDir := Value;
end;

procedure TFileLogger.SetFileFormat(const Value: string);
begin
  FFileFormat := Value;
end;

end.
