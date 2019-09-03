unit BooksRepository;

interface

{
  Repository 구현
   - 필요한 데이터 제공

  BooksRepository
   - IBooksRepository에서 메소드 선언
}

uses
  BooksRestApi,
  DTF.Repository, DTF.DAO, DTF.DAO.Rest,
  System.SysUtils, System.Classes,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  // 인터페이스 선언(필요한 메소드 선언)
  IBooksRepository = interface
    // 업무에 필요한 메소드를 아래에 구현
    function List: TFDDataSet;
    function Item(ASeq: Integer): TFDDataSet;
    function Image(ASeq: Integer): TStream;

    procedure Insert(ADataSet: TFDDataSet);
    procedure UpdateItem(ASeq: Integer; ADataSet: TFDDataSet);
    procedure DeleteItem(ASeq: Integer);
  end;

  // 데이터 연동 구현(연결할 서비스용 DAO 이용)
  { TODO :
    페이징 형식의 데이터를 연쇄적으로 받아 병합하는 기능 추가 필요
    TRepository에 메소드 추가 후 TRestRepository 등 한단계 더 필요할 것으로 생각됨 }
  TBooksRestRepository = class(TRepository, IBooksRepository)
  private
    FDao: TRestDataSetDAO; // 연결할 서비스의 DAO 이용
  public
    { IBooksRepository }
    function List: TFDDataSet;
    function Item(ASeq: Integer): TFDDataSet;
    function Image(ASeq: Integer): TStream;

    procedure Insert(ADataSet: TFDDataSet);
    procedure UpdateItem(ASeq: Integer; ADataSet: TFDDataSet);
    procedure DeleteItem(ASeq: Integer);

    constructor Create(ADao: TRestDataSetDAO = nil);
    destructor Destroy; override;
  end;

implementation

{ TBooksRestRepository }

constructor TBooksRestRepository.Create(ADao: TRestDataSetDAO);
begin
  if Assigned(ADao) then
    FDao := ADao
  else
    FDao := TRestDataSetDAO.Create;
  FDao.BaseUrl := TBooksRestApi.BaseUrl;
end;

destructor TBooksRestRepository.Destroy;
begin
  FDao.Free;

  inherited;
end;

function TBooksRestRepository.List: TFDDataSet;
var
  Param: IDAOParam;
begin
  Param := TBooksRestApi.List;
  // API에 대한 정보(Param)을 그대로 넘기는 것이 맞는가? 너무 일반화되어 어렵다는 느낌이 있다.

  Result := FDao.Get(Param);
  //  Result := FDao.Get(FBooksApi.List.Resource, FBooksApi.List.RootElement);
end;

procedure TBooksRestRepository.UpdateItem(ASeq: Integer; ADataSet: TFDDataSet);
begin
  FDao.UpdateItem(ASeq.ToString, TBooksRestApi.Update, TBooksRestApi.DataSetToJSON(ADataSet));
end;

function TBooksRestRepository.Image(ASeq: Integer): TStream;
begin
  Result := FDao.GetStream(ASeq.ToString, TBooksRestApi.Photo);
end;

procedure TBooksRestRepository.Insert(ADataSet: TFDDataSet);
begin
  FDao.Insert(TBooksRestApi.Insert, TBooksRestApi.DataSetToJSON(ADataSet))
end;

function TBooksRestRepository.Item(ASeq: Integer): TFDDataSet;
begin
  Result := FDao.GetItem(ASeq.ToString, TBooksRestApi.Item)
end;

procedure TBooksRestRepository.DeleteItem(ASeq: Integer);
begin
  FDao.DeleteItem(ASeq.ToString, TBooksRestApi.Delete);
end;

end.
