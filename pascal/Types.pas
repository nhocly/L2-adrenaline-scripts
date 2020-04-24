unit Types

interface

type
  TIntegerArray = Array of Integer;

  TNode = record
    name: String;
    idx: Integer;
    edges: TNodeArray;
    procedure Init(const aName: Integer; const aEdges: TNodeArray);
  end;
  TNodeArray = Array of TNode;

implementation

end.
