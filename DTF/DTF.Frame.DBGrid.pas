unit DTF.Frame.DBGrid;

interface

uses
  DTF.Frame.DataSet,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.DBActns, System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TDTFDBGridFrame = class(TDTFDataSetFrame)
    grdMaster: TDBGrid;
    pnlSearchControlArea: TPanel;
  private
  published
//    property OnSearchPanel: TPanel read FOnSearchPanel write FOnSearchPanel;
//    property OnSearchParam
  public
    procedure SetSearchPanel(APanel: TPanel);
  end;

implementation

{$R *.dfm}

{ TDTFDBGridFrame }

procedure TDTFDBGridFrame.SetSearchPanel(APanel: TPanel);
begin
  pnlSearchControlArea.Visible := Assigned(APanel) and APanel.Visible;
  pnlSearchControlArea.Caption := '';
  if Assigned(APanel) then
  begin
    APanel.Parent := pnlSearchControlArea;
    APanel.Align := alClient;
    pnlSearchControlArea.Height := APanel.Height;
  end;

  // SearchControl 이벤트 연동(엔터키 등)
end;

end.
