{
  DTF.Repository

  도메인(구현하고자 하는 무제)과 데이터 사이를 중재하는 매핑 레이어

  일관된 인터페이스로 다양한 데이터 제공을 위한 객체


  데이터 인터페이스 제공 + 집계정보(Aggregate) 제공

  퍼시스턴스 로직은 DAO가 담당
  즉, 동일한 인터페이스로 RDBMS 또는 RestAPI 등의 데이터와 연동 가능

  https://imcreator.tistory.com/105
  http://aeternum.egloos.com/1160846

}
unit DTF.Repository;

interface

type
  TRepository = class(TInterfacedObject)
  private
  public
  end;

implementation

end.
