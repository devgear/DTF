unit UserResource;

interface

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
  [ResourceName('users2')]
  TUsersResource = class(TDataModule)
    conBookRental: TFDConnection;
    qryUserList: TFDQuery;
    [ResourceSuffix('list', '/')]
    dsrUserList: TEMSDataSetResource;
    qryUserItem: TFDQuery;
    [ResourceSuffix('get', '{user_seq}')]
    [ResourceSuffix('post', '/')]
    [ResourceSuffix('put', '{user_seq}')]
    [ResourceSuffix('delete', '{user_seq}')]
    dsrUserItem: TEMSDataSetResource;
    qryUser: TFDQuery;
  published
    [ResourceSuffix('{user_seq}/photo')]
    procedure GetItemPhoto(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

var
  UsersResource: TUsersResource;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TUsersResource }

procedure TUsersResource.GetItemPhoto(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
const
  SQL_ITEM_IMAGE ='SELECT USER_IMAGE FROM USERS WHERE USER_SEQ = :USER_SEQ';
var
  USER_SEQ: string;
  Stream: TMemoryStream;
begin
  USER_SEQ := ARequest.Params.Values['user_seq'];

  Stream := TMemoryStream.Create;
  try
    qryUser.Close;
    qryUser.SQL.Text := SQL_ITEM_IMAGE;
    qryUser.ParamByName('USER_SEQ').AsString := USER_SEQ;
    qryUser.Open;

    if qryUser.RecordCount = 0 then
      AResponse.RaiseNotFound('Not found', '''' + USER_SEQ + ''' is not found');

    TBlobField(qryUser.FieldByName('USER_IMAGE')).SaveToStream(Stream);

    if Stream.Size = 0 then
      AResponse.RaiseNotFound('Not found', '''' + USER_SEQ + ''' is not found');

    Stream.Position := 0;
    AResponse.Body.SetStream(Stream, 'image/jpeg', True);
  except
    Stream.Free;
    raise;
  end;
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TUsersResource));
end;

initialization
  Register;

end.
