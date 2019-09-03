unit RentalResouce;

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
  [ResourceName('rental')]
  TRentalsResource = class(TDataModule)
    conBookRental: TFDConnection;
    qryRentalList: TFDQuery;
    [ResourceSuffix('list', '/')]
    dsrRentalList: TEMSDataSetResource;
    qryRentalListBOOK_TITLE: TWideStringField;
    qryRentalListUSER_NAME: TWideStringField;
    qryRentalListRENT_SEQ: TIntegerField;
    qryRentalListUSER_SEQ: TIntegerField;
    qryRentalListBOOK_SEQ: TIntegerField;
    qryRentalListRENT_DATE: TDateField;
    qryRentalListRENT_RETURN_DATE: TDateField;
    qryRentalListRENT_RETURN_YN: TStringField;
  published
   [ResourceSuffix('./{rent_seq}')]
   procedure Put(const AContext: TEndpointContext;
     const ARequest: TEndpointRequest;
     const AResponse: TEndpointResponse);
   procedure Post(const AContext: TEndpointContext;
     const ARequest: TEndpointRequest;
     const AResponse: TEndpointResponse);
  end;

var
  RentalsResource: TRentalsResource;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
  System.JSON.Writers;

{ TRentalsResource }

// 대출 신청
procedure TRentalsResource.Post(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  JSON: TJSONValue;
  UserSeq, BookSeq: Integer;
  Writer: TJsonObjectWriter;
begin
  JSON := ARequest.Body.GetValue;

  UserSeq := JSON.GetValue<Integer>('USER_SEQ');
  BookSeq := JSON.GetValue<Integer>('BOOK_SEQ');

  qryRentalList.Open;
  qryRentalList.Append;
  qryRentalList.FieldByName('BOOK_SEQ').AsInteger := BookSeq;
  qryRentalList.FieldByName('USER_SEQ').AsInteger := UserSeq;
  qryRentalList.FieldByName('RENT_DATE').AsDateTime := Now;
  qryRentalList.FieldByName('RENT_RETURN_DATE').AsDateTime := Now + 20;
  qryRentalList.FieldByName('RENT_RETURN_YN').AsString := 'N';
  qryRentalList.Post;

  Writer := TJsonObjectWriter.Create;
  try
    Writer.WriteStartObject;  // start item
    Writer.WritePropertyName('RENT_SEQ');
    Writer.WriteValue(qryRentalList.FieldByName('RENT_SEQ').AsInteger);
    Writer.WriteEndObject;

    AResponse.Body.SetValue(Writer.JSON as TJSONValue, True);
  except
    Writer.Free;
    raise;
  end;

end;

// 대출 반납
procedure TRentalsResource.Put(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin

end;

procedure Register;
begin
  RegisterResource(TypeInfo(TRentalsResource));
end;

initialization
  Register;

end.
