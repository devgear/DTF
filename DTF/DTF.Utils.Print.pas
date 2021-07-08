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
    FPageLeft: Integer;
  public
    constructor Create(ACaption: string; AWidth: Integer; APageWidth: Integer = 0);

    property Caption: string read FCaption write FCaption;
    property Width: Integer read FWidth write FWidth;
    property PageLeft: Integer read FPageLeft write FPageLeft;
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
    poTitle, poTitlePerPage, poSubtitle, poSubtitlePerPage,
    poPageNum, poPageDate,

    poShowDialog,
    poSequenceColumn,

    poVertLine, poHorzLine, poHeaderHorzLine, poFooterHorzLine);
  TDTFPrintOptions = set of TDTFPrintOption;

  TDTFPrinter = class
  private
    FFont: TFont;
    FHeaderFont: TFont;

    FTitle: TTitle;
    FSubtitle: TTitle;
    FColumns: TColumns;

    FCurrY: Integer;
    FRowIndex: Integer;

    FPageWidth, FPageHeight: Integer;
    FCharWidth, FCharHeight: Integer;
    FRowHeight, FRowPadding, FColPadding: Integer;
    FColWidth: TArray<Integer>;

    FMargin: TRect;
    FTotalFieldWidth: Integer;
    FPerColWidth: Integer;
    FOptions: TDTFPrintOptions;

    FInBeginRow: Boolean;

    function ShowDialog: Boolean;

  protected
    procedure DoSetup;

    procedure DoBeginDoc;
    procedure DoEndDoc;

    procedure DoNewPage;
    procedure DoBeginPage;
    procedure DoEndPage;

    procedure DoNewRow;
    procedure DoBeginRow;
    procedure DoEndRow;

    procedure DoPrintPageHeader;
    procedure DoPrintTitle;
    procedure DoPrintSubTitle;

    procedure DoPrintHeader;

    procedure DoPrintSeqColumn;

    procedure DoPrintPageFooter;
    procedure DoPrintDate(AY: Integer);
    procedure DoPrintPageNum(AY: Integer);

    procedure DoPrintHorzLine(var AY: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    property Font: TFont read FFont;
    property HeaderFont: TFont read FHeaderFont;

    property Options: TDTFPrintOptions read FOptions write FOptions;
    property Margin: TRect read FMargin write FMargin;

    property Title: TTitle read FTitle write FTitle;
    property Subtitle: TTitle read FSubtitle write FSubtitle;
    property Columns: TColumns read FColumns;

    procedure WriteRows(ADatas: TArray<string>);
    function NewRow: TDTFPrinter;
    function WriteCell(ACol: Integer; AData: string): TDTFPrinter; overload;
    function WriteCell(AColumn: TColumn; AData: string): TDTFPrinter; overload;

    procedure Print(AWriteDataProc: TProc; AErrorProc: TProc<string> = nil);
  end;

const
  DEF_FONT_SIZE = 11;
  DEF_FONT_SIZE_SUB = 13;
  DEF_FONT_SIZE_TITLE = 15;

implementation

uses
  Vcl.Dialogs;

{ TColumn }

constructor TColumn.Create(ACaption: string; AWidth: Integer; APageWidth: Integer);
begin
  inherited Create;

  FCaption := ACaption;
  FWidth := AWidth;
  FPageLeft := 0;
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

  FOptions := [poTitle, poHeaderHorzLine, poFooterHorzLine, poPageNum, poPageDate, poShowDialog];

  FTitle := TTitle.Create;
  FTitle.Alignment := taCenter;
  FTitle.Font.Size := DEF_FONT_SIZE_TITLE;
  FTitle.Font.Style := [fsBold];

  FSubtitle := TTitle.Create;
  FSubtitle.Font.Size := DEF_FONT_SIZE_SUB;
  FSubtitle.Font.Style := [fsBold];

  FFont := TFont.Create;
  FFont.Size := DEF_FONT_SIZE;

  FHeaderFont := TFont.Create;
  FHeaderFont.Size := DEF_FONT_SIZE;
  FHeaderFont.Style := [fsBold];
end;

destructor TDTFPrinter.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FHeaderFont);
  FreeAndNil(FColumns);

  inherited;
