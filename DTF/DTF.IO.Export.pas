unit DTF.IO.Export;

interface

uses
  System.SysUtils,
  Data.DB;

type
  EDTFIOException = class(Exception);

  TExportDataSetHelper = class helper for TDataSet
  public
    procedure ExportToXls(AFilename: string; ASheetName: string = '');
  end;

implementation

uses
  System.IOUtils, System.Variants,
  System.Win.ComObj;

{ TExportDataSetHelper }

procedure TExportDataSetHelper.ExportToXls(AFilename: string; ASheetName: string = '');
var
  I: Integer;
  LExcel: Variant;
  LWorkBook: Variant;
  LWorkSheet: Variant;
  LDatas: Variant;
  LoadedBook: Boolean;

  Row, Col, Rows, Cols: Integer;
  ColIdxs: TArray<Integer>;
  LRange: string;

  Field: TField;
  LBookmark: TBookmark;
begin
  try
    LExcel := CreateOleObject('excel.application');
  except
    raise EDTFIOException.Create('Excel OLE server not found');
  end;

  ///////////////////////
  // Open WorkBook & WorkSheet
  LoadedBook := False;
  if TFile.Exists(AFilename) then
  begin
    LWorkBook := LExcel.WorkBooks.Open(AFilename);
    LoadedBook := True;
  end
  else
    LWorkBook := LExcel.WorkBooks.Add;

  if ASheetName = '' then
  begin
    if LWorkBook.Sheets.Count > 0 then
      LWorkSheet := LWorkBook.ActiveSheet
    else
      LWorkSheet := LWorkBook.Add;
  end
  else
  begin
    LWorkSheet := unAssigned;

    for I := 1 to LWorkBook.Sheets.Count do
    begin
      if LWorkBook.Sheets[I].Name = ASheetName then
      begin
        LWorkSheet := LWorkBook.Sheets[I];
        Break;
      end;
    end;

    if VarIsEmpty(LWorkSheet) then
    begin
      LWorkSheet := LWorkBook.WorkSheets.Add;
      LWorkSheet.Name := ASheetName;
    end;
  end;

  ///////////////////////
  // Export data
  Rows := Self.RecordCount;
//  Cols := Self.FieldCount;
  Cols := 0;
  SetLength(ColIdxs, FieldCount);
  for I := 0 to FieldCount -1 do
    ColIdxs[I] := -1;
  for I := 0 to FieldCount - 1 do
  begin
    Field := Fields[I];
    if (not Field.Visible) or not (Field.FieldKind in [fkData]) then
      Continue;

    ColIdxs[Cols] := I;
    Inc(Cols);
  end;


  Row := 0;
  LDatas := VarArrayCreate([0, Rows-1,0, Cols-1], VarVariant);
  LBookmark := GetBookmark;
  DisableControls;
  try
    First;
    while not Eof do
    begin
      for I := 0 to Cols - 1 do
        LDatas[Row, ColIdxs[I] := Fields[I].AsVariant;

      Inc(Row);
      Next
    end;
  finally
    GotoBookmark(LBookMark);
    EnableControls;
    FreeBookmark(LBookmark);
  end;

  LRange := 'A1:';
  if Cols > 26 then
  begin
    if Cols mod 26 = 0 then
    begin
      LRange := LRange + Chr(Ord('A') - 2 + (Cols div 26));
      LRange := LRange + 'Z';
    end
    else
    begin
      LRange := LRange + Chr(Ord('A') - 2 + (Cols div 26));
      LRange := LRange + Chr(Ord('A') - 1 + (Cols mod 26));
    end;
  end
  else
    LRange := LRange + Chr(Ord('A') - 1 + Cols);

  LRange := LRange + IntToStr(Rows);

  LWorkSheet.Range[LRange].Value := LDatas;


  ///////////////////////
  // Save file
  try
    if LoadedBook then
      LWorkBook.Save
    else
      LWorkBook.SaveAs(AFilename);
  except
  end;

  LExcel.Quit;
  LExcel := unAssigned;
end;

end.
