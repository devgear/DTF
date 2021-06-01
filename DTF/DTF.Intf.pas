unit DTF.Intf;

interface

uses
  Vcl.Controls, System.SysUtils;

type
  IDTFSetSearchControl = interface
    ['{E56B42DE-A5EA-4127-9454-4174D9D170BC}']
    procedure SetSearchControl(AControl: TControl; ASearchProc: TProc);
  end;

implementation

end.
