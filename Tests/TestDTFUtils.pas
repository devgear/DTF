unit TestDTFUtils;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestDTFUtils = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

//    [Test]
    procedure TestPrinterBasic;

    [Test]
    procedure TestArrayUtil;
  end;

implementation

uses
  System.SysUtils,
  DTF.Utils,
  DTF.Utils.Print;

procedure TTestDTFUtils.Setup;
begin
end;

procedure TTestDTFUtils.TearDown;
begin
end;

procedure TTestDTFUtils.TestArrayUtil;
var
  Items: TArray<string>;
begin
  Items := ['1', ' b'];

  TArrayUtil.Trim(Items);

  Assert.AreEqual(Items[1], 'b');
end;

procedure TTestDTFUtils.TestPrinterBasic;
var
  Printer: TDTFPrinter;
begin
Exit;
  Printer := TDTFPrinter.Create;

  Printer.Options := Printer.Options - [poShowDialog];
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

      for I := 100 to 199 do
      begin
        Printer.NewRow
//          .WriteCell(0, I.ToString)
          .WriteCell(1, 'ABCDEFG 가나다라마바사')
          .WriteCell(2, FormatDateTime('DD HH:NN:SS', Now));
      end;
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
  TDUnitX.RegisterTestFixture(TTestDTFUtils);

end.
