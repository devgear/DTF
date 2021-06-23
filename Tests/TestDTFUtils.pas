unit TestDTFUtils;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TMyTestObject = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestPrinterBasic;
  end;

implementation

uses
  DTF.Utils.Print;

procedure TMyTestObject.Setup;
begin
end;

procedure TMyTestObject.TearDown;
begin
end;

procedure TMyTestObject.TestPrinterBasic;
var
  Printer: TDTFPrinter;
begin
  Printer := TDTFPrinter.Create;

  Printer.Title.Caption := 'Print test';
  Printer.FieldDefs.Clear;
  Printer.FieldDefs.Add('숫자', 100);
  Printer.FieldDefs.Add('문자', 300);
  Printer.FieldDefs.Add('날짜', 200);

  // Print

  Printer.Print;

  // TitleToPerPage

//  Prtr.Title := '';
//  Prtr.AddField(Title, Width);
//  Prtr.Cells[
{
  p.Title
  p.Subtitle
  p.ShowDate := True
  p.ShowPage := True;
  p.LineType := [HorzLine, VertLine] ???

  p.RowCount
  p.ColCount
  p.Fields
  p.AddField(Header, Width, Alignment)

  while
    p.AddRow;

    P.Rows := ['', '', '', ''];
    P.Col[0] := '';

    p.Data(AData);

    q.next
}

  Printer.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);

end.
