unit ViewFactory;

interface

uses
  DTF.Builder.Factory, Vcl.Forms;

type
  TViewFactory = TAbstractFactory<string, TFormClass>;

implementation

initialization
finalization
  TViewFactory.Instance.Release;

end.
