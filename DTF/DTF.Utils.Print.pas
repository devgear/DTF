unit DTF.Utils.Print;

interface

uses
  Vcl.Printers, Vcl.Graphics, System.SysUtils, System.Types,
  Data.DB, System.Generics.Collections;

type
  TPrintUtil = class
  public
    class procedure PrintDataSet(const ADataSet: TDataSet; const ATitle: string = '');
    class procedure PrintDataRows<T>(const ADatas: TArray<T>; const ATitle: string = '');
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

{ TPrintUtil }

class procedure TPrintUtil.PrintDataSet(const ADataSet: TDataSet; const ATitle: string);
begin

end;

class procedure TPrintUtil.PrintDataRows<T>(const ADatas: TArray<T>;
  const ATitle: string);
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
  Printer.BeginDoc;

  // default margin
  FMargin.Top     := Printer.PageHeight div 10;
  FMargin.Bottom  := Printer.PageHeight div 50;

  FMargin.Left    := Printer.pagewidth div 50;
  FMargin.Right   := Printer.pagewidth div 50;
end;

procedure TDTFPrinter.EndDoc;
begin
  Printer.EndDoc;
end;

procedure TDTFPrinter.SetFieldCount(const Value: Integer);
begin
  FFieldCount := Value;
end;

end.
