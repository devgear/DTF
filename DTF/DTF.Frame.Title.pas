unit DTF.Frame.Title;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Frame.Base, Vcl.ExtCtrls,
  Vcl.StdCtrls, DTF.Intf;

type
  TDTFTitleFrame = class(TDTFBaseFrame, IDTFFrameTitle)
    pnlCaption: TPanel;
  private
    { Private declarations }
    function GetFrameTitle: string;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TDTFTitleFrame }

function TDTFTitleFrame.GetFrameTitle: string;
begin
  Result := pnlCaption.Caption;
end;

end.
