unit uMinPrioQueue;

{$MODE OBJFPC}
{$ModeSwitch advancedrecords}

interface

uses SysUtils;

type
  TIntegerArray = Array of Integer;

  TNode = record
    name, idx, key: Integer;
    edges: TIntegerArray;
    procedure Init(const aName: Integer; const aEdges: TIntegerArray);
  end;
  TNodeArray = Array of TNode;

  TMinPrioQueue = class(TObject)
  private
    nodes: TNodeArray;
    len, size: Integer;
    procedure Swap(x, y: Integer);
    function Parent(i: Integer): Integer;
    function Left(i: Integer): Integer;
    function Right(i: Integer): Integer;
    procedure Heapify(i: Integer);
  public
    constructor Create;
    procedure Insert(node: TNode; key: Integer);
    procedure DecreaseKey(node: TNode; key: Integer);
    function GetMin: TNode;
  end;

implementation

procedure  TNode.Init(const aName: Integer; const aEdges: TIntegerArray);
begin
  name := aName;  idx := -1;  key := MAXINT;  edges := aEdges;
end;

{
  The first element of nodes is nodes[1]!!
  For Left and Right methods to work we leave a position unoccupied
}
constructor TMinPrioQueue.Create;
begin
  len := 0;  size := 1;
end;

function TMinPrioQueue.Parent(i: Integer): Integer;
begin
  Result := i div 2;
end;

function TMinPrioQueue.Left(i: Integer): Integer;
begin
  Result := 2 * i;
end;

function TMinPrioQueue.Right(i: Integer): Integer;
begin
  Result := 2 * i + 1;
end;

procedure TMinPrioQueue.Swap(x, y: Integer);
var
  tmp: TNode;
begin
  tmp := nodes[x];
  nodes[x] := nodes[y];
  nodes[y] := tmp;
  nodes[x].idx := x;
  nodes[y].idx := y;
end;

procedure TMinPrioQueue.DecreaseKey(node: TNode; key: Integer);
begin
  if  key > nodes[node.idx].key  then
    raise Exception.Create('DecreaseKey: new priority is larger than current one');

  nodes[node.idx].key := key;

  (*  While the parent has less priority exchange the node with it's parent *)
  while  (node.idx > 1)  and  (nodes[Parent(node.idx)].key > nodes[node.idx].key)  do
    Swap(node.idx, Parent(node.idx));
end;

procedure TMinPrioQueue.Insert(node: TNode; key: Integer);
begin
  len := len + 1;
  if  (len >= size)  then
    size := size * 2;
  SetLength(nodes, size);
  node.idx := len;
  nodes[len] := node;
  DecreaseKey(node, key);
end;

procedure TMinPrioQueue.Heapify(i: Integer);
var
  smallest: Integer;
begin
  if  (Left(i) <= len)  and  (nodes[Left(i)].key < nodes[i].key)  then
    smallest := Left(i)
  else
    smallest := i;

  if  (Right(i) <= Len)  and  (nodes[Right(i)].key < nodes[i].key)  then
    smallest := Right(i);

  if  smallest <> i  then
  begin
    Swap(i, smallest);
    Heapify(smallest);
  end;
end;

function TMinPrioQueue.GetMin: TNode;
var
  min: TNode;
begin
  if  len < 1  then
    raise Exception.Create('GetMin: heap underflow');

  min := nodes[1];
  nodes[1] := nodes[len];
  len := len - 1;
  if  (len < size div 2)  then
    size := size div 2;
  SetLength(Nodes, size);
  Heapify(1);

  Result := min;
end;

BEGIN
END.
