unit SYS1010;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Form.DataSet,
  Vcl.BaseImageCollection, Vcl.ImageCollection, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, Vcl.DBActns, System.Actions, Vcl.ActnList, Data.DB,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  DatabaseModule, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids,
  DTF.Form.Base, DTF.Form.MDIChild,
  DTF.Frames.Base, DTF.Frames.DataSet, DTF.Frame.DBGrid;

type
  TfrmSYS1010 = class(TfrmDTFMDIChild)
    qryMenuCates: TFDQuery;
    qryMenuCatesCATE_SEQ: TIntegerField;
    qryMenuCatesCATE_NAME: TWideStringField;
    pnlClient: TPanel;
    pnlBottom: TPanel;
    pnlCate: TPanel;
    pnlPreview: TPanel;
    pnlGroup: TPanel;
    pnlMenu: TPanel;
    fmeCate: TfmeDTFDBGrid;
    fmeGroup: TfmeDTFDBGrid;
    qryMenuGroup: TFDQuery;
    qryMenuGroupGROUP_SEQ: TIntegerField;
    qryMenuGroupGROUP_NAME: TWideStringField;
    Panel1: TPanel;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    Panel2: TPanel;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    qryMenuGroupCATE_SEQ: TIntegerField;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    procedure PanelResize;
  public
    { Public declarations }
  end;

var
  frmSYS1010: TfrmSYS1010;

implementation

{$R *.dfm}

uses MenuFactory;


procedure TfrmSYS1010.FormResize(Sender: TObject);
begin
  PanelResize;
end;

procedure TfrmSYS1010.PanelResize;
begin
  pnlBottom.Height := Height div 2;

  pnlCate.Width := Width div 2;
  pnlGroup.Width := Width div 2;
end;

initialization
  TMenuFactory.Instance.Regist('SYS1010', TfrmSYS1010);
finalization
end.
