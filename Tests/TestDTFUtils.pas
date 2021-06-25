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
  System.SysUtils,
  DTF.Utils.Print;

procedure TMyTestObject.Setup;
begin
end;

procedure TMyTestObject.TearDown;
begin
end;

procedure TMyTestObject.TestPrinterBasic;
var
  I: Integer;
  Printer: TDTFPrinter;
begin
  Printer := TDTFPrinter.Create;

  Printer.Options := Printer.Options + [poSequenceColumn];

  Printer.Title.Caption := 'Print test';
  Printer.Subtitle.Caption := '여기는 부제목';

  Printer.Columns.Clear;
  Printer.Columns.Add('숫자', 100);
  Printer.Columns.Add('문자', 300);
  Printer.Columns.Add('날짜', 200);

  Printer.Print(procedure
    var
      I: Integer;
    begin
      for I := 0 to 99 do
        Printer.WriteRows([I.ToString, 'ABCDEFG 가나다라마바사', FormatDateTime('DD HH:NN:SS', Now)]);
    end,
    procedure(AErr: string)
    begin
      WriteLn(AErr);
    end
  );

//  Printer.BeginDoc;
//
//  Printer.EndDoc;
  Printer.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);

end.
