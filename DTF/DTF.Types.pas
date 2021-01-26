unit DTF.Types;

interface

uses
  DMX.DesignPattern,    // using DevMax frameworks(https://github.com/hjfactory/DevMax)
  DTF.Form.MDIChild;

type
  TDTFForm = TDTFMDIChildForm;
  TDTFFormClass = class of TDTFForm;

  TMenuFactory = TClassFactory<string, TDTFFormClass>;

resourcestring
  // DataSet
  SDSDeleteConfirm = '선택한 데이터를 삭제할까요?';

implementation

end.
