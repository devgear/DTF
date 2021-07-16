unit TestDTFConfig;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestDTFConfig = class
  private
    FFilename: string;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestLoadDefaultValue;

    [Test]
    procedure TestSaveValue;
  end;

implementation

uses
  DTF.Config.Types,
  DTF.Service.Config,
  DTF.Config.IniLoader,

  Vcl.Forms, System.Types,
  System.IniFiles,
  System.SysUtils, System.IOUtils;

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

//    [RecProp('Test', 'Left=10,Top=20')]
    [RecProp('Test', '10,20,30,40')]
    property WindowBounds: TRect read FWindowBounds write FWindowBounds;
  end;

{ TTestDTFConfig }

procedure TTestDTFConfig.Setup;
begin
  FFilename := ExtractFilePath(Paramstr(0)) + 'config.ini';
end;

procedure TTestDTFConfig.TearDown;
begin

end;

procedure TTestDTFConfig.TestLoadDefaultValue;
var
  Config: TTestConfig;
begin
  if TFile.Exists(FFilename) then
    TFile.Delete(FFilename);

  Config := TTestConfig.Create;

  Assert.AreEqual(Config.Int, 10);
  Assert.AreEqual(Config.Str, 'abc');
  Assert.AreEqual(Config.Bool, True);
  Assert.AreEqual(Config.WindowState, wsMaximized);
  Assert.AreEqual(Config.WindowBounds.Left, 10);

  Config.Free;
end;

procedure TTestDTFConfig.TestSaveValue;
var
  Inifile: TInifile;
  Config: TTestConfig;
begin
  Config := TTestConfig.Create;
  Config.Int := 100;
  Config.Free;

  Inifile := TIniFile.Create(FFilename);
  Inifile.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestDTFConfig);

end.
