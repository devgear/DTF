unit DTF.DAO;

interface

uses
  System.Classes, System.Generics.Collections,
  Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TDaoType = (dtREST, dtFireDAC);
  TDaoParamType = string;

  // 용어 변경 필요
  IDAOParam = interface
    ['{A49A5643-EE85-4911-B2FD-57DAEA7D8350}']
  end;

  IDAO<ItemType, Result, DataType> = interface
    ['{55D91CA7-311B-4059-8422-4D89E4A6CD70}']
    function Get(AParam: IDAOParam): Result;
    function GetItem(AItem: ItemType; AParam: IDAOParam): Result;
    function GetStream(AItem: ItemType; AParam: IDAOParam): TStream;
    function Insert(AParam: IDAOParam; AData: DataType): Result;
    procedure UpdateItem(AItem: ItemType; AParam: IDAOParam; AData: DataType);
    procedure DeleteItem(AItem: ItemType; AParam: IDAOParam);


  end;

//  TDaoParam = class(TInterfacedObject, IDAOParam)
//  end;
//
//  TDaoParamClass = class of TDaoParam;

implementation

initialization

finalization

end.
