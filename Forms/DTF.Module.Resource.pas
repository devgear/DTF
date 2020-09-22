unit DTF.Module.Resource;

interface

uses
  System.SysUtils, System.Classes, Vcl.BaseImageCollection, Vcl.ImageCollection,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList;

type
  TdmResource = class(TDataModule)
    vilToolButton: TVirtualImageList;
    imcToolButton: TImageCollection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmResource: TdmResource;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
