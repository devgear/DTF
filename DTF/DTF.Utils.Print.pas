unit DTF.Utils.Print;

{
  Customized Printing in Delphi
    http://delphiprogrammingdiary.blogspot.com/2019/03/customized-printing-in-delphi.html
  Directry to XPS printer
    https://stackoverflow.com/questions/57680432/how-to-send-data-directly-to-xps-printer-in-delphi-using-the-flag-xps-pass
}

interface

uses
  Vcl.Printers, Vcl.Graphics, System.SysUtils, System.Types, System.Classes,
  Data.DB, System.Generics.Collections;

type
  TColumn = class
  private
    FPageWidth: Integer;
    FWidth: Integer;
    FCaption: string;
  public
    constructor Create(ACaption: string; AWidth: Integer; APageWidth: Integer = 0);

    property Caption: string read FCaption write FCaption;
    property Width: Integer read FWidth write FWidth;
    property PageWidth: Integer read FPageWidth write FPageWidth;
  end;

  TSequenceColumn = class(TColumn)
  private
    FValue: Integer;
  public
    procedure AfterConstruction; override;
    procedure Increment;
    property Value: Integer read FValue;
    procedure SetStartValue(const Value: Integer);
  end;

  TColumns = class(TObjectList<TColumn>)
  public
    function Add(ACaption: string; AWidth: Integer): Integer; overload;
  end;

  TTitle = class
  private
    FFont: TFont;
    FCaption: string;
    FAlignment: TAlignment;
    procedure SetFont(const Value: TFont);
  public
    constructor Create;
    destructor Destroy; override;

    property Caption: string read FCaption write FCaption;
    property Font: TFont read FFont write SetFont;
    property Alignment: TAlignment read FAlignment write FAlignment;
  end;

  TDTFPrintOption = (
    poTitle, poTitlePerPage, poSubtitle, poSubtitlePerPage, poPageNum, poDate,
    poShowDialog, poSequenceColumn,
    poVertLine, poHorzLine, poHeaderHorzLine, poFooterHorzLine);
  TDTFPrintOptions = set of TDTFPrintOption;

  TDTFPrinter = class
  private
    FFont: TFont;
    FHeaderFont: TFont;

    FTitle: TTitle;
    FSubtitle: TTitle;
    FColumns: TColumns;

    FRowIndex: Integer;
    FNewPage: Boolean;
    FPageNum: Integer;
    FTop, FLeft: Integer;
    FPageWidth, FPageHeight: Integer;
    FCharWidth, FCharHeight: Integer;
    FRowHeight, FRowPadding, FColPadding: Integer;
    FColWidth: TArray<Integer>;

    FMargin: TRect;
    FTotalFieldWidth: Integer;
    FPerColWidth: Integer;
    FOptions: TDTFPrintOptions;

    function ShowDialog: Boolean;

  protected
    procedure DoSetup;
    procedure DoNewPage;
    procedure DoNewRow;

    procedure DoPrintPageHeader;
    procedure DoPrintTitle;
    procedure DoPrintSubTitle;
    procedure DoPrintDate;

    procedure DoPrintHeader;

    procedure DoPrintPageFooter;
    procedure DoPrintPageNum;

    procedure DoPrintHorzLine(ATop: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    property Title: TTitle read FTitle write FTitle;
    property Subtitle: TTitle read FSubtitle write FSubtitle;
    property Columns: TColumns read FColumns;

    property Font: TFont read FFont;
    property HeaderFont: TFont read FHeaderFont;
    property Options: TDTFPrintOptions read FOptions write FOptions;
    property Margin: TRect read FMargin write FMargin;

    procedure BeginDoc;
    procedure EndDoc;

    procedure WriteRows(ADatas: TArray<string>);
    procedure WriteCell(ACol: Integer; AData: string);
    procedure NewRow;

    procedure Print(AWriteDataProc: TProc; AErrorProc: TProc<string> = nil);
  end;


implementation

uses
  Vcl.Dialogs;

{ TColumn }

constructor TColumn.Create(ACaption: string; AWidth: Integer; APageWidth: Integer);
begin
  inherited Create;

  FCaption := ACaption;
  FWidth := AWidth;
  FPageWidth := APageWidth;
end;

{ TSequenceColumn }

procedure TSequenceColumn.AfterConstruction;
begin
  FValue := 1;
end;

procedure TSequenceColumn.Increment;
begin
  Inc(FValue);
end;

procedure TSequenceColumn.SetStartValue(const Value: Integer);
begin
  FValue := Value;
end;

{ TColumns }

function TColumns.Add(ACaption: string; AWidth: Integer): Integer;
begin
  Result := inherited Add(TColumn.Create(ACaption, AWidth));
end;

{ TTitle }

constructor TTitle.Create;
begin
  FFont := TFont.Create;
  FAlignment := taLeftJustify;
end;

destructor TTitle.Destroy;
begin
  FreeAndNil(FFont);

  inherited;
end;

procedure TTitle.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

{ TDTFPrinter }

constructor TDTFPrinter.Create;
begin
  FColumns := TColumns.Create;

  FOptions := [poTitle, poHeaderHorzLine, poFooterHorzLine, poPageNum];

  FTitle := TTitle.Create;
  FTitle.Alignment := taCenter;
  FTitle.Font.Size := 12;
  FTitle.Font.Style := [fsBold];

  FSubtitle := TTitle.Create;
  FSubtitle.Font.Size := 10;
  FSubtitle.Font.Style := [fsBold];

  FFont := TFont.Create;
  FHeaderFont := TFont.Create;

  FMargin.Top     := Printer.PageHeight div 30;
  FMargin.Bottom  := Printer.PageHeight div 30;

  FMargin.Left    := Printer.PageWidth div 30;
  FMargin.Right   := Printer.PageWidth div 30;
end;

destructor TDTFPrinter.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FHeaderFont);
  FreeAndNil(FColumns);

  inherited;
