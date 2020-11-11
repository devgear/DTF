unit DTF.Data.DataSetRepository;

interface

uses
  System.Classes, Data.DB;

{
  DataSetRepository 컨셉
   구현부 동일 인터페이스로, 설정으로 다양한 데이터(더미, DB, REST 등) 서비스와 연동
   데이터 서비스는 데이터셋의 메소드(Open,, Post, Delete, ApplyUpdate 등)에 맞게 구현
   예) RestDSRepSvc의 DataSet Open 시 Get 호출

   TDataSetRepository 컴포넌트
    1, 디자인 타임에서 필드 정보를 설정할 수 있어야 한다.(VirtualDataSet)
    2, 더미 데이터를 통해 디자인 중 화면을 확인할 수 있어야 한다.
    3, 런타임에서는 설정한 서비스의 데이터를 제공해야 한다.
   IDataSetRepService
    1, 데이터 모듈 등에서 인터페이스를 구현
    2, 다양한 인터페이스를 등록
    3, 설정으로 데이터 종류 선택
    4, 각 데이터 서비스에서는 DataSet 기본 메소드(Open,, Post, Delete, ApplyUpdate 등)에 맞게 구현


  < Extension feature >
  DAORepository로 Object Oriented 구현
   - LoginDaoRep
}

type
  IDataSetRepService = interface
    ['{A1C517FA-72AD-41D0-A4B6-4195D23ABB41}']
    function GetDataSet(ADataName: string): TDataSet;
    property DataSet[ADataName: string]: TDataSet read GetDataSet;
  end;

  TDataSetRepositoryManager = class(TComponent)
  end;

  TDataSetRepositoryService = class(TComponent)
  end;

  TCustomDataSetRepository = class(TComponent)
  { TODO : 컴포넌트로 제공해 디자인 타임에서 조작할 수 있어야 함 }
  { TODO : 필드 정보를 편집할 수 있어야 한다. }
  private
    FVirtualDataSet: TDataSet;  // design-time에서 필드 정보를 설정하고, DummyData 제공
    FDataName: string;
    function GetDataSet: TDataSet;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property DataName: string read FDataName write FDataName;
    property DataSet: TDataSet read GetDataSet;
  end;

implementation

{ TDataSetRepository }

constructor TCustomDataSetRepository.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TCustomDataSetRepository.Destroy;
begin

  inherited;
end;

function TCustomDataSetRepository.GetDataSet: TDataSet;
begin

end;

end.
