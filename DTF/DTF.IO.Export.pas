unit DTF.IO.Export;

interface

uses
  Vcl.Forms, Vcl.Controls,
  System.SysUtils,
  Data.DB;

type
  EDTFIOException = class(Exception);

  TExportDataSetHelper = class helper for TDataSet
  public
    procedure ExportToXls(AFilename: string; ASheetName: string = '';
      AIncludeLabel: Boolean = True; AShowAfterSave: Boolean = True);
  end;

implementation

uses
  System.IOUtils, System.Variants,
  System.Win.ComObj;

{ TExportDataSetHelper }

procedure TExportDataSetHelper.ExportToXls(AFilename: string; ASheetName: string = '';
      AIncludeLabel: Boolean = True; AShowAfterSave: Boolean = True);
var
  I: Integer;
  LExcel: Variant;
  LWorkBook: Variant;
  LWorkSheet: Variant;
  LDatas: Variant;
  LoadedBook: Boolean;

  Row, Rows, Cols: Integer;
  ColIdxs: TArray<Integer>;
  LRange: string;

  Field: TField;
  LBookmark: TBookmark;
  OldCursor: TCursor;
begin
  OldCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    try
      LExcel := CreateOleObject('excel.application');
    except
      raise EDTFIOException.Create('Excel OLE server not found');
    end;

    if AShowAfterSave then
      LExcel.Visible := True;

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
  //    if LWorkBook.Sheets.Count > 0 then
  //      LWorkSheet := LWorkBook.ActiveSheet
  //    else
        LWorkSheet := LWorkBook.WorkSheets.Add;
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
    Rows := RecordCount;
    if AIncludeLabel then
      Rows := Rows + 1;

    Cols := 0;
    SetLength(ColIdxs, FieldCount);
    for I := 0 to FieldCount -1 do
      ColIdxs[I] := -1;
    for I := 0 to FieldCount - 1 do
    begin
      Field := Fields[I];
      if (not Field.Visible) or not (Field.FieldKind in [fkData, fkLookup, fkCalculated]) then
        Continue;

      ColIdxs[Cols] := I;
      Inc(Cols);
    end;

    Row := 0;
    LDatas := VarArrayCreate([0, Rows-1,0, Cols-1], VarVariant);
    if AIncludeLabel then
    begin
      for I := 0 to Cols - 1 do
        LDatas[0, I] := Fields[ColIdxs[I]].DisplayLabel;
      Row := 1;
    end;
    LBookmark := GetBookmark;
    DisableControls;
    try
      First;
      while not Eof do
      begin
        for I := 0 to Cols - 1 do
          LDatas[Row, I] := Fields[ColIdxs[I]].DisplayText;

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

    if not AShowAfterSave then
      LExcel.Quit;
    LExcel := unAssigned;
  finally
    Screen.Cursor := OldCursor;
  end;
end;

end.
