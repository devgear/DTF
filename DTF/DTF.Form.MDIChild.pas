unit DTF.Form.MDIChild;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Form.Base, Vcl.StdCtrls;

type
  TfrmDTFMDIChild = class(TfrmDTFBase)
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FOnMDIDestroy: TNotifyEvent;
    FOnMDIActivate: TNotifyEvent;
  public
    property OnMDIActivate: TNotifyEvent read FOnMDIActivate write FOnMDIActivate;
    property OnMDIDestroy: TNotifyEvent read FOnMDIDestroy write FOnMDIDestroy;
  end;

var
  frmDTFMDIChild: TfrmDTFMDIChild;

implementation

{$R *.dfm}

procedure TfrmDTFMDIChild.FormCreate(Sender: TObject);
begin
  inherited;

  FormStyle := fsMDIChild;
end;

procedure TfrmDTFMDIChild.FormActivate(Sender: TObject);
begin
  inherited;

  if Assigned(FOnMDIActivate) then
    FOnMDIActivate(Sender);
end;

procedure TfrmDTFMDIChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  Action := caFree;
end;

procedure TfrmDTFMDIChild.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(FOnMDIDestroy) then
    FOnMDIDestroy(Sender);
end;

end.
