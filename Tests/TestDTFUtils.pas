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
  end;

implementation

uses
  System.SysUtils,
  DTF.Utils.Print;

procedure TTestDTFUtils.Setup;
begin
end;

procedure TTestDTFUtils.TearDown;
begin
end;

procedure TTestDTFUtils.TestPrinterBasic;
var
  I: Integer;
  Printer: TDTFPrinter;
begin
Exit;
  Printer := TDTFPrinter.Create;

  Printer.Options := Printer.Options - [poShowDialog];
  Printer.Options := Printer.Options + [poSequenceColumn];

  Printer.Title.Caption := 'Print test';
  Printer.Subtitle.Caption := '����� ������';

  Printer.Columns.Clear;
  Printer.Columns.Add('����', 100);
  Printer.Columns.Add('����', 300);
  Printer.Columns.Add('��¥', 200);

  Printer.Print(procedure
    var
      I: Integer;
    begin
      for I := 0 to 99 do
        Printer.WriteRows([I.ToString, 'ABCDEFG �����ٶ󸶹ٻ�', FormatDateTime('DD HH:NN:SS', Now)]);

      for I := 100 to 199 do
      begin
        Printer.NewRow
//          .WriteCell(0, I.ToString)
          .WriteCell(1, 'ABCDEFG �����ٶ󸶹ٻ�')
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
