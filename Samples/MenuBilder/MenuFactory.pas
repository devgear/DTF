unit MenuFactory;

interface

uses
  DTF.Builder.Factory, Vcl.Forms;

type
  TMenuFactory = TAbstractFactory<string, TFormClass>;

implementation

initialization
finalization
  TMenuFactory.Instance.Release;

end.
