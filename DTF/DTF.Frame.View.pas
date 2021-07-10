unit DTF.Frame.View;

interface

uses
  DTF.Types,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Frame.Base, DTF.Frame.Title;

type
  TDTFViewFrame = class(TDTFBaseFrame)
    DTFTitleFrame1: TDTFTitleFrame;
  private
    function GetTitle: string;
    { Private declarations }
  public
    { Public declarations }
    property Title: string read GetTitle;
  end;

var
  DTFViewFrame: TDTFViewFrame;

implementation

{$R *.dfm}

{ TDTFViewFrame }

function TDTFViewFrame.GetTitle: string;
var
  FrameTitle: IDTFFrameTitle;
begin
  if Supports(DTFTitleFrame1, IDTFFrameTitle, FrameTitle) then
    Result := FrameTitle.GetFrameTitle;
end;

end.