end;

procedure TDTFPrinter.BeginDoc;
begin
  DoSetup;

  Printer.BeginDoc;

  DoNewPage;
end;

procedure TDTFPrinter.EndDoc;
begin
  Printer.EndDoc;
end;

procedure TDTFPrinter.DoSetup;
var
  Column: TColumn;
  SumWidth: Integer;
  RestWidth: Integer;
begin
  FRowIndex := 0;
  FPageNum := 0;

  FPageWidth := Printer.PageWidth - FMargin.Left - FMargin.Right;
  FPageHeight := Printer.PageHeight - FMargin.Top - FMargin.Bottom;

  Printer.Canvas.Font.Assign(FFont);
  FCharWidth := Printer.Canvas.TextWidth('0');
  FCharHeight := Printer.Canvas.TextHeight('0');

  FRowHeight := Trunc(FCharHeight * 1.2);
  FRowPadding := Trunc(FCharHeight * 0.1);
  FColPadding := Trunc(FCharWidth * 0.8);

  if poSequenceColumn in FOptions then
    FColumns.Insert(0, TSequenceColumn.Create('No', 0, FCharWidth*8));

  SumWidth := 0;
  RestWidth := FPageWidth;
  for Column in FColumns do
  begin
    SumWidth  := SumWidth + Column.Width;
    RestWidth := RestWidth - Column.PageWidth;
  end;

  for Column in FColumns do
  begin
    if Column.PageWidth > 0 then
      Continue;
    Column.PageWidth := Trunc((Column.Width / SumWidth) * RestWidth)
  end;
end;

procedure TDTFPrinter.DoNewPage;
begin
  Inc(FPageNum);

  FTop  := FMargin.Top;
  FLeft := FMargin.Left;

  DoPrintPageHeader;
  DoPrintHeader;
end;

procedure TDTFPrinter.DoNewRow;
begin
  FLeft := FMargin.Left;
  Inc(FRowIndex);
end;

procedure TDTFPrinter.DoPrintPageHeader;
begin
  DoPrintTitle;
  DoPrintSubTitle;
end;

procedure TDTFPrinter.DoPrintTitle;
var
  X, Y, W, H: Integer;
begin
  if poTitle in FOptions then
  begin
    X := FTop;
    Y := FMargin.Left;
    Printer.Canvas.Font.Assign(FTitle.Font);
    W := Printer.Canvas.TextWidth(FTitle.Caption);
    H := Printer.Canvas.TextHeight(FTitle.Caption);

    case FTitle.Alignment of
      taLeftJustify: ;
      taRightJustify: X := FPageWidth - W;
      taCenter: X := (FPageWidth - W) div 2;
    end;

    Printer.Canvas.TextOut(X, Y, FTitle.Caption);

    Inc(FTop, H);
  end;
end;

procedure TDTFPrinter.DoPrintSubTitle;
begin

end;

procedure TDTFPrinter.DoPrintDate;
begin

end;

procedure TDTFPrinter.DoPrintHeader;
var
  Column: TColumn;
begin
  Printer.Canvas.Font.Assign(FHeaderFont);

  if poHeaderHorzLine in FOptions then
    DoPrintHorzLine(FTop);

  for Column in FColumns do
  begin
    Printer.Canvas.TextOut(FLeft + FColPadding, FTop, Column.Caption);
    Inc(FLeft, Column.PageWidth);
  end;

  Inc(FTop, FRowHeight + FRowPadding);

  if poHeaderHorzLine in FOptions then
    DoPrintHorzLine(FTop);
end;

procedure TDTFPrinter.DoPrintHorzLine(ATop: Integer);
begin
  Printer.Canvas.MoveTo(FMargin.Left, ATop);
  Printer.Canvas.LineTo(FMargin.Left + FPageWidth, ATop);

  Inc(FTop, FRowPadding);
end;

procedure TDTFPrinter.DoPrintPageFooter;
begin

end;

procedure TDTFPrinter.DoPrintPageNum;
begin

end;

procedure TDTFPrinter.NewRow;
begin
  DoNewRow;
end;

//procedure TDTFPrinter.BeginDoc;
//begin
//  Printer.BeginDoc;
//
//  // default margin
//  FMargin.Top     := Printer.PageHeight div 50;
//  FMargin.Bottom  := Printer.PageHeight div 50;
//
//  FMargin.Left    := Printer.PageWidth div 50;
//  FMargin.Right   := Printer.PageWidth div 50;
//end;
//
//procedure TDTFPrinter.EndDoc;
//begin
//  Printer.EndDoc;
//end;

procedure TDTFPrinter.Print(AWriteDataProc: TProc; AErrorProc: TProc<string> = nil);
begin
  if not ShowDialog then
    Exit;

  try
    BeginDoc;

    AWriteDataProc;

    EndDoc;
  except on E: Exception do
    AErrorProc(E.Message);
  end;
end;

function TDTFPrinter.ShowDialog: Boolean;
var
  Dialog: TPrintDialog;
begin
  Result := True;
  if poShowDialog in FOptions then
  begin
    Dialog := TPrintDialog.Create(nil);
    Result := Dialog.Execute;
    Dialog.Free;
  end;
end;

procedure TDTFPrinter.WriteCell(ACol: Integer; AData: string);
begin

end;

procedure TDTFPrinter.WriteRows(ADatas: TArray<string>);
begin
  NewRow;
end;

end.
