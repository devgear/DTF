unit BooksForm;

interface

uses
  BooksModule,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, IPPeerClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client,
  Data.Bind.ObjectScope, FMX.ScrollBox, FMX.Grid, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Memo, FMX.Edit, FMX.Layouts, FMX.ExtCtrls;

type
  TfrmBooks = class(TForm)
    btnLoadData: TButton;
    Grid1: TGrid;
    Label1: TLabel;
    edtTitle: TEdit;
    Label2: TLabel;
    edtAuthor: TEdit;
    Label3: TLabel;
    edtISBN: TEdit;
    Label4: TLabel;
    edtPrice: TEdit;
    Label5: TLabel;
    edtLink: TEdit;
    Label6: TLabel;
    mmoDescription: TMemo;
    btnNewData: TButton;
    btnSaveData: TButton;
    ImageControl1: TImageControl;
    btnDeleteData: TButton;
    BindSourceDB2: TBindSourceDB;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    procedure btnLoadDataClick(Sender: TObject);
    procedure btnNewDataClick(Sender: TObject);
    procedure btnSaveDataClick(Sender: TObject);
    procedure btnDeleteDataClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FViewModel: TdmDataAccess;
    procedure ClearControls;

    procedure ImageLoaded(AStream: TStream);
  public
    { Public declarations }
  end;

var
  frmBooks: TfrmBooks;

implementation

{$R *.fmx}

procedure TfrmBooks.FormCreate(Sender: TObject);
begin
  FViewModel := TdmDataAccess.Create(nil);
  FViewModel.OnImageLoaded := ImageLoaded;

  // 무시해도 바인딩 문제 없음
  BindSourceDB1.DataSet := FViewModel.memBookList;
  BindSourceDB2.DataSet := FViewModel.memBookDetail;
end;

procedure TfrmBooks.FormDestroy(Sender: TObject);
begin
  FViewModel.Free;
end;

procedure TfrmBooks.btnLoadDataClick(Sender: TObject);
begin
  FViewModel.LoadData;
end;

procedure TfrmBooks.btnNewDataClick(Sender: TObject);
begin
  FViewModel.NewData;
  ClearControls;
end;

procedure TfrmBooks.btnSaveDataClick(Sender: TObject);
begin
  FViewModel.SaveData;

  ShowMessage('저장');
end;

procedure TfrmBooks.btnDeleteDataClick(Sender: TObject);
begin
  FViewModel.DeleteData;

  ShowMessage('삭제');
end;

procedure TfrmBooks.ClearControls;
begin
  ImageControl1.Bitmap.Assign(nil);
end;

procedure TfrmBooks.ImageLoaded(AStream: TStream);
begin
  if not Assigned(AStream) or (AStream.Size = 0) then
    ImageControl1.Bitmap.Assign(nil)
  else
    ImageControl1.Bitmap.LoadFromStream(AStream);
end;

end.
