unit DTF.Intf;

interface

uses
  Vcl.Controls, System.SysUtils;

type
  IDTFSetSearchControl = interface
    ['{E56B42DE-A5EA-4127-9454-4174D9D170BC}']
    procedure SetSearchControl(AControl: TControl; ASearchProc: TProc);
  end;

  IDTFImportGridData = interface
    ['{8C55B3AE-BC9E-408D-8949-1B9B2670B355}']
    function LoadFile(AFilename: string = ''): Boolean;
    function GetData(const ACol, ARow: Integer): string;
    function GetDatas(const ARow: Integer): TArray<string>;
    function GetRowCount: Integer;
    function GetColCount: Integer;

    property RowCount: Integer read GetRowCount;
    property ColCount: Integer read GetColCount;
    property Data[const ACol, ARow: Integer]: string read GetData;
    property Datas[const ARow: Integer]: TArray<string> read GetDatas;
  end;

  IDTFFrameTitle = interface
    ['{37FC566C-4BB7-4F18-A327-0A6E03A26AD6}']
    function GetFrameTitle: string;
  end;

implementation

end.
