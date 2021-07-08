unit DTF.Utils.Export;

interface

uses
  Vcl.Forms, Vcl.Controls,
  System.SysUtils,
  Data.DB, DTF.Utils.Print;

type
  EDTFIOException = class(Exception);

  TExportUtil = class
    class procedure SaveToXlsFromDataset(const ADataSet: TDataSet; const AFilename: string; const ASheetName: string = '';
      const ASetNumberFormatLocal: Boolean = True; const AIncludeLabel: Boolean = True; const AShowAfterSave: Boolean = True);
    class procedure PrintFromDataSet(const ADataSet: TDataSet; const ATitle: string = '');

    class procedure PrintFromDataRec<DataType, ItemType>(const ADataRec: DataType;
      const ATitle: string = ''; ASetOptionProc: TProc<TDTFPrinter> = nil);
  end;


implementation

uses
  System.IOUtils, System.Variants,
  System.Win.ComObj,
  DTF.Utils.Extract;

{ TExportUtil }

class procedure TExportUtil.PrintFromDataRec<DataType, ItemType>(
  const ADataRec: DataType; const ATitle: string;
  ASetOptionProc: TProc<TDTFPrinter>);
var
  I: Integer;
  Printer: TDTFPrinter;

  ColProp: TColInfoProp;
  ColProps: TColInfoProps;
  Datas: TDataTable;
begin
  if not TExtractUtil.TryGetColProps<ItemType>(ColProps) then
    Exit;

  Printer := TDTFPrinter.Create;

  Printer.Title.Caption := ATitle;

  Printer.Columns.Clear;
  for ColProp in ColProps do
    Printer.Columns.Add(ColProp.Attr.Caption, ColProp.Attr.ColWidth);

  if Assigned(ASetOptionProc) then
    ASetOptionProc(Printer);

  Printer.Print(procedure
    var
      I: Integer;
      Data: TDataRecord;
    begin
      Datas := TExtractUtil.ExtractDataTable<DataType, ItemType>(ColProps, ADataRec);
      for Data in Datas do
        Printer.WriteRows(Data);
    end
  );
  Printer.Free;
end;

class procedure TExportUtil.PrintFromDataSet(const ADataSet: TDataSet;
  const ATitle: string);
var
  I: Integer;
  Printer: TDTFPrinter;
  Cols: Integer;
  ColIdxs: TArray<Integer>;

  Field: TField;
  LBookmark: TBookmark;
  OldCursor: TCursor;
begin
  Printer := TDTFPrinter.Create;

//  Printer.Options := Printer.Options + [poSequenceColumn];

  Printer.Title.Caption := ATitle;

  Cols := 0;
  SetLength(ColIdxs, ADataSet.FieldCount);
  for I := 0 to ADataSet.FieldCount -1 do
    ColIdxs[I] := -1;
  for I := 0 to ADataSet.FieldCount - 1 do
  begin
    Field := ADataSet.Fields[I];
    if (not Field.Visible) or not (Field.FieldKind in [fkData, fkLookup, fkCalculated]) then
      Continue;

    ColIdxs[Cols] := I;
    Inc(Cols);
  end;

  // Set columns
  Printer.Columns.Clear;
  for I := 0 to Cols - 1 do
    Printer.Columns.Add(ADataSet.Fields[ColIdxs[I]].DisplayLabel, ADataSet.Fields[ColIdxs[I]].DisplayWidth);

  Printer.Print(procedure
    var
      I: Integer;
    begin
      LBookmark := ADataSet.GetBookmark;
      ADataSet.DisableControls;
      try
        ADataSet.First;
        while not ADataSet.Eof do
        begin
          Printer.NewRow;
          for I := 0 to Cols - 1 do
            Printer.WriteCell(I, ADataSet.Fields[ColIdxs[I]].DisplayText);
          ADataSet.Next
        end;
      finally
        ADataSet.GotoBookmark(LBookMark);
        ADataSet.EnableControls;
        ADataSet.FreeBookmark(LBookmark);
      end;
    end
  );

  Printer.Free;
end;

class procedure TExportUtil.SaveToXlsFromDataset(const ADataSet: TDataSet; const AFilename: string; const ASheetName: string = '';
      const ASetNumberFormatLocal: Boolean = True; const AIncludeLabel: Boolean = True; const AShowAfterSave: Boolean = True);
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
    Cols := 0;
    SetLength(ColIdxs, ADataSet.FieldCount);
    for I := 0 to ADataSet.FieldCount -1 do
      ColIdxs[I] := -1;
    for I := 0 to ADataSet.FieldCount - 1 do
    begin
      Field := ADataSet.Fields[I];
      if (not Field.Visible) or not (Field.FieldKind in [fkData, fkLookup, fkCalculated]) then
        Continue;

      ColIdxs[Cols] := I;
      Inc(Cols);
    end;

    Row := 0;
    LBookmark := ADataSet.GetBookmark;
    ADataSet.DisableControls;
    try
      ADataSet.Last; // FetchRowSize 지정된 경우 일부만 출력될 수 있음
      Rows := ADataSet.RecordCount;
      if AIncludeLabel then
        Rows := Rows + 1;

      LDatas := VarArrayCreate([0, Rows-1,0, Cols-1], VarVariant);
      if AIncludeLabel then
      begin
        for I := 0 to Cols - 1 do
          LDatas[0, I] := ADataSet.Fields[ColIdxs[I]].DisplayLabel;
        Row := 1;
      end;

      ADataSet.First;
      while not Eof do
      begin
        for I := 0 to Cols - 1 do
          LDatas[Row, I] := ADataSet.Fields[ColIdxs[I]].DisplayText;

        Inc(Row);
        ADataSet.Next
      end;
    finally
      ADataSet.GotoBookmark(LBookMark);
      ADataSet.EnableControls;
      ADataSet.FreeBookmark(LBookmark);
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

    if ASetNumberFormatLocal then
    begin
      for I := 0 to Cols - 1 do
        if ADataSet.Fields[ColIdxs[I]].DataType in [ftString, ftWideString] then
          LWorkSheet.Columns[I+1].NumberFormatLocal := '@';
    end;
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
