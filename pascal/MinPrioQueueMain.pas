program MinPrioQueueMain;

{$MODE OBJFPC}

uses
  uMinPrioQueue;

type
  TIntegerArray = Array of Integer;

function NewNode(const aName: String; const aEdges: TNodeArray): TNode;
begin
  Result.Init(aName, aEdges);
end;

function NewQueueNode(const aNode: TNode; const aKey: Integer): TQueueNode;
begin
  Result.Init(aNode, aKey);
end;

procedure Main;
var
  queue: TMinPrioQueue;
  n0, n1, n2, n3, min: TNode;
begin
  queue := TMinPrioQueue.Create;
  n0 := NewNode('new york', TNodeArray.Create(n1, n2));
  n1 := NewNode('london', TNodeArray.Create(n2));
  n2 := NewNode('moscu', TNodeArray.Create(n1, n3));
  n3 := NewNode('other city', nil);

  try
    queue.Insert(NewQueueNode(n0, 40);
    queue.Insert(NewQueueNode(n1, 20);
    queue.Insert(NewQueueNode(n2, 10);
    queue.Insert(NewQueueNode(n3, 40);
    min := queue.GetMin;
    DecreaseKey(n2.edges[1], 5);
    min2 := queue.GetMin;
  finally
    queue.Free;
  end;
  WriteLn('min.name=',min.name,' min.idx=',min.idx);
  WriteLn('min2.name=',min2.name,' min2.idx=',min2.idx);
end;

begin
  Main;
end.
