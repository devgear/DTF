unit DTF.Frame.DBGrid;

interface

uses
  DTF.Frame.DataSet,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Vcl.DBActns, System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, DTF.Frame.Base, DTF.Frame.Title;

type
  TDTFDBGridFrame = class(TDTFDataSetFrame)
    grdMaster: TDBGrid;
    pnlSearchControlArea: TPanel;
  public
    procedure SetSearchPanel(APanel: TPanel; ASearchParamProc: TProc = nil);
  end;

implementation

uses
  DTF.Intf;

{$R *.dfm}

{ TDTFDBGridFrame }

procedure TDTFDBGridFrame.SetSearchPanel(APanel: TPanel; ASearchParamProc: TProc = nil);
var
  I: Integer;
  SC: IDTFSetSearchControl;
begin
  pnlSearchControlArea.Visible := Assigned(APanel) and APanel.Visible;
  pnlSearchControlArea.Caption := '';
  if Assigned(APanel) then
  begin
    APanel.Parent := pnlSearchControlArea;
    APanel.Align := alClient;
    pnlSearchControlArea.Height := APanel.Height;

    // SearchEdit 등록(엔터키 처리)
    if Supports(GetParentForm(Self), IDTFSetSearchControl, SC) then
    begin
      for I := 0 to APanel.ControlCount - 1 do
      begin
        if APanel.Controls[I] is TCustomEdit then
          SC.SetSearchControl(APanel.Controls[I], procedure
            begin
              actDSSearch.Execute;
            end);
      end;
    end;
  end;

  SetSearchParamProc(ASearchParamProc);
end;

end.
