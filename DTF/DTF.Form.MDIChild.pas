unit DTF.Form.MDIChild;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DTF.Form.Base, Vcl.StdCtrls;

type
  TDTFMDIChildForm = class(TDTFBaseForm)
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FOnMDIDestroy: TNotifyEvent;
    FOnMDIActivate: TNotifyEvent;
  public
    property OnMDIActivate: TNotifyEvent read FOnMDIActivate write FOnMDIActivate;
    property OnMDIDestroy: TNotifyEvent read FOnMDIDestroy write FOnMDIDestroy;
  end;

implementation

{$R *.dfm}

procedure TDTFMDIChildForm.FormActivate(Sender: TObject);
begin
  inherited;

  if Assigned(FOnMDIActivate) then
    FOnMDIActivate(Sender);
end;

procedure TDTFMDIChildForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  Action := caFree;
end;

procedure TDTFMDIChildForm.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(FOnMDIDestroy) then
    FOnMDIDestroy(Sender);
end;

end.
