unit BookResource;

// EMS Resource Module

interface

{$DEFINE DSR}



uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Stan.StorageJSON, FireDAC.Phys.IBBase, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, EMS.FileResource, EMS.DataSetResource;

type
  [ResourceName('books')]
  TBooksResource = class(TDataModule)
    conBookRental: TFDConnection;
    qryBook: TFDQuery;
    qryBookList: TFDQuery;
    [ResourceSuffix('list', '/')]
    dsrBookList: TEMSDataSetResource;
    qryBookItem: TFDQuery;
    [ResourceSuffix('get', '{book_seq}')]
    [ResourceSuffix('post', '/')]
    [ResourceSuffix('put', '{book_seq}')]
    [ResourceSuffix('delete', '{book_seq}')]
    dsrBookItem: TEMSDataSetResource;
    // 유효성체크 필요 > 중복된 데이터 확인은 어떻게?

    procedure conBookRentalBeforeConnect(Sender: TObject);
    procedure dsrBookListGetParam(ASender: TObject; const AName: string;
      var AValue: string);
    procedure qryBookItemBeforeInsert(DataSet: TDataSet);
  published
    [ResourceSuffix('{book_seq}/photo')]
    procedure GetItemPhoto(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses
  System.IOUtils,
  System.JSON.Writers,
  System.JSON.Builders,
  System.JSON.Types;

{$R *.dfm}

procedure TBooksResource.conBookRentalBeforeConnect(Sender: TObject);
var
  Path: string;
begin
  Path := TPath.GetFullPath('..\DB\BOOKRENTAL.IB');
  if not TFile.Exists(Path) then
  begin
    raise Exception.Create('Not found database.');
  end;

  conBookRental.Params.Values['Database'] := Path;
end;

procedure TBooksResource.dsrBookListGetParam(ASender: TObject;
  const AName: string; var AValue: string);
begin
  if AName = 'TITLE' then
    AValue := '%' + AValue + '%';
end;

procedure TBooksResource.GetItemPhoto(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
const
  SQL_ITEM_IMAGE ='SELECT BOOK_IMAGE FROM BOOK WHERE BOOK_SEQ = :BOOK_SEQ';
var
  BOOK_SEQ: string;
  Stream: TMemoryStream;
begin
  BOOK_SEQ := ARequest.Params.Values['book_seq'];

  Stream := TMemoryStream.Create;
  try
    qryBook.Close;
    qryBook.SQL.Text := SQL_ITEM_IMAGE;
    qryBook.ParamByName('BOOK_SEQ').AsString := BOOK_SEQ;
    qryBook.Open;

    if qryBook.RecordCount = 0 then
      AResponse.RaiseNotFound('Not found', '''' + BOOK_SEQ + ''' is not found');

    TBlobField(qryBook.FieldByName('BOOK_IMAGE')).SaveToStream(Stream);

    if Stream.Size = 0 then
      AResponse.RaiseNotFound('Not found', '''' + BOOK_SEQ + ''' is not found');

    Stream.Position := 0;
    AResponse.Body.SetStream(Stream, 'image/jpeg', True);
  except
    Stream.Free;
    raise;
  end;
end;

procedure TBooksResource.qryBookItemBeforeInsert(DataSet: TDataSet);
begin
  //
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TBooksResource));
end;

initialization
  Register;
end.


