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

procedure TMyTestObject.Setup;
begin
end;

procedure TMyTestObject.TearDown;
begin
end;

procedure TMyTestObject.TestPrinterBasic;
begin

end;

initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);

end.