end;

procedure TDTFPrinter.DoBeginDoc;
begin
  Printer.BeginDoc;

  DoSetup;

  DoBeginPage;
end;

procedure TDTFPrinter.DoEndDoc;
begin
  DoEndPage;
  Printer.EndDoc;
end;

procedure TDTFPrinter.DoSetup;
var
  Column: TColumn;
  SumWidth: Integer;
  RestWidth: Integer;
  I, Left: Integer;
begin
  FRowIndex := 0;

  FMargin.Top     := Printer.PageHeight div 30;
  FMargin.Bottom  := Printer.PageHeight div 30;
  FMargin.Left    := Printer.PageWidth div 30;
  FMargin.Right   := Printer.PageWidth div 30;

  FPageWidth := Printer.PageWidth - FMargin.Left - FMargin.Right;
  FPageHeight := Printer.PageHeight - FMargin.Top - FMargin.Bottom;

  Printer.Canvas.Font.Assign(FFont);
  FCharWidth := Printer.Canvas.TextWidth('0');
  FCharHeight := Printer.Canvas.TextHeight('0');

  FRowHeight := Trunc(FCharHeight * 1.4);
  FRowPadding := Trunc(FCharHeight * 0.2);
  FColPadding := Trunc(FCharWidth * 0.8);

  if poSequenceColumn in FOptions then
    FColumns.Insert(0, TSequenceColumn.Create('No', 0, FCharWidth*8));

  //////////////
  // Column.Width 비율로 PageWidth 계산 및 설정
  SumWidth := 0;
  RestWidth := FPageWidth;
  for Column in FColumns do
  begin
    SumWidth  := SumWidth + Column.Width;
    RestWidth := RestWidth - Column.PageWidth;
  end;

  Left := FMargin.Left;
  for Column in FColumns do
  begin
    if Column.PageWidth = 0 then
      Column.PageWidth := Trunc((Column.Width / SumWidth) * RestWidth);

    Column.PageLeft := Left;
    Inc(Left, Column.PageWidth);
  end;
end;

procedure TDTFPrinter.DoNewPage;
begin
  DoEndPage;

  Printer.NewPage;

  DoBeginPage;
end;

procedure TDTFPrinter.DoBeginPage;
begin
  FCurrY  := FMargin.Top;
  FRowIndex := 0;

  DoPrintPageHeader;
  DoPrintHeader;
end;

procedure TDTFPrinter.DoEndPage;
begin
  DoEndRow;

  DoPrintPageFooter;
end;

procedure TDTFPrinter.DoNewRow;
begin
  DoEndRow;

  if FCurrY >= (FPageHeight + FMargin.Top) then
    DoNewPage;

  DoPrintSeqColumn;

  DoBeginRow;
end;

procedure TDTFPrinter.DoBeginRow;
begin
  if FInBeginRow then
    Exit;
  FInBeginRow := True;
end;

procedure TDTFPrinter.DoEndRow;
begin
  if not FInBeginRow then
    Exit;
  FInBeginRow := False;

  FCurrY := FCurrY + FRowHeight;
  Inc(FRowIndex);

  if poHorzLine in FOptions then
    DoPrintHorzLine(FCurrY);
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
    X := FMargin.Left;
    Y := FCurrY;
    Printer.Canvas.Font.Assign(FTitle.Font);
    W := Printer.Canvas.TextWidth(FTitle.Caption);
    H := Printer.Canvas.TextHeight(FTitle.Caption);

    case FTitle.Alignment of
      taLeftJustify:  ;
      taRightJustify: X := FPageWidth - W;
      taCenter:       X := (FPageWidth - W) div 2;
    end;

    Printer.Canvas.TextOut(X, Y, FTitle.Caption);

    Inc(FCurrY, H + FRowPadding);
  end;
end;

