unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    TreeView1: TTreeView;
    Button1: TButton;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure TreeView1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  I, J: Integer;
  Group, Menu: TTreeNode;
begin
  TreeView1.DragMode := dmAutomatic;

  for I := 0 to 9 do
  begin
    Group := TreeView1.Items.Add(nil, 'Group #' + IntToStr(I));
    for J := 0 to 4 do
    begin
      Menu := TreeView1.Items.AddChild(Group, 'Menu #' + IntToStr(I) + ' / ' + IntToStr(J));
    end;
  end;

  TreeView1.FullExpand;

  TreeView1.MultiSelect := True;
  TreeView1.MultiSelectStyle := [msControlSelect, msShiftSelect];
end;

procedure TForm1.TreeView1DragDrop(Sender, Source: TObject; X, Y: Integer);
  function Sort(AList: TArray<TTreeNode>): TArray<TTreeNode>;
  var
    I, J, Idx: Integer;
    Item: TTreeNode;
    Temps: TArray<TTreeNode>;
  begin
    SetLength(Temps, Length(AList));

    for I := 0 to Length(AList) - 1 do
    begin
      Idx := I;
      Item := AList[I];

      // Temps에는 I-1개가 담겨 있음
      for J := 0 to I-1 do
      begin
        // 이번에 담을 것이 기존에 담긴 것보다 작으면
        if Item.Index < Temps[J].Index then
        begin
          Idx := J;
          Break;
        end;
      end;
      if Idx <> I then
      begin
        for J := I-1 downto Idx do
          Temps[J+1] := Temps[J];
      end;

      Temps[Idx] := AList[I];
    end;

    Result := Temps;
  end;
var
  I: Integer;
  Src, Dst: TTreeNode;
  Selections: TArray<TTreeNode>;
begin
  if TreeView1.SelectionCount = 1 then
  begin
    Src := TreeView1.Selected;
    Dst := TreeView1.GetNodeAt(X, Y);

    if Dst.Level = 0 then
      Src.MoveTo(Dst, naAddChild)
    else
      Src.MoveTo(Dst, naInsert);
  end
  else
  // Multi select
  begin
    Dst := TreeView1.GetNodeAt(X, Y);
    SetLength(Selections, TreeView1.SelectionCount);

    // 정렬
    for I := 0 to TreeView1.SelectionCount - 1 do
      Selections[I] := TreeView1.Selections[I];
    Selections := Sort(Selections);

    for I := 0 to Length(Selections) - 1 do
    begin
      Src := Selections[I];
      if Dst.Level = 0 then
        Src.MoveTo(Dst, naAddChild)
      else
        Src.MoveTo(Dst, naInsert);

      OutputDebugString(PChar(Format('%d / %d(%s)', [Dst.Index, Src.Index, Src.Text])));
    end;


//    TreeView1.GetSelections()
  end;
end;

procedure TForm1.TreeView1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  Src, Dst: TTreeNode;
begin
  Src := TreeView1.Selected;
  Dst := TreeView1.GetNodeAt(X, Y);

  Accept := Assigned(Dst) and (Src <> Dst) and (Src.Level > 0);
end;

end.
