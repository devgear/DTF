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
  TPrintUtil = class
  public
    class procedure PrintDataSet(const ADataSet: TDataSet; const ATitle: string = '');
    class procedure PrintDataRows<T>(const ADatas: TArray<T>; const ATitle: string = '');
  end;


  TFieldDef = record
    Caption: string;
    Width: Integer;
  public
    constructor Create(ACaption: string; AWidth: Integer);
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

  TFieldDefs = class(TList<TFieldDef>)
  public
    function Add(ACaption: string; AWidth: Integer): Integer; overload;
  end;

  TDTFPrinter = class
  private
    FFont: TFont;

    FTitle: TTitle;
    FFieldDefs: TFieldDefs;

    FMargin: TRect;
    FTotalFieldWidth: Integer;
    FPerColWidth: Integer;
    FShowPrintDialog: Boolean;

    function PrintDialogExecute: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    property Title: TTitle read FTitle write FTitle;
    property FieldDefs: TFieldDefs read FFieldDefs;
    property ShowPrintDialog: Boolean read FShowPrintDialog write FShowPrintDialog;

    procedure Print;
  end;


implementation

uses
  Vcl.Dialogs;

{ TPrintUtil }

class procedure TPrintUtil.PrintDataSet(const ADataSet: TDataSet; const ATitle: string);
begin

end;

class procedure TPrintUtil.PrintDataRows<T>(const ADatas: TArray<T>;
  const ATitle: string);
begin

end;

{ TFieldDef }

constructor TFieldDef.Create(ACaption: string; AWidth: Integer);
begin
  Caption := ACaption;
  Width := AWidth;
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

{ TFields }

function TFieldDefs.Add(ACaption: string; AWidth: Integer): Integer;
begin
  Result := inherited Add(TFieldDef.Create(ACaption, AWidth));
end;

{ TDTFPrinter }

constructor TDTFPrinter.Create;
begin
  FFont := TFont.Create;

  FFieldDefs := TFieldDefs.Create;

  FShowPrintDialog := True;

  FTitle := TTitle.Create;
  FTitle.Alignment := taCenter;
  FTitle.Font.Size := 12;
  FTitle.Font.Style := [fsBold];

  FMargin.Top     := Printer.PageHeight div 50;
  FMargin.Bottom  := Printer.PageHeight div 50;

  FMargin.Left    := Printer.PageWidth div 50;
  FMargin.Right   := Printer.PageWidth div 50;

end;

destructor TDTFPrinter.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FFieldDefs);

  inherited;
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

procedure TDTFPrinter.Print;
begin
//  Printer.Canvas.Font.Assign(FFont);
  if PrintDialogExecute then
    WriteLn(Printer.PageNumber);
  ;

//  Printer.Title
end;

function TDTFPrinter.PrintDialogExecute: Boolean;
var
  Dialog: TPrintDialog;
begin
  Result := True;
  if FShowPrintDialog then
  begin
    Dialog := TPrintDialog.Create(nil);
    Result := Dialog.Execute;
    Dialog.Free;
  end;
end;

end.
