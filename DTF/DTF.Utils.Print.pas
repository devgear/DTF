unit DTF.Utils.Print;

interface

uses
  Vcl.Printers, Vcl.Graphics, System.SysUtils, System.Types,
  Data.DB, System.Generics.Collections;

type
  TPrintUtil = class
  public
    class procedure PrintDataSet(const ADataSet: TDataSet; const ATitle: string = '');
  end;


  TFieldInfo = record
    Name: string;
    Width: Integer;
    PageWidth: Integer;
  end;

  TDTFPrinter = class
  private
    FTitle: string;
    FFields: TList<TFieldInfo>;

    FMargin: TRect;
    FTotalFieldWidth: Integer;
    FPerColWidth: Integer;
    FFieldCount: Integer;

    procedure SetFieldCount(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    procedure BeginDoc;
    procedure EndDoc;

//    property Title: string
    property FieldCount: Integer read FFieldCount Write SetFieldCount;
  end;


implementation

{ TPrintDataSetHelper }

{ TPrintUtil }

class procedure TPrintUtil.PrintDataSet(const ADataSet: TDataSet; const ATitle: string = '');
begin

end;

{ TDTFPrinter }

constructor TDTFPrinter.Create;
begin

end;

destructor TDTFPrinter.Destroy;
begin

  inherited;
end;

procedure TDTFPrinter.BeginDoc;
begin

end;

procedure TDTFPrinter.EndDoc;
begin

end;

procedure TDTFPrinter.SetFieldCount(const Value: Integer);
begin
  FFieldCount := Value;
end;

end.
