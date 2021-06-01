unit MenuTypes;

interface
uses
  Vcl.ComCtrls;

type
  TMenuNode = class(TTreeNode)
  private
    FCode: string;
    FParentCode: string;
    FSortIndex: Integer;
    procedure SetCode(const Value: string);
  public
    property Code: string read FCode write SetCode;
    property SortIndex: Integer read FSortIndex write FSortIndex;
    property ParentCode: string read FParentCode write FParentCode;
  end;

implementation

{ TMenuNode }

procedure TMenuNode.SetCode(const Value: string);
begin
  FCode := Value;
end;

end.
