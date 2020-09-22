unit DTF.Frame.DBGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Frames.DataSet, Data.DB,
  Vcl.DBActns, System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TfmeDTFDBGrid = class(TfmeDTFDataSet)
    DBGrid1: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmeDTFDBGrid: TfmeDTFDBGrid;

implementation

{$R *.dfm}

end.
