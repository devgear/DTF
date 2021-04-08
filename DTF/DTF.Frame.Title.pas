unit DTF.Frame.Title;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Frame.Base, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TDTFTitleFrame = class(TDTFBaseFrame)
    pnlCaption: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DTFTitleFrame: TDTFTitleFrame;

implementation

{$R *.dfm}

end.
