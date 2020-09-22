unit DTF.DAO.Rest;

interface

uses
  DTF.DAO,
  Data.DB,
  System.Classes, System.Generics.Collections,
  System.SysUtils, System.JSON, System.JSON.Writers,
  REST.Types, REST.Client, REST.Response.Adapter,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TRestParam = class(TInterfacedObject, IDAOParam)
  public
    Method: TRESTRequestMethod;
    Resource: string;
    Param: string;
    RootElement: string;
  end;

  TRestDataSetDAO = class(TInterfacedObject, IDao<string, TFDDataSet, TJSONObject>)
  private
  protected
    FBaseUrl: string;

    FClient: TRESTClient;
    FRequest: TRESTRequest;
    FResponse: TRESTResponse;
    FAdapter: TRESTResponseDataSetAdapter;
    FDataSet: TFDMemTable;
    FStream: TStream;
  public
    { IDAO }
    function Get(AParam: IDAOParam): TFDDataSet; overload;
    function GetItem(AItem: string; AParam: IDAOParam): TFDDataSet; overload;
    function GetStream(AItem: string; AParam: IDAOParam): TStream;
    function Insert(AParam: IDAOParam; AData: TJSONObject): TFDDataSet;
    procedure UpdateItem(AItem: string; AParam: IDAOParam; AData: TJSONObject);
    procedure DeleteItem(AItem: string; AParam: IDAOParam);

    function Get(AResource, ARoot: string): TFDDataSet; overload;
    function Get(AResource, AParam, ARoot: string): TFDDataSet; overload;

    function GetItem(AItem: string; AResource, AParam, ARoot: string): TFDDataSet; overload;

    constructor Create; virtual;
    destructor Destroy; override;

    property BaseUrl: string read FBaseUrl write FBaseUrl;
  end;

implementation

constructor TRestDataSetDAO.Create;
begin
  FClient := TRESTClient.Create(nil);
  FRequest := TRESTRequest.Create(nil);
  FResponse := TRESTResponse.Create(nil);
  FAdapter := TRESTResponseDataSetAdapter.Create(nil);
  FDataSet := TFDMemTable.Create(nil);

  FRequest.Client := FClient;
  FRequest.Response := FResponse;

  FAdapter.Response := FResponse;
  FAdapter.Dataset := FDataSet;
end;

destructor TRestDataSetDAO.Destroy;
begin
  FClient.Free;
  FRequest.Free;
  FResponse.Free;
  FAdapter.Free;
  FDataSet.Free;

  if Assigned(FStream) then
    FStream.Free;

  inherited;
end;


function TRestDataSetDAO.Get(AParam: IDAOParam): TFDDataSet;
var
  Param: TRestParam;
begin
  Param := AParam as TRestParam;

  Result := Get(Param.Resource, Param.Param, Param.RootElement);
end;

function TRestDataSetDAO.Get(AResource, AParam, ARoot: string): TFDDataSet;
begin
  FClient.BaseURL := FBaseUrl;

  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := AResource;
  if AParam <> '' then
    FRequest.Resource := FRequest.Resource + '?' + AParam;

  FResponse.ResetToDefaults;

  FAdapter.RootElement := ARoot;
  FAdapter.Response := FResponse;
  FAdapter.Active := True;

  FRequest.Execute;

  Result := FDataSet;
end;

function TRestDataSetDAO.Get(AResource, ARoot: string): TFDDataSet;
begin
  Result := Get(AResource, '', ARoot);
end;

function TRestDataSetDAO.GetItem(AItem: string; AParam: IDAOParam): TFDDataSet;
var
  Param: TRestParam;
begin
  Param := AParam as TRestParam;

  Result := GetItem(AItem, Param.Resource, Param.Param, Param.RootElement);
end;

function TRestDataSetDAO.GetItem(AItem, AResource, AParam,
  ARoot: string): TFDDataSet;
begin
  FClient.BaseURL := FBaseUrl;

  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := AResource;
  if AParam <> '' then
    FRequest.Resource := FRequest.Resource + '?' + AParam;
  FRequest.Params.ParameterByName('item').Value := AItem;

  FResponse.ResetToDefaults;

  FAdapter.RootElement := ARoot;
  FAdapter.Response := FResponse;
  FAdapter.Active := True;

  FRequest.Execute;

  Result := FDataSet;
end;

function TRestDataSetDAO.GetStream(AItem: string; AParam: IDAOParam): TStream;
var
  Param: TRestParam;
begin
  Param := AParam as TRestParam;

  Result := nil;

  FResponse.ResetToDefaults;

  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := Param.Resource;
  FRequest.Params.ParameterByName('item').Value := AItem;
  FAdapter.Active := False;
  FAdapter.RootElement := '';
  FAdapter.Response := nil;

  FRequest.Execute;

  if FResponse.StatusCode < 404 then
  begin
    if not Assigned(FStream) then
      FStream := TMemoryStream.Create;

    TMemoryStream(FStream).Clear;
    FStream.WriteData(
        FResponse.RawBytes,
        FResponse.ContentLength);
    Result := FStream;
  end;
end;

function TRestDataSetDAO.Insert(AParam: IDAOParam;
  AData: TJSONObject): TFDDataSet;
var
  Param: TRestParam;
begin
  Param := AParam as TRestParam;

  FClient.BaseURL := FBaseUrl;
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := Param.Resource;
  FAdapter.Active := False;

  FRequest.ClearBody;
  FRequest.Body.Add(AData);
  FRequest.Execute;

  { TODO : 입력한 내용 반환 필요(ID 포함) }
end;

procedure TRestDataSetDAO.UpdateItem(AItem: string; AParam: IDAOParam;
  AData: TJSONObject);
var
  Param: TRestParam;
begin
  Param := AParam as TRestParam;

  FClient.BaseURL := FBaseUrl;
  FRequest.Method := TRESTRequestMethod.rmPUT;
  FRequest.Resource := Param.Resource;
  FRequest.Params.ParameterByName('item').Value := AItem;
  FAdapter.Active := False;

  FRequest.ClearBody;
  FRequest.Body.Add(AData);
  FRequest.Execute;
end;

procedure TRestDataSetDAO.DeleteItem(AItem: string; AParam: IDAOParam);
var
  Param: TRestParam;
begin
  Param := AParam as TRestParam;

  FClient.BaseURL := FBaseUrl;
  FRequest.Method := TRESTRequestMethod.rmDELETE;
  FRequest.Resource := Param.Resource;
  FRequest.Params.ParameterByName('item').Value := AItem;
  FRequest.Execute;
end;

end.
