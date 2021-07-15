unit TestDTFConfig;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestDTFConfig = class
  public
    [Test]
    procedure TestConfigLoad;
  end;

implementation

uses
  DTF.Config.Types,
  DTF.Service.Config,
  Vcl.Forms, System.Types;

type
  [IniFilename('config.ini')]
  TTestConfig = class(TConfigServiceProvider)
  private
    FInt: Integer;
    FStr: string;
    FBool: Boolean;
    FWindowState: TWindowState;
    FWindowBounds: TRect;
  public
    [IntProp('Test', 10)]
    property Int: Integer read FInt write FInt;

    [StrProp('Test', 'abc')]
    property Str: string read FStr write FStr;

    [BoolProp('Test', True)]
    property Bool: Boolean read FBool write FBool;

    [EnumProp('Test', 'wsMaximized')]
    property WindowState: TWindowState read FWindowState write FWindowState;

    [RecProp('Test', '10,20,30,40')]
    property WindowBounds: TRect read FWindowBounds write FWindowBounds;
  end;

{ TTestDTFConfig }

procedure TTestDTFConfig.TestConfigLoad;
var
  Config: TTestConfig;
begin
  Config := TTestConfig.Create;

  Assert.AreEqual(Config.Int, 10);
  Assert.AreEqual(Config.Str, 'abc');
  Assert.AreEqual(Config.Bool, True);
  Assert.AreEqual(Config.WindowState, wsMaximized);
  Assert.AreEqual(Config.WindowBounds.Left, 10);

  Config.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestDTFConfig);

end.