procedure TDTFPrinter.DoPrintSubTitle;
begin
  if poSubtitle in FOptions then
  begin

  end;
end;

procedure TDTFPrinter.DoPrintHeader;
var
  Column: TColumn;
begin
  Printer.Canvas.Font.Assign(FHeaderFont);

  if poHeaderHorzLine in FOptions then
    DoPrintHorzLine(FCurrY);

  for Column in FColumns do
    Printer.Canvas.TextOut(Column.PageLeft + FColPadding, FCurrY, Column.Caption);

  Inc(FCurrY, FRowHeight);

  if poHeaderHorzLine in FOptions then
    DoPrintHorzLine(FCurrY);
end;

procedure TDTFPrinter.DoPrintSeqColumn;
var
  Column: TColumn;
  SeqCol: TSequenceColumn;
begin
  Printer.Canvas.Font.Assign(FFont);
  for Column in FColumns do
  begin
    if Column is TSequenceColumn then
    begin
      SeqCol := TSequenceColumn(Column);
      Printer.Canvas.TextOut(Column.PageLeft + FColPadding, FCurrY, SeqCol.Value.ToString);
      SeqCol.Increment;
    end;
  end;
end;

procedure TDTFPrinter.DoPrintHorzLine(var AY: Integer);
begin
  Printer.Canvas.MoveTo(FMargin.Left,               AY);
  Printer.Canvas.LineTo(FMargin.Left + FPageWidth,  AY);

  Inc(AY, FRowPadding);
end;

procedure TDTFPrinter.DoPrintPageFooter;
var
  Y: Integer;
begin
  if poFooterHorzLine in FOptions then
  begin
    Y := FMargin.Top + FPageHeight;
    DoPrintHorzLine(Y);
  end;
  DoPrintDate(Y);
  DoPrintPageNum(Y);
end;

procedure TDTFPrinter.DoPrintDate(AY: Integer);
var
  X, Y: Integer;
  S: string;
begin
  S := FormatDateTime('YYYY-MM-DD', Date);
  X := FMargin.Left;
  Y := AY;

  Printer.Canvas.Font.Assign(FFont);
  Printer.Canvas.TextOut(X, Y, S);
end;

procedure TDTFPrinter.DoPrintPageNum(AY: Integer);
var
  X, Y, W: Integer;
  NumStr: string;
begin
  NumStr := Printer.PageNumber.ToString;
  W := FCharWidth * Length(NumStr) + FColPadding;
  X := FMargin.Left + FPageWidth - W;
  Y := AY;

  Printer.Canvas.Font.Assign(FFont);
  Printer.Canvas.TextOut(X, Y, NumStr);
end;

function TDTFPrinter.NewRow: TDTFPrinter;
begin
  DoNewRow;
  Result := Self;
end;

function TDTFPrinter.WriteCell(ACol: Integer; AData: string): TDTFPrinter;
var
  Idx: Integer;
  Column: TColumn;
begin
  Result := Self;

  Idx := 0;
  for Column in FColumns do
  begin
    if Column is TSequenceColumn then
      Continue;

    if Idx = ACol then
    begin
      WriteCell(Column, AData);
      Exit;
    end;
    Inc(Idx);
  end;
end;

function TDTFPrinter.WriteCell(AColumn: TColumn; AData: string): TDTFPrinter;
begin
  Printer.Canvas.TextOut(AColumn.PageLeft + FColPadding, FCurrY, AData);

  Result := Self;
end;

procedure TDTFPrinter.WriteRows(ADatas: TArray<string>);
var
  Idx: Integer;
  Column: TColumn;
begin
  NewRow;

  Idx := 0;
  for Column in FColumns do
  begin
    if Column is TSequenceColumn then
      Continue;

    WriteCell(Column, ADatas[Idx]);
    Inc(Idx);
  end;
end;

procedure TDTFPrinter.Print(AWriteDataProc: TProc; AErrorProc: TProc<string> = nil);
begin
  if not ShowDialog then
    Exit;

  try
    DoBeginDoc;

    AWriteDataProc;

    DoEndDoc;
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

end.
