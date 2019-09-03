unit BooksRestApi;

interface

uses
  System.SysUtils,
  DTF.DAO, DTF.DAO.Rest, FireDAC.Comp.DataSet,
  REST.Types, Data.DB,
  System.JSON, System.JSON.Writers;

type
  // Books 리소스에 대한 API 정보 기록
  TBooksRestApi = record
    class function BaseUrl: string; static;

    class function List: IDAOParam; static;
    class function Item: IDAOParam; static;
    class function Photo: IDAOParam; static;
    class function Insert: IDAOParam; static;
    class function Update: IDAOParam; static;
    class function Delete: IDAOParam; static;

    class function DataSetToJSON(ADataSet: TFDDataSet): TJSONObject; static;
  end;

implementation

const
  BASE_URL        = 'http://localhost:8080';
  RESOURCE_LIST   = 'books';
  RESOURCE_ITEM   = 'books/{item}';
  RESOURCE_IMAGE  = 'books/{item}/photo';

//  ROOTELMT_LIST   = 'books.book';
//  ROOTELMT_ITEM   = 'book';
  ROOTELMT_LIST   = '';
  ROOTELMT_ITEM   = '';


{ TBooksRestApi }

class function TBooksRestApi.BaseUrl: string;
begin
  Result := BASE_URL;
end;

class function TBooksRestApi.List: IDAOParam;
var
  Param: TRestParam;
begin
  Param := TRestParam.Create;
  Param.Method := rmGet;
  Param.Resource     := RESOURCE_LIST;
  Param.RootElement  := ROOTELMT_LIST;

  Result := Param;
end;

class function TBooksRestApi.Photo: IDAOParam;
var
  Param: TRestParam;
begin
  Param := TRestParam.Create;
  Param.Method := rmGet;
  Param.Resource     := RESOURCE_IMAGE;
  Param.RootElement  := '';

  Result := Param;
end;

class function TBooksRestApi.DataSetToJSON(ADataSet: TFDDataSet): TJSONObject;
var
  Writer: TJsonObjectWriter;
begin
  if not ADataSet.Active then
  begin
    // 예외처리
  end;

  Writer := TJsonObjectWriter.Create(False);
  try
//    Writer.WriteStartObject;  // start resource
//    Writer.WritePropertyName('book');

    Writer.WriteStartObject;  // start item
    Writer.WritePropertyName('BOOK_TITLE');
    Writer.WriteValue(ADataSet.FieldByName('BOOK_TITLE').AsString);

    Writer.WritePropertyName('BOOK_ISBN');
    Writer.WriteValue(ADataSet.FieldByName('BOOK_ISBN').AsString);

    Writer.WritePropertyName('BOOK_AUTHOR');
    Writer.WriteValue(ADataSet.FieldByName('BOOK_AUTHOR').AsString);

    Writer.WritePropertyName('BOOK_PRICE');
    Writer.WriteValue(ADataSet.FieldByName('BOOK_PRICE').AsString);

    Writer.WritePropertyName('BOOK_LINK');
    Writer.WriteValue(ADataSet.FieldByName('BOOK_LINK').AsString);

    Writer.WritePropertyName('BOOK_DESCRIPTION');
    Writer.WriteValue(ADataSet.FieldByName('BOOK_DESCRIPTION').AsString);

    Writer.WriteEndObject;  // end item
//    Writer.WriteEndObject;  // end resource

    Result := Writer.JSON as TJSONObject;
  finally
    Writer.Free;
  end;
end;

class function TBooksRestApi.Delete: IDAOParam;
var
  Param: TRestParam;
begin
  Param := TRestParam.Create;
  Param.Method := rmDELETE;
  Param.Resource     := RESOURCE_ITEM;
  Param.RootElement  := '';

  Result := Param;
end;

class function TBooksRestApi.Insert: IDAOParam;
var
  Param: TRestParam;
begin
  Param := TRestParam.Create;
  Param.Method := rmPOST;
  Param.Resource     := RESOURCE_LIST;
  Param.RootElement  := '';

  Result := Param;
end;

class function TBooksRestApi.Item: IDAOParam;
var
  Param: TRestParam;
begin
  Param := TRestParam.Create;
  Param.Method := rmGet;
  Param.Resource     := RESOURCE_ITEM;
  Param.RootElement  := ROOTELMT_ITEM;

  Result := Param;
end;

class function TBooksRestApi.Update: IDAOParam;
var
  Param: TRestParam;
begin
  Param := TRestParam.Create;
  Param.Method := rmPUT;
  Param.Resource     := RESOURCE_ITEM;
  Param.RootElement  := '';

  Result := Param;
end;

end.
